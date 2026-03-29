import express from "express"
import cors from "cors"
import dotenv from "dotenv"
import userRoute from "./routes/userRoute.js"
import productRoute from "./routes/productRoute.js"
import categoryRoute from "./routes/categoryRoute.js"
import ratingsRoute from './routes/ratingsRoute.js'
import likeRoute from './routes/likeRoute.js'
import reportRoute from './routes/reportRoute.js'
import conversationRoute from './routes/conversationRoute.js'
import orderRoute from './routes/orderRoute.js'
import messagesRoute from "./routes/messagesRoute.js"
import { error } from "console"
import { createServer } from "http"
import { Server } from "socket.io"
import statisticRoute from "./routes/statisticRoute.js"
import db from "./config/db.js"

const app = express()
const server = createServer(app)
const io = new Server(server, {
    cors: { origin: "*" }
})


io.on('connection', (socket) => {
    console.log('Csatlakozott:', socket.id)

    socket.on('join_conversation', (conversation_id) => {
        socket.join(String(conversation_id))
        console.log(`${socket.id} belépett a ${conversation_id} szobába`)
    })

    socket.on('send_message', async (data) => {
        const { conversation_id, sender_id, message } = data

        try {
            const [result] = await db.query(
                'INSERT INTO messages (conversations_id, sender_id, message) VALUES (?, ?, ?)',
                [conversation_id, sender_id, message]
            )

            const newMessage = {
                message_id: result.insertId,
                conversation_id,
                sender_id,
                message,
                sent_at: new Date()
            }

            io.to(String(conversation_id)).emit('receive_message', newMessage)

        } catch (err) {
            console.error('Üzenet mentési hiba:', err)
            socket.emit('error', { message: 'Üzenet küldése sikertelen' })
        }
    })

    socket.on('disconnect', () => {
        console.log('Lecsatlakozott:', socket.id)
    })
})

dotenv.config()

const PORT = process.env.PORT
const HOST = process.env.HOST



app.use(express.json())

app.use(cors({origin: "*"}))


app.use("/api/user",userRoute)
app.use("/api/product",productRoute)
app.use("/api/category",categoryRoute)
app.use("/api/ratings",ratingsRoute)
app.use("/api/likes",likeRoute)
app.use("/api/reports",reportRoute)
app.use("/api/conversations",conversationRoute)
app.use("/api/orders",orderRoute)
app.use("/api/messages",messagesRoute)
app.use("/api/statistics",statisticRoute)




app.use((req,res) => 
    {
        res.status(404).json({error: "Az oldal nem található"})
    })





server.listen(PORT,HOST,() => {
    console.log(`A szerver fut: http://${HOST}:${PORT}`);
})