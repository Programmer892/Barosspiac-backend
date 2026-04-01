import pool from "../config/db.js"
import dotenv from "dotenv"
import cloudinary from "../config/cloudinary.js"



dotenv.config()




const getProduct = async (req, res) => {
    try {
        const [response] = await pool.query("SELECT * FROM `product` INNER JOIN main_categories ON main_categories.category_id = product.category_id ORDER BY `product`.`product_upload` DESC LIMIT 10");
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

const getByuserProduct = async (req, res) => {
    const {user_id} = req.params
    try {
        const [response] = await pool.query("SELECT * FROM `product` INNER JOIN main_categories ON main_categories.category_id = product.category_id WHERE user_id = ? AND is_sold = 0 ",[user_id]);
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

const getByuserSoldProduct = async (req, res) => {
    const {user_id} = req.params
    try {
        const [response] = await pool.query("SELECT * FROM `product` INNER JOIN main_categories ON main_categories.category_id = product.category_id WHERE user_id = ? AND is_sold = 1 ",[user_id]);
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

const getProduct2 = async (req, res) => {


    try {
        const [response] = await pool.query("SELECT product.*,productimg.*, main_categories.category_name, sub_category.sub_category_name, subsubcategory.sub_sub_name, users.fullname, users.userClass, users.pfp, COUNT(l.user_id) AS is_liked FROM product INNER JOIN main_categories ON main_categories.category_id = product.category_id INNER JOIN sub_category ON sub_category.sub_category_id = product.sub_category_id INNER JOIN subsubcategory ON subsubcategory.sub_sub_category_id = product.sub_sub_category_id INNER JOIN users ON users.user_id = product.user_id LEFT JOIN likes l ON l.product_id = product.product_id INNER JOIN productimg ON productimg.product_id = product.product_id  GROUP BY product.product_id;");
       
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}


async function postProduct(req,res) 
{
    try {
        const { title, desc, price, condition, size, subject, collpoint, category_id, sub_category_id, sub_sub_category_id } = req.body;
        const user_id = req.user.user_id;
        //console.log(cloudinary);
        //console.log(cloud.uploader);

        if (price < 0) {
            return res.status(400).json({message: "Nem lehet negatív a termék ára",errorField: "price"})
        }

        if (title.length < 3) {
            return res.status(400).json({message: "A termék neve túl rövid",errorField: "title"})
        }

        
    
        const uploadedUrls = []
        for (const file of req.files) {
            const result = await new Promise((resolve, reject) => {
                const stream = cloudinary.uploader.upload_stream(
                    { folder: "barosspiac" },
                    (error, result) => error ? reject(error) : resolve(result)
                )
                stream.end(file.buffer)
            })
            uploadedUrls.push(result.secure_url)
        }

        // Termék mentése DB-be
        const [dbResult] = await pool.query(
            `INSERT INTO product 
            (user_id, product_title, product_desc, product_price, product_condition, product_size, product_subject, product_collpoint, category_id, sub_category_id, sub_sub_category_id) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [user_id, title, desc || "Leírás nincs megadva", price, condition, size || null, subject || null, collpoint, category_id, sub_category_id, sub_sub_category_id]
        )

        const product_id = dbResult.insertId

        // Képek mentése DB-be
        for (const url of uploadedUrls) {
            await pool.query(
                'INSERT INTO productimg (product_id, product_img) VALUES (?, ?)',
                [product_id, url]
            )
        }

        res.status(201).json({ message: "Termék sikeresen feltöltve", product_id })

    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerver hiba", error: error.message })
    }
    
}

async function deleteProduct(req,res)
{
    const {product_id} = req.params
   
   
    try {
        const [result] = await pool.query("DELETE FROM product WHERE `product`.`product_id` = ?", [product_id]);
     
        if(result.affectedRows === 0){
            return res.status(404).json({message: 'Termék nem található'});
        }
        res.status(200).json({message: 'Termék sikeresen törölve'});
    } catch (error) {
         res.status(500).json({message: "Szerver hiba", error: error.message})
    }
    
}


const updateProduct = async (req, res) => {
   
    const {user_id} = req.body;
    console.log(user_id);

     
    
    const {product_id,product_title,product_desc,product_price,product_condition,product_collpoint,product_size,product_subject,product_class,category_id,sub_category_id,sub_sub_category_id,is_sold} = req.body;

    console.log(product_id);

    try {
        const [result] = await pool.query("UPDATE `product` SET `product_title` = ?, `product_desc` = ?, `product_price` = ?, `product_condition` = ?, `product_collpoint` = ?, `product_size` = ?, `product_subject` = ?, `product_class` = ?, `category_id` = ?, `sub_category_id` = ?, `sub_sub_category_id` = ?, `is_sold` = ? WHERE `product`.`product_id` = ?",[product_title,product_desc,product_price,product_condition,product_collpoint,product_size,product_subject,product_class,category_id,sub_category_id,sub_sub_category_id,is_sold,product_id]);
       
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Termék nem található' });
        }

        res.status(200).json({ message: 'Sikeres változtatás' });
    } catch (error) {
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
};

const getProductbyid = async (req,res) => 
    {

        const {product_id} = req.params


        
        console.log(product_id);
        
        try {
            const [response] = await pool.query("SELECT p.*, mc.category_name, sc.sub_category_name, ssc.sub_sub_name, u.fullname,u.userClass FROM product p INNER JOIN main_categories mc ON mc.category_id = p.category_id INNER JOIN sub_category sc ON sc.sub_category_id = p.sub_category_id INNER JOIN subsubcategory ssc ON ssc.sub_sub_category_id = p.sub_sub_category_id INNER JOIN users u ON u.user_id = p.user_id  WHERE p.product_id = ?" , [product_id] )
           const [images] = await pool.query("SELECT * FROM `productimg` WHERE product_id = ?",[product_id])
           

            console.log(response);

            if (response.length === 0) {
                return res.status(404).json({ message: "Nincs ilyen termék" });
            }
           
            
           res.status(200).json({product_details: response,image: images});
           
        }
        catch (error) {
            return res.status(500).json({ message: 'Szerver hiba', error: error.message });
        }

    }


    const getSimilarProduct = async (req,res) => 
        {
    
            const {sub_category_id,product_id} = req.params
         
            
            try {
                const [response] = await pool.query("SELECT p.*, mc.category_name, sc.sub_category_name, ssc.sub_sub_name, u.fullname,u.userClass FROM product p INNER JOIN main_categories mc ON mc.category_id = p.category_id INNER JOIN sub_category sc ON sc.sub_category_id = p.sub_category_id INNER JOIN subsubcategory ssc ON ssc.sub_sub_category_id = p.sub_sub_category_id INNER JOIN users u ON u.user_id = p.user_id  WHERE p.product_id != ? AND sc.sub_category_id = ? LIMIT 4" , [product_id,sub_category_id] )
                console.log(response);
    
                if (response.length === 0) {
                    return res.status(404).json({ message: "Nincs ilyen termék" });
                }
               
                
               res.status(200).json(response);
               
            }
            catch (error) {
                return res.status(500).json({ message: 'Szerver hiba', error: error.message });
            }
    
        }

        const markAsSold = async (req,res) => 
            {
        
                const {product_id} = req.params
                const {is_sold} = req.body 
        
                try {
                   const [response] = await pool.query("UPDATE `product` SET `is_sold`= ? WHERE product_id = ?" , [is_sold,product_id] )
                 
                   res.status(201).json(response);
                   
                }
                catch (error) {
                    return res.status(500).json({ message: 'Szerver hiba', error: error.message });
                }
        
            }
    





export {getProduct,postProduct,deleteProduct,updateProduct,getProduct2,getProductbyid,getSimilarProduct,getByuserProduct,getByuserSoldProduct,markAsSold}

