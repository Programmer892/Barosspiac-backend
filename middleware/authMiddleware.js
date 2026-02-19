import jwt from "jsonwebtoken"
import pool from "../config/db.js"

const auth = async (req,res,next) => 
    {
    const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ message: 'Nincs token' });
    }
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const [rows] = await pool.query("SELECT user_id, email, psw FROM users WHERE user_id = ?", [decoded.id]);
        if (rows.length === 0) {
            return res.status(401).json({ message: 'Hibás token' });
        }
        req.user = rows[0];
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Érvénytelen token', error: error.message });
    }

    }


    export default auth;