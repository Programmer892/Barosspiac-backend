import express from "express"

import auth from "../middleware/authMiddleware.js"
import { getRatingsById, postRatings } from "../controllers/ratingsController.js"


const router = express.Router()

router.post("/postRatings",auth,postRatings)
router.get("/:rated_id",getRatingsById)

export default router