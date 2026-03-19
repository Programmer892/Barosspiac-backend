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
    const {product_id}  = req.params;
    
 
    try {

 
        const [result] = await pool.query(`SELECT DISTINCT * FROM likes INNER JOIN product ON product.product_id = likes.product_id where likes.user_id = ?`,[user_id,product_id]);
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