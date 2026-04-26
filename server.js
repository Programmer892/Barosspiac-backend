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
import notificationRoute from "./routes/notificationRoute.js"
import { createNotification } from "./utils/notifications.js"


const app = express()
const server = createServer(app)
export const io = new Server(server, {
    cors: {
        origin: ['http://localhost:5173', 'https://barosspiac.netlify.app'],
        methods: ["GET", "POST"],
        allowedHeaders: ["my-custom-header"],
    }
})


io.on('connection', (socket) => {
    console.log('Csatlakozott:', socket.id)

    socket.on('join_conversation', (conversation_id) => {
        socket.join(String(conversation_id))
        console.log(`${socket.id} belépett a ${conversation_id} szobába`)
    })

    socket.on('send_message', async (data) => {
        const { conversation_id, sender_id, message, sended_id } = data
    
        try {
            const [result] = await db.query(
                'INSERT INTO messages (conversations_id, sender_id, message, message_status) VALUES (?, ?, ?, ?)',
                [conversation_id, sender_id, message, 'Elküldve']
            )
    
          
            const [userResult] = await db.query(
                'SELECT fullname, pfp FROM users WHERE user_id = ?',
                [sender_id]
            )
    
            const newMessage = {
                message_id: result.insertId,
                conversation_id,
                sender_id,
                message,
                message_status: 'Elküldve',
                sent_at: new Date(),
                fullname: userResult[0].fullname,  
                pfp: userResult[0].pfp           
            }
    
            await createNotification(sended_id, 'new_message', 'Új üzeneted érkezett', '/messages')
    
            io.to(String(conversation_id)).emit('receive_message', newMessage)
    
        } catch (err) {
            console.error('Üzenet mentési hiba:', err)
            socket.emit('error', { message: 'Üzenet küldése sikertelen' })
        }
    })

    socket.on('delete_message', async (data) => {
        const { message_id, conversation_id } = data
        try {
            await db.query('DELETE FROM messages WHERE message_id = ?', [message_id])
            io.to(String(conversation_id)).emit('message_deleted', { message_id })
        } catch (err) {
            console.error('Üzenet törlési hiba:', err)
            socket.emit('error', { message: 'Üzenet törlése sikertelen' })
        }
    })
    
    socket.on('mark_as_read', async ({ conversation_id, user_id }) => {
        try {
            await db.query(
                `UPDATE messages 
             SET read_at = NOW(), message_status = 'Olvasva'
             WHERE conversations_id = ?
             AND sender_id != ?
             AND read_at IS NULL`,
                [conversation_id, user_id]
            )

      
            io.to(String(conversation_id)).emit('messages_read', {
                conversation_id: Number(conversation_id)
            })
        } catch (err) {
            console.error('Olvasás jelölési hiba:', err)
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

app.use(cors({ origin: ['http://localhost:5173', 'https://barosspiac.netlify.app'] }))


app.use("/api/user", userRoute)
app.use("/api/product", productRoute)
app.use("/api/category", categoryRoute)
app.use("/api/ratings", ratingsRoute)
app.use("/api/likes", likeRoute)
app.use("/api/reports", reportRoute)
app.use("/api/conversations", conversationRoute)
app.use("/api/orders", orderRoute)
app.use("/api/messages", messagesRoute)
app.use("/api/statistics", statisticRoute)
app.use("/api/notifications", notificationRoute)




app.use((req, res) => {
    res.status(404).json({ error: "Az oldal nem található" })
})





server.listen(PORT, () => {
    console.log(`A szerver fut: http://localhost:${PORT}`);
})