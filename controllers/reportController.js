import pool from "../config/db.js"
import dotenv from "dotenv"


async function postReport(req, res) {


    const user_id = req.user.user_id
    const {text,product_id,reported_id,reason} = req.body
    try {
 
        await pool.query('INSERT INTO `reports` (`report_id`, `reporter_id`, `reported_id`, `product_id`, `text`, `sending_date`, `reason`) VALUES (NULL,?,?,?,?,current_timestamp(),?)',[user_id,reported_id,product_id,text,reason]);
 
        return res.status(200).json({ message: "Sikeres jelentés" });
 
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }

export {postReport}