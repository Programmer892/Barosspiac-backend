import express, { Router } from "express"
import auth from "../middleware/authMiddleware.js"
import { getNotifications, markNotificationAsRead, markAllNotificationsAsRead,deleteNotification } from "../controllers/notificationController.js"

const router = express.Router()

router.get("/notifications", auth, getNotifications)
router.put("/read/:notification_id", auth, markNotificationAsRead)
router.put("/read-all", auth, markAllNotificationsAsRead)
router.delete("/delete/:notification_id", auth, deleteNotification)

export default router