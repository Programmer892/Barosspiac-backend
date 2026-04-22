import pool from "../config/db.js"
import { io } from '../server.js'  


const getMessages = async (req, res) => {
    const { conversations_id } = req.params

    try {
        const [messages] = await pool.query(
            `SELECT 
                m.*,
                u.fullname,
                u.pfp
             FROM messages m
             JOIN users u ON m.sender_id = u.user_id
             WHERE m.conversations_id = ?
             ORDER BY m.sent_at ASC`,
            [conversations_id]
        )

        res.status(200).json(messages)

    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}

const getUnreadedMessages = async (req, res) => {
    const user_id = req.user.user_id

    try {
        const [messages] = await pool.query(
            `SELECT 
                m.conversations_id, 
                COUNT(*) as unread_count
             FROM messages m
             JOIN conversations c ON c.conversations_id = m.conversations_id
             WHERE m.sender_id != ?
             AND m.read_at IS NULL
             AND (c.user1_id = ? OR c.user2_id = ?)
             GROUP BY m.conversations_id`,
            [user_id, user_id, user_id]
        )

        return res.status(200).json(messages)

    } catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}


const markMessagesAsRead = async (req, res) => {
    const { conversations_id } = req.params
    const user_id = req.user.user_id

    try {
        
        const [result] = await pool.query(
            `UPDATE messages
             SET read_at = NOW(), message_status = 'Olvasva'
             WHERE conversations_id = ?
             AND sender_id != ?
             AND read_at IS NULL`, [conversations_id, user_id]
        )
        
        io.to(String(conversations_id)).emit('messages_read', { conversation_id: Number(conversations_id) })
       return res.status(200).json({ message: `${result.affectedRows} üzenet olvasottként jelölve` })

    } catch (error) {
            console.log(error);
            return res.status(500).json({ message: 'Szerver hiba', error: error.message })      
    }

}


    export { getMessages, getUnreadedMessages, markMessagesAsRead }