import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser} from "../controllers/userController.js"
import { deleteProduct, getProduct,postProduct, updateProduct } from "../controllers/productController.js"
import auth from "../middleware/authMiddleware.js"
import { getCategory } from "../controllers/categoryController.js"




const router = express.Router()


router.get("/getCategory",getCategory)

export default router