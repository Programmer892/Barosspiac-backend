import express from "express"
import auth from "../middleware/authMiddleware.js"
import { deleteLike, getLikes, postLikes } from "../controllers/likeController.js"



const router = express.Router()

router.get("/liked/:product_id",auth,getLikes)
router.delete("/unlike/:product_id",auth,deleteLike)
router.post("/like",auth,postLikes)


export default router
