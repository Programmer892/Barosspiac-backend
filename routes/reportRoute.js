import express from "express"
import auth from "../middleware/authMiddleware.js"
import { postReport } from "../controllers/reportController.js"

const router = express.Router()

router.post("/report",auth,postReport)


export default router