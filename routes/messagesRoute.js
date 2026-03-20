import express from "express"
import auth from "../middleware/authMiddleware.js"
import { getMessages } from "../controllers/messagesController.js"



const router = express.Router()


router.get("/message/:conversations_id",auth,getMessages)

export default router


