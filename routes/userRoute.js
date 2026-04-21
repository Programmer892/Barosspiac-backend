import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser, userallInformation, updatePassword, updateNotifications, updatePfp, deletePfp, getAllUser} from "../controllers/userController.js"
import auth from "../middleware/authMiddleware.js"
import admin from "../middleware/adminMiddleware.js"
import multer from 'multer'
import { getallLikes } from "../controllers/likeController.js"

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
router.post("/profile_pic",auth,upload.single('profilePic'),updatePfp)
router.delete("/profile_pic",auth,deletePfp)
router.get('/alluser',auth,getAllUser)



export default router