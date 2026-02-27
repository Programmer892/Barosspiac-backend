import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser} from "../controllers/userController.js"
import auth from "../middleware/authMiddleware.js"


const router = express.Router()
router.post("/register",userRegister)
router.post("/login",userLogin)
router.post("/logout",auth,logout)
router.get("/me",auth,getUser)
router.post("/:user_id",auth,updateUser)
router.delete("/:user_id",auth,userDelete)


export default router