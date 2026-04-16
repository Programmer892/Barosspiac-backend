import pool from "../config/db.js";

const getStatistics = async (req, res) => {
    try {

        const [response] = await pool.query('SELECT  (SELECT COUNT(*) FROM users) AS total_users, (SELECT COUNT(*) FROM product) AS total_products, (SELECT COUNT(*) FROM product WHERE product.is_sold = false) AS active_products, (SELECT COUNT(*)  FROM users  WHERE DATE(users.created_at) = CURDATE()) AS today_users, (SELECT COUNT(*) FROM reports WHERE reports.status = "pending") AS "active_reports"')
        res.status(200).json(response[0]);

    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'Szerver hiba', error: error.message })     
    }
}
export {getStatistics}