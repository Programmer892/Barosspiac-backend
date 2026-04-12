import pool from '../config/db.js';

export const createNotification = async (user_id, type, message, link) => {
    await pool.query(
        'INSERT INTO notifications (user_id, type, message, link) VALUES (?, ?, ?, ?)',
        [user_id, type, message, link]
    )
}