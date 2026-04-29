import dotenv from "dotenv"
dotenv.config()

import { v2 as cloudinary } from 'cloudinary'


//Make the cloudinary config for the images
cloudinary.config({
    cloud_name: process.env.CLOUDINARY_NAME,
    api_key: process.env.CLOUDINARY_KEY,
    api_secret: process.env.CLOUDINARY_SECRET
})

export default cloudinary