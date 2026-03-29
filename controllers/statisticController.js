import pool from "../config/db.js";

const getStatistics = async (req, res) => {
    try {

        const [response] = await pool.query('SELECT (SELECT COUNT(*) FROM users) AS total_users, (SELECT COUNT(*) FROM product) AS total_products');
        res.status(200).json(response[0]);

    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })     
    }
}
export {getStatistics}