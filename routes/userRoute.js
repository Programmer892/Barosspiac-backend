import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser, userallInformation, updatePassword, updateNotifications} from "../controllers/userController.js"
import auth from "../middleware/authMiddleware.js"
import admin from "../middleware/adminMiddleware.js"
import multer from 'multer'

const upload = multer({ storage: multer.memoryStorage() })

const router = express.Router()
router.post("/register",userRegister)

router.post("/login",userLogin)
router.post("/logout",auth,logout)
router.get("/statistic/:user_id",auth,userallInformation)
router.get("/me",auth,getUser)
router.post("/user",auth,updateUser)
router.delete("/delete",auth,userDelete)
router.put("/password",auth,updatePassword)
router.put("/notification",auth,updateNotifications)


export default router