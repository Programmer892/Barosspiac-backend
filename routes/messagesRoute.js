import express from "express"
import auth from "../middleware/authMiddleware.js"
import { getMessages, getUnreadedMessages, markMessagesAsRead } from "../controllers/messagesController.js"



const router = express.Router()


router.get("/message/:conversations_id",auth,getMessages)
router.get("/unreaded",auth,getUnreadedMessages)
router.put("/read/:conversations_id",auth,markMessagesAsRead)
export default router


