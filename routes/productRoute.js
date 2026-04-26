import express from "express"
import { deleteProduct, getByuserProduct, getByuserSoldProduct, getProduct,getProduct2,getProductbyid,getSimilarProduct,markAsSold,postProduct, updateProduct,getAllProduct,adminUpdateProduct } from "../controllers/productController.js"
import auth from "../middleware/authMiddleware.js"
import multer from 'multer'
import admin from "../middleware/adminMiddleware.js"

const upload = multer({ storage: multer.memoryStorage() })


const router = express.Router()
router.get("/latestProduct",auth,getProduct)
router.get("/getProduct",auth,getProduct2)
router.get("/allproduct",auth,getAllProduct)
router.post("/postProduct",auth,upload.array('images', 5),postProduct)
router.delete("/:product_id",auth,deleteProduct)
router.put("/update",auth,upload.array('images', 5),updateProduct)
router.get("/:product_id",auth,getProductbyid)
router.get("/similar/:sub_category_id/:product_id",auth,getSimilarProduct)
router.get("/active_product/:user_id",auth,getByuserProduct)
router.get("/sold_product/:user_id",auth,getByuserSoldProduct)
router.put("/sold/:product_id",auth,markAsSold)
router.put('/admin/update/:product_id', auth, admin, adminUpdateProduct)


export default router
