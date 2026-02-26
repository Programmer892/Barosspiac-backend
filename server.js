import express from "express"
import cors from "cors"
import dotenv from "dotenv"
import userRoute from "./routes/userRoute.js"
import productRoute from "./routes/productRoute.js"
import categoryRoute from "./routes/categoryRoute.js"
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




app.use((req,res) => 
    {
        res.status(404).json({error: "Az oldal nem található"})
    })





app.listen(PORT,HOST,() => {
    console.log(`A szerver fut: http://${HOST}:${PORT}`);
})