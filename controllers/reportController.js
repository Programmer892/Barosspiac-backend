import pool from "../config/db.js"
import dotenv from "dotenv"
import { createNotification } from "../utils/notifications.js"


async function postReport(req, res) {


    const user_id = req.user.user_id
    const {text,product_id,reported_id,reason} = req.body
    console.log(reason);
    
    try {
 
        await pool.query('INSERT INTO `reports` (`report_id`, `reporter_id`, `reported_id`, `product_id`, `text`, `sending_date`, `reason`) VALUES (NULL,?,?,?,?,current_timestamp(),?)',[user_id,reported_id,product_id,text,reason]);
        const notificationMessage = product_id ? `Az adminisztrátor megvizsgálja az egyik hirdetésedet` : `Az adminisztrátor megvizsgálja a profilodat`
        await createNotification(reported_id, 'report', notificationMessage, product_id ? `/product/${product_id}` : `/profile/${reported_id}`)
        return res.status(200).json({ message: "Sikeres jelentés" });
 
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }

export {postReport}