import pool from '../config/db.js'


const getConversation = async (req, res) => {
    const user_id = req.user.user_id

    try {
        const [response] = await pool.query("SELECT conversations.*,users.fullname FROM `conversations` INNER JOIN users ON users.user_id = conversations.user2_id WHERE conversations.user1_id = ?;",[user_id]);
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}




export {getConversation}