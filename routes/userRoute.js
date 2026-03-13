import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser, userallInformation, updatePassword} from "../controllers/userController.js"
import auth from "../middleware/authMiddleware.js"


const router = express.Router()
router.post("/register",userRegister)
router.post("/login",userLogin)
router.post("/logout",auth,logout)
router.get("/statistic/:user_id",auth,userallInformation)
router.get("/me",auth,getUser)
router.post("/user",auth,updateUser)
router.delete("/:user_id",auth,userDelete)
router.post("/password",auth,updatePassword)


export default router