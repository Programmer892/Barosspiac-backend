import express from "express"
import cors from "cors"
import dotenv from "dotenv"
import userRoute from "./routes/userRoute.js"
import productRoute from "./routes/productRoute.js"
import categoryRoute from "./routes/categoryRoute.js"
import ratingsRoute from './routes/ratingsRoute.js'
import likeRoute from './routes/likeRoute.js'
import reportRoute from './routes/reportRoute.js'
import converstationRoute from './routes/conversationRoute.js'
import orderRoute from './routes/orderRoute.js'
import { error } from "console"


dotenv.config()

const PORT = process.env.PORT
const HOST = process.env.HOST


const app = express()
app.use(express.json())

app.use(cors({origin: "*"}))


app.use("/api/user",userRoute)
app.use("/api/product",productRoute)
app.use("/api/category",categoryRoute)
app.use("/api/ratings",ratingsRoute)
app.use("/api/likes",likeRoute)
app.use("/api/reports",reportRoute)
app.use("/api/converstations",converstationRoute)
app.use("/api/orders",orderRoute)




app.use((req,res) => 
    {
        res.status(404).json({error: "Az oldal nem található"})
    })





app.listen(PORT,HOST,() => {
    console.log(`A szerver fut: http://${HOST}:${PORT}`);
})