import pool from '../config/db.js'


const getConversation = async (req, res) => {
    const user_id = req.user.user_id

    try {
        const [response] = await pool.query(
            `SELECT 
        c.*,
        CASE WHEN c.user1_id = ? THEN u2.fullname ELSE u1.fullname END AS fullname,
        CASE WHEN c.user1_id = ? THEN u2.pfp ELSE u2.pfp END AS pfp,
        m.message,
        m.sent_at
     FROM conversations c
     JOIN users u1 ON c.user1_id = u1.user_id
     JOIN users u2 ON c.user2_id = u2.user_id
     LEFT JOIN messages m ON m.message_id = (
         SELECT MAX(message_id) FROM messages WHERE conversations_id = c.conversations_id
     )
     WHERE c.user1_id = ? OR c.user2_id = ?
     ORDER BY m.sent_at DESC`,
            [user_id, user_id, user_id,user_id]
        )

        res.status(200).json(response)

    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}


async function postConversation(req, res) {
    const user1_id = req.user.user_id
    const {user2_id} = req.body;

   
    try {
        const [exist] = await pool.query(`SELECT *,users.fullname FROM conversations INNER JOIN users ON users.user_id = ? WHERE (user1_id = ? AND user2_id = ?) OR (user2_id = ? AND user1_id = ?)`, [user2_id,user1_id, user2_id, user1_id, user2_id])
        console.log(exist);
        if (exist.length > 0) {
            return res.status(200).json(exist[0])
        }
        await pool.query("INSERT INTO `conversations`(`user1_id`, `user2_id`) VALUES (?,?)",[user1_id,user2_id]);
 
        return res.status(200).json({ message: "Üzenet elküldve" });
 
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
 }




export { getConversation,postConversation }