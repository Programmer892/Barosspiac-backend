import pool from "../config/db.js"



const getMessages = async (req, res) => {
    const { conversations_id } = req.params

    try {
        const [messages] = await pool.query(
            `SELECT 
                m.message_id,
                m.message,
                m.sent_at,
                m.sender_id,
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

async function postMessage(req, res) {

    const { conversation_id, sender_id, message } = req.body;
   
    console.log(reason);
    
    try {
 
        await pool.query("INSERT INTO messages (conversations_id, sender_id, message, sent_at) VALUES (?, ?, ?, current_timestamp())",[conversation_id, sender_id, message]);
 
        return res.status(200).json({ message: "Üzenet elküldve" });
 
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }



export {getMessages}