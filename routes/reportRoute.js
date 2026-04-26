import express from "express"
import auth from "../middleware/authMiddleware.js"
import admin from "../middleware/adminMiddleware.js"
import { postReport,getReports,updateReportStatus,deleteReport} from "../controllers/reportController.js"

const router = express.Router()

router.post("/report",auth,postReport)
router.get('/all', auth, admin, getReports)
router.put('/status/:report_id', auth, admin, updateReportStatus)
router.delete('/delete/:report_id', auth, admin, deleteReport)


export default router