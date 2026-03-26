import express from "express"
import auth from "../middleware/authMiddleware.js"
import { getConversation, postConversation } from "../controllers/conversationController.js"


const router = express.Router()


router.get("/conversations",auth,getConversation)
router.post("/conversation",auth,postConversation)








export default router