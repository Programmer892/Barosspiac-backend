import express, { Router } from "express"
import auth from "../middleware/authMiddleware.js"
import { deleteOrder, getOrder, getOrderById, postOrder, updateOrder } from "../controllers/orderController.js"

const router = express.Router()

router.post("/postorder",auth,postOrder)
router.get("/getorder",auth,getOrder)
router.get("/:order_id",getOrderById)
router.delete("/:order_id",auth,deleteOrder)
router.put("/updateorder",auth,updateOrder)

export default router