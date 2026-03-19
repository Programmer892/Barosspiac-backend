import pool from "../config/db.js"



const getMessages = async (req, res) => {
    const {conversations_id} = req.params
    const {user2_id} = req.params
    const user_id = req.user.user_id
    console.log(conversations_id);
    console.log(user2_id);

    try {
        const [user1] = await pool.query("SELECT messages.message,messages.sent_at,messages.message_id FROM `messages` WHERE sender_id = ? AND conversations_id = ?  ORDER BY `sent_at` DESC",[user_id,conversations_id]);
        const [user2] = await pool.query("SELECT messages.message,messages.sent_at,messages.message_id FROM `messages` WHERE sender_id = ? AND conversations_id = ?  ORDER BY `sent_at` DESC",[user2_id,conversations_id]);
        
       res.status(200).json({user1: user1,user2:user2});
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
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