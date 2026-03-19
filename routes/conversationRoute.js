import express from "express"
import auth from "../middleware/authMiddleware.js"
import { getConversation } from "../controllers/conversationController.js"


const router = express.Router()


router.get("/conversations",auth,getConversation)








export default router