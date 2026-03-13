import express from "express"

import auth from "../middleware/authMiddleware.js"
import { deleteRating, getRatingsById, getRatingsByUser, postRatings, updateRating } from "../controllers/ratingsController.js"


const router = express.Router()

router.post("/postRatings",auth,postRatings)
router.get("/:rated_id",getRatingsById)
router.get("/ratings/:rated_id",getRatingsByUser)
router.delete("/rating/:rating_id",auth,deleteRating)
router.post("/updaterating/:rating_id",auth,updateRating)

export default router