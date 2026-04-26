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




const getReports = async (req, res) => {
    const page = Number(req.query.page) || 1
    const limit = 10
    const offset = (page - 1) * limit

    try {
        const [rows] = await pool.query(`
            SELECT 
                reports.*,
                reporter.fullname AS reporter_name,
                reporter.email AS reporter_email,
                reported.fullname AS reported_name,
                p.product_title
            FROM reports
            JOIN users reporter ON reporter.user_id = reports.reporter_id
            LEFT JOIN users reported ON reported.user_id = reports.reported_id
            LEFT JOIN product p ON p.product_id = reports.product_id
            ORDER BY reports.sending_date DESC
            LIMIT ? OFFSET ?
        `, [limit, offset])

        const [[{ total }]] = await pool.query("SELECT COUNT(*) as total FROM reports")

        res.status(200).json({
            reports: rows,
            total,
            totalPages: Math.ceil(total / limit),
            currentPage: page
        })

    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}

const updateReportStatus = async (req, res) => {
    const { report_id } = req.params
    const { status } = req.body

    try {
        await pool.query(
            'UPDATE reports SET status = ? WHERE report_id = ?',
            [status, report_id]
        )
        res.status(200).json({ message: 'Státusz frissítve' })
    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}

const deleteReport = async (req, res) => {
    const { report_id } = req.params
    try {
        await pool.query('DELETE FROM reports WHERE report_id = ?', [report_id])
        res.status(200).json({ message: 'Jelentés törölve' })
    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}

export { postReport, getReports, updateReportStatus, deleteReport }