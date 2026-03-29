import express from "express"
import auth from "../middleware/authMiddleware.js"
import { getStatistics } from "../controllers/statisticController.js"



const router = express.Router()

router.get("/statistics",auth,getStatistics)

export default router