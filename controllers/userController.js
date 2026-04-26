import pool from "../config/db.js"
import bcrypt from "bcryptjs"
import jwt from "jsonwebtoken"
import dotenv, { decrypt } from "dotenv"
import cloudinary from "../config/cloudinary.js"
import { error, log } from "console"

dotenv.config()


async function userRegister(req, res) {
    const { email, psw, fullname, userClass } = req.body


    if (!email || !psw || !fullname || !userClass) {
        return await res.status(400).json({ error: "Töltsd ki az összes mezőt" })
    }

    if (!email.endsWith('@dszcbaross.edu.hu')) {
        return res.status(400).json({ message: 'Csak dszcbaross.edu.hu végződésű email címmel lehet belépni', errorField: 'email' });
    }

    try {

        const [existinguser] = await pool.query("SELECT * FROM `users` WHERE email = ?", [email])


        if (existinguser.length > 0) {
            return await res.status(400).json({ error: "Ez az email cím már foglalt", errorField: 'email' })
        }



        const hashedpsw = await bcrypt.hash(psw, 10)

        const [result] = await pool.query("INSERT INTO `users` (`user_id`, `pfp`, `email`, `psw`, `fullname`, `userClass`, `role`, `verified`, `created_at`) VALUES (NULL,NULL, ?, ?, ?, ?, 'regisztralt', '0', current_timestamp())", [email, hashedpsw, fullname, userClass])
   
        return res.status(201).json({ message: "Sikeres regisztráció" })
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message })
    }
}






async function userallInformation(req, res) {
    const { user_id } = req.params



    try {
        const [result] = await pool.query("SELECT u.*,u.user_id, u.fullname, u.userClass, u.pfp, u.created_at, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 0) AS active, (SELECT COUNT(*) FROM product WHERE user_id = u.user_id AND is_sold = 1) AS sold_items, (SELECT COUNT(*) FROM likes WHERE user_id = u.user_id) AS favorites, (SELECT COUNT(*) FROM likes WHERE product_id IN (SELECT product_id FROM product WHERE user_id = u.user_id)) AS liked, (SELECT ROUND(AVG(rate), 1) FROM ratings WHERE rated_id = u.user_id) AS avg_ratings, (SELECT COUNT(*) FROM ratings WHERE rated_id = u.user_id) AS ratings_number FROM users u WHERE u.user_id = ?", [user_id])
        return res.status(200).json(result[0])
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message })
    }
}


async function userLogin(req, res) {
    const { email, psw } = req.body;
    console.log(email, psw);
    if (!email || !psw) {

        return res.status(400).json({ message: 'Email és jelszó kötelező' });
    }
    try {
        const [rows] = await pool.query("SELECT user_id,psw FROM users WHERE email = ?", [email]);
        if (rows.length === 0) {
            return res.status(400).json({ message: 'Hibás email cím vagy jelszó', errorField: ['email', 'psw'] });
        }

        const user = rows[0];
        console.log(psw, user.psw);
        const isPasswordValid = await bcrypt.compare(psw, user.psw);
        console.log(isPasswordValid);
        console.log(user);

        if (!isPasswordValid) {
            return res.status(400).json({ message: 'Hibás email vagy jelszó', errorField: ['email', 'psw'] });
        }
        console.log(process.env.JWT_SECRET);
        const token = jwt.sign({ id: user.user_id, name: user.fullname , role: user.role }, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(200).json({ message: 'Sikeres bejelentkezés', token, user });

    }
    catch (error) {
        console.log(error)
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

async function logout(req, res) {

    return res.json({ message: "Sikeres kijelentkezés" });
};

async function userDelete(req, res) {
    const user_id = req.user.user_id;
    const { psw } = req.query
    console.log(psw);
    try {

        const [rows] = await pool.query("SELECT * FROM users WHERE user_id = ?", [user_id])

        const user = rows[0]

        const match = await bcrypt.compare(psw, user.psw)
        console.log(match);

        if (!match) {
            return res.status(400).json({ message: "A jelenlegi jelszó nem egyezik" })
        }

        const [result] = await pool.query("DELETE FROM users WHERE `users`.`user_id` = ?", [user_id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Felhasználó nem található' });
        }
        res.status(200).json({ message: 'Felhasználó sikeresen törölve' });
    } catch (error) {
        res.status(500).json({ message: "Szerver hiba", error: error.message })
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

const getAllUser = async (req, res) => {
    const page = Number(req.query.page) || 1
    const limit = 10
    const offset = (page - 1) * limit

    try {
        const [rows] = await pool.query(
            "SELECT user_id, fullname, email, userClass, created_at, role,pfp, verified FROM users ORDER BY user_id DESC LIMIT ? OFFSET ? ",
            [limit, offset]
        )
        const [[{ total }]] = await pool.query("SELECT COUNT(*) as total FROM users")

        const [latests] = await pool.query("SELECT * FROM users ORDER BY created_at DESC LIMIT 5")

        res.status(200).json({
            users: rows,
            latests,
            total,
            totalPages: Math.ceil(total / limit),
            currentPage: page
        })
    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}


const updateUser = async (req, res) => {
    const user_id = req.user.user_id;
    const { fullname, userClass } = req.body;
    console.log(fullname);
    console.log(userClass);

    if (!user_id) {
        return res.status(400).json({ message: 'Nincs ilyen felhasználó' });
    }

    try {
        const [existingUser] = await pool.query("SELECT * FROM users WHERE fullname = ? AND user_id != ?", [fullname, user_id])
        console.log(existingUser);
        if (existingUser.length > 0) {
            return res.status(400).json({ message: "Ez a felhasználónév foglalt" })
        }

        const [result] = await pool.query("UPDATE `users` SET `fullname` = COALESCE(NULLIF(?, ''), fullname) ,userClass = COALESCE(NULLIF(?, ''), userClass)  WHERE `user_id` = ?", [fullname, userClass, user_id]
        );



        res.status(200).json({ message: 'Sikeres változtatás' });
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
};

const updatePassword = async (req, res) => {

    const user_id = req.user.user_id
    const { password, newPsw } = req.body

    try {

        const [rows] = await pool.query("SELECT * FROM users WHERE user_id = ?", [user_id])

        const user = rows[0]

        const match = await bcrypt.compare(password, user.psw)
        if (!match) {
            return res.status(400).json({ message: "A jelenlegi jelszó nem egyezik" })
        }
        const newHashedPsw = await bcrypt.hash(newPsw, 10)
        const rows2 = await pool.query("UPDATE `users` SET `psw` = ? WHERE `users`.`user_id` = ?", [newHashedPsw, user_id])
        return res.status(200).json({ message: "Sikeres jelszó módosítás!" })

    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
}


const updateNotifications = async (req, res) => {
    const user_id = req.user.user_id;
    const { notify_message, notify_rating, notify_sold } = req.body;

    console.log(notify_message);
    try {

        const [result] = await pool.query("UPDATE `users` SET `notify_message` = ?, `notify_rating` = ?, `notify_sold` = ? WHERE `users`.`user_id` = ?", [notify_message, notify_rating, notify_sold, user_id]

        );

        res.status(200).json({ message: 'Sikeres vátoztatások' });
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
};

const updatePfp = async (req, res) => {
    const user_id = req.user.user_id;
    try {

        const file = req.file  // nem req.files
        const result = await new Promise((resolve, reject) => {
            const stream = cloudinary.uploader.upload_stream(
                { folder: "barosspiac" },
                (error, result) => error ? reject(error) : resolve(result)
            )
            stream.end(file.buffer)
        })

        const newPfp = result.secure_url

        await pool.query(
            "UPDATE users SET pfp = ? WHERE user_id = ?",
            [newPfp, user_id]
        )

        res.status(200).json({ message: 'Sikeres változtatás', newPfp })
    } catch (error) {
        return res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
}

const deletePfp = async (req, res) => {
    const user_id = req.user.user_id;
    try {
        await pool.query(
            "UPDATE users SET pfp = NULL WHERE user_id = ?",
            [user_id]
        )

        return res.status(200).json({ message: 'Sikeres változtatás' })
    }
    catch (error) {
        return res.status(500).json({ message: "Szerverhiba", error: error.message });
    }
}


const deleteUser = async (req, res) => {
    const { user_id } = req.params
    try {
        await pool.query('DELETE FROM users WHERE user_id = ?', [user_id])
        res.status(200).json({ message: 'Felhasználó törölve' })
    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}

const updateUserAdmin = async (req, res) => {
    const { user_id } = req.params
    const { fullname, email, userClass, role, verified } = req.body
    try {
        await pool.query(
            'UPDATE users SET fullname = ?, email = ?, userClass = ?, role = ?, verified = ? WHERE user_id = ?',
            [fullname, email, userClass, role, verified, user_id]
        )
        res.status(200).json({ message: 'Felhasználó frissítve' })
    } catch (error) {
        res.status(500).json({ message: 'Szerver hiba', error: error.message })
    }
}






export { userRegister, userLogin, logout, userDelete, getUser, updateUser, userallInformation, updatePassword, updateNotifications, updatePfp, deletePfp,getAllUser, deleteUser, updateUserAdmin }






