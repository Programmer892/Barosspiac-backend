import express from "express"
import {userRegister,userLogin, logout, userDelete, getUser, updateUser} from "../controllers/userController.js"
import { deleteProduct, getProduct,getProduct2,postProduct, updateProduct } from "../controllers/productController.js"
import auth from "../middleware/authMiddleware.js"


const router = express.Router()
router.get("/latestProduct",getProduct)
router.get("/getProduct",getProduct2)
router.post("/postProduct",postProduct)
router.delete("/:product_id",auth,deleteProduct)
router.post("/:product_id",updateProduct)



export default router
