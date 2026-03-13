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
        return res.status(400).json({ message: 'Csak dszcbaross.edu.hu végződésű email címmel lehet belépni', errorField: 'email' });
    }

   try {
    const [existinguser] = await pool.query("SELECT * FROM `users` WHERE email = ?",[email])

    if (existinguser.length > 0 ) {
        return await res.status(400).json({error: "Ez az email cím már foglalt", errorField: 'email'})
    }

    const hashedpsw = await bcrypt.hash(psw,10)

    await pool.query("INSERT INTO `users` (`user_id`, `pfp`, `email`, `psw`, `fullname`, `userClass`, `role`, `verified`, `created_at`) VALUES (NULL,NULL, ?, ?, ?, ?, 'regisztralt', '0', current_timestamp())",[email,hashedpsw,fullname,userClass])

    return res.status(200).json({message: "Sikeres regisztráció"}) 
   } catch (error) {
    console.log(error);
    return  res.status(500).json({message: "Szerver hiba", error:error.message})
   }
}

async function userallInformation(req,res) 
{
   const {user_id} = req.params
   console.log(user_id);
   

   try {
   const [result] = await pool.query("SELECT u.*,u.user_id, u.fullname, u.userClass, u.pfp, u.created_at, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 0) AS active, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 1) AS sold_items, (SELECT COUNT(*) FROM likes WHERE user_id = u.user_id) AS favorites, (SELECT COUNT(*) FROM likes WHERE product_id IN (SELECT product_id FROM product WHERE user_id = u.user_id)) AS liked, (SELECT ROUND(AVG(rate), 1) FROM ratings WHERE rated_id = u.user_id) AS avg_ratings, (SELECT COUNT(*) FROM ratings WHERE rated_id = u.user_id) AS ratings_number FROM users u WHERE u.user_id = ?", [user_id])
    return res.status(200).json(result[0]) 
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
            return res.status(400).json({ message: 'Hibás email cím vagy jelszó', errorField: ['email', 'psw'] });
        }

        const user = rows[0];
        console.log(psw,user.psw);
        const isPasswordValid = await bcrypt.compare(psw, user.psw);
        console.log(isPasswordValid);
        console.log(user);

        if (!isPasswordValid) {
            return res.status(400).json({ message: 'Hibás email vagy jelszó', errorField: ['email', 'psw'] });
        }
        console.log(process.env.JWT_SECRET);
        const token = jwt.sign({id: user.user_id, name: user.fullname}, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(200).json({ message: 'Sikeres bejelentkezés', token,user });
        
    }
    catch (error) {
        console.log(error)
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

async function logout(req, res) {

    return res.json({ message: "Sikeres kijelentkezés" });
};

async function userDelete(req,res)
{
    const user_id = req.user.user_id;
   
    try {
        const [result] = await pool.query("DELETE FROM users WHERE `users`.`user_id` = ?", [user_id]);
        console.log(user_id);
        if(result.affectedRows === 0){
            return res.status(404).json({message: 'Felhasználó nem található'});
        }
        res.status(200).json({message: 'Felhasználó sikeresen törölve'});
    } catch (error) {
         res.status(500).json({message: "Szerver hiba", error: error.message})
    }
    
}

const getUser = async (req, res) => {
    const user_id = req.user.user_id
    console.log(user_id);
    try {
        const [rows] = await pool.query("SELECT u.*,u.user_id, u.fullname, u.userClass, u.pfp, u.created_at, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 0) AS active, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 1) AS sold_items, (SELECT COUNT(*) FROM likes WHERE user_id = u.user_id) AS favorites, (SELECT COUNT(*) FROM likes WHERE product_id IN (SELECT product_id FROM product WHERE user_id = u.user_id)) AS liked, (SELECT ROUND(AVG(rate), 1) FROM ratings WHERE rated_id = u.user_id) AS avg_ratings, (SELECT COUNT(*) FROM ratings WHERE rated_id = u.user_id) AS ratings_number FROM users u WHERE u.user_id = ?", [user_id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: 'Felhasználó nem található' });
        }
       res.status(200).json(rows[0]);
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    } 
}


const updateUser = async (req, res) => {
    const user_id  = req.user.user_id;
    const {fullname,userClass} = req.body;
    console.log(fullname);
    console.log(userClass);

    if (!user_id) {
        return res.status(400).json({ message: 'Nincs ilyen felhasználó' });
    }



    try {
        const [existingUser] = await pool.query("SELECT * FROM users WHERE fullname = ? AND user_id != ?",[fullname,user_id])
        console.log(existingUser);
        if (existingUser.length > 0) {
            return res.status(400).json({message:"Ez a felhasználónév foglalt"})
        }
        
        const [result] = await pool.query("UPDATE `users` SET `fullname` = COALESCE(NULLIF(?, ''), fullname) ,userClass = COALESCE(NULLIF(?, ''), userClass)  WHERE `user_id` = ?",[fullname,userClass,user_id]
        );
       
       

        res.status(200).json({ message: 'Sikeres változtatás' });
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
};

const updatePassword = async(req,res) =>{

    const user_id = req.user.user_id
    const {password, newPsw} = req.body

    try {
       
        const [rows] = await pool.query("SELECT * FROM users WHERE user_id = ?", [user_id])
       
        const user = rows[0]
      
        const match = await bcrypt.compare(password,user.psw)
        if(!match){
            return res.status(400).json({message: "A jelenlegi jelszó nem egyezik"})
        }
        return res.status(200).json({message: "Jó"})
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
}








export {userRegister,userLogin,logout,userDelete,getUser,updateUser,userallInformation,updatePassword}






