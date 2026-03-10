import express from "express"
import auth from "../middleware/authMiddleware.js"
import { deleteAllLike, deleteLike, getLikes, getallLikes, postLikes } from "../controllers/likeController.js"



const router = express.Router()

router.get("/liked/:product_id",auth,getLikes)
router.post("/like",auth,postLikes)
router.delete("/unlike/:product_id",auth,deleteLike)
router.delete("/alllike",auth,deleteAllLike)
router.get("/alllikes",auth,getallLikes)




export default router
