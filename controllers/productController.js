import pool from "../config/db.js"
import bcrypt from "bcryptjs"
import jwt from "jsonwebtoken"
import dotenv from "dotenv"
import { error } from "console"
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

const getProduct2 = async (req, res) => {
    try {
        const [response] = await pool.query("SELECT * FROM `product` INNER JOIN main_categories ON main_categories.category_id = product.category_id ORDER BY `product`.`product_upload` DESC LIMIT 20");
       
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}


async function postProduct(req,res) 
{

   const user_id =  req.users.user_id;


   const {product_title,product_desc,product_price,product_condition,product_collpoint,product_size,product_subject,product_class,category_id,sub_category_id,sub_subcategory_id,is_sold} = req.body

   try {
    

    const res = await pool.query("INSERT INTO `product` (`product_id`, `user_id`, `product_title`, `product_desc`, `product_price`, `product_condition`, `product_collpoint`, `product_size`, `product_subject`, `product_class`, `category_id`, `sub_category_id`, `sub_sub_category_id`, `is_sold`, `product_upload`) VALUES (NULL, '', '', '', '', '', '', NULL, NULL, NULL, '', '', '', '0', current_timestamp())",[user_id,product_title,product_desc,product_price,product_condition,product_collpoint,product_size,product_subject,product_class,category_id,sub_category_id,sub_subcategory_id,is_sold])
    console.log(res);
    return res.status(200).json({message: "Sikeres feltöltés!"})  
  
   } catch (error) {
    console.log(error);
    return  res.status(500).json({message: "Szerver hiba", error:error.message})
   }
}

async function deleteProduct(req,res)
{
    const {product_id} = req.product.product_id;
    req.user.user_id;
   
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
    const {product_id} = req.product.product_id;
    const { user_id } = req.user.user_id;
    const {product_price, product_upload, product_desc, product_collpoint, product_title, category_id, product_condition, product_size, product_subject, product_class} = req.body;

    if (!user_id) {
        return res.status(400).json({ message: 'Nincs ilyen felhasználó' });
    }

    try {
        const [result] = await pool.query(
            "UPDATE `product` SET `product_desc` = '', `product_collpoint` = '', `product_title` = '', `product_condition` = '', `product_size` = '', `product_subject` = '', `product_class` = '' WHERE `product`.`product_id` = ?",
            [product_id,product_price, product_desc, product_collpoint, product_title, category_id, product_condition, product_size, product_subject, product_class]
        );
       

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Termék nem található' });
        }

        res.status(200).json({ message: 'Sikeres változtatás' });
    } catch (error) {
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
};



export {getProduct,postProduct,deleteProduct,updateProduct,getProduct2}

