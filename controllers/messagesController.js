import pool from "../config/db.js"



const getMessages = async (req, res) => {
    const { conversations_id } = req.params

    try {
        const [messages] = await pool.query(
            `SELECT 
                m.*,
                u.fullname
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
    //console.log(user_id);
    
    try {

        const [messages] = await pool.query(
              `SELECT conversations_id, COUNT(*) as unread_count
                FROM messages
                WHERE sender_id != ?
                AND read_at IS NULL 
                GROUP BY conversations_id;`, [user_id])

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
        
       return res.status(200).json({ message: `${result.affectedRows} üzenet olvasottként jelölve` })

    } catch (error) {
            return res.status(500).json({ message: 'Szerver hiba', error: error.message })      
    }

}


    export { getMessages, getUnreadedMessages, markMessagesAsRead }