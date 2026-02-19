import express from "express"
import cors from "cors"
import dotenv from "dotenv"
import userRoute from "./routes/userRoute.js"
import { error } from "console"
dotenv.config()

const PORT = process.env.PORT
const HOST = process.env.DB_HOST


const app = express()
app.use(express.json())


app.use("/api/user",userRoute)


app.use((req,res) => 
    {
        res.status(404).json({error: "Az oldal nem található"})
    })




app.use(cors())

app.listen(PORT,HOST,() => {
    console.log(`A szerver fut: http://localhost:${PORT}`);
})