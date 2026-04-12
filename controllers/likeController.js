import pool from "../config/db.js"
import dotenv from "dotenv"


async function getLikes(req, res) {

    const user_id = req.user.user_id
    const {product_id}  = req.params;

 
    try {
 
        const [result] = await pool.query(`SELECT * FROM likes WHERE user_id = ? AND product_id = ?`,[user_id,product_id]);
        console.log(result);

        if (result.length > 0) {
            return res.status(200).json({liked: true})
        }
        else {
            return res.status(200).json({liked: false})
        }
 
       
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }



 async function getallLikes(req, res) {

    const user_id = req.user.user_id
 
    
 
    try {

 
        const [result] = await pool.query(`SELECT 
    product.*,
    productimg.product_img,
    main_categories.category_name,
    sub_category.sub_category_name,
    subsubcategory.sub_sub_name,
    users.fullname,
    users.userClass,
    users.pfp,
    COUNT(l.user_id) AS is_liked
FROM product
INNER JOIN main_categories ON main_categories.category_id = product.category_id
INNER JOIN sub_category ON sub_category.sub_category_id = product.sub_category_id
INNER JOIN subsubcategory ON subsubcategory.sub_sub_category_id = product.sub_sub_category_id
INNER JOIN users ON users.user_id = product.user_id
LEFT JOIN likes l ON l.product_id = product.product_id AND l.user_id = ?
LEFT JOIN productimg ON productimg.product_id = product.product_id
WHERE l.user_id = ?
GROUP BY product.product_id
ORDER BY product.product_upload DESC`,[user_id, user_id]);
        console.log(result);

        res.status(200).json(result)
 
       
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }


 async function deleteLike(req, res) {

    const user_id = req.user.user_id
    const {product_id}  = req.params;

 
    try {
 
        const [result] = await pool.query(`DELETE FROM likes WHERE likes.user_id = ? AND likes.product_id = ?`,[user_id,product_id]);

        res.status(200).json({message:"Sikeresen törölve a kedvencek közül"});
 
       
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }

 async function deleteAllLike(req, res) {

    const user_id = req.user.user_id


 
    try {
 
        await pool.query(`DELETE FROM likes WHERE user_id = ? `,[user_id]);

        res.status(200).json({message:"Minden kedvelés sikeresen törölve"});
 
       
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }


 async function postLikes(req, res) {

    
    const {product_id}  = req.body;
    const user_id = req.user.user_id
   
 
    try {
 
        const [response] = await pool.query(`INSERT INTO likes (user_id, product_id) VALUES (?,?)`,[user_id,product_id]);
       


        return res.status(200).json({message:"Sikeresen hozzáadva a kedvencekhez"});
 
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }


 export {getLikes,postLikes,deleteLike,getallLikes,deleteAllLike}