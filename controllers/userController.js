import pool from "../config/db.js"
import bcrypt from "bcryptjs"
import jwt from "jsonwebtoken"
import dotenv from "dotenv"
import { error } from "console"
dotenv.config()


async function userRegister(req,res) 
{
   const {email,psw,fullname,userClass} = req.body


   if (!email || !psw || !fullname || !userClass) {
    return await res.status(400).json({error: "Töltsd ki az összes mezőt"})
   }

   if (!email.endsWith('@dszcbaross.edu.hu')) 
    { 
        return res.status(400).json({ message: 'Csak dszcbaross.edu.hu végződésű email címmel lehet belépni' });
    }

   try {
    const [existinguser] = await pool.query("SELECT * FROM `users` WHERE email = ?",[email])

    if (existinguser.length > 0 ) {
        return await res.status(400).json({error: "Ez az email cím már foglalt"})
    }

    const hashedpsw = await bcrypt.hash(psw,10)

    const [result] = await pool.query('INSERT INTO `users` (`user_id`, `pfp`, `email`, `psw`, `fullname`, `class`, `balance`, `role`) VALUES (NULL, "", ?, ?, ?, ?, 0, "regisztralt")',[email,hashedpsw,fullname,userClass])
    return res.status(200).json({message: "Sikeres regisztráció"}) 
   } catch (error) {
    console.log(error);
    return  res.status(500).json({message: "Szerver hiba", error:error.message})
   }
}


async function userLogin(req,res)
{
    const { email, psw } = req.body;
    console.log(email,psw);
    if (!email || !psw) {

        return res.status(400).json({ message: 'Email és jelszó kötelező'});
    }
    try {
        const [rows] = await pool.query("SELECT user_id,psw FROM users WHERE email = ?", [email]);
        if (rows.length === 0) {
            return res.status(401).json({ message: 'Hibás email cím vagy jelszó' });
        }

        const user = rows[0];
        console.log(psw,user.psw);
        const isPasswordValid = await bcrypt.compare(psw, user.psw);
        console.log(isPasswordValid);
        console.log(user);

        if (!isPasswordValid) {
            return res.status(401).json({ message: 'Hibás email vagy jelszóseededed' });
        }
        console.log(process.env.JWT_SECRET);
        const token = jwt.sign({id: user.user_id, name: user.fullname}, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(200).json({ message: 'Sikeres bejelentkezés', token });
        
    }
    catch (error) {
        console.log(error)
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}



export {userRegister,userLogin}






