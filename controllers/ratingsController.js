import pool from "../config/db.js"
import { createNotification } from "../utils/notifications.js"

async function postRatings(req, res) {
    let { rate, text } = req.body;
    const { rated_id } = req.body;
    const rater_id = req.user.user_id  // JWT-ből, ne bodyból!

    if (!rate || rate < 1 || rate > 5) {
        return res.status(400).json({ message: "1 és 5 között lehet értékelni" });
    }

    if (text == "") {
        text = "Nincs megadva"
    }

    try {

        const [rater] = await pool.query(
            'SELECT fullname FROM users WHERE user_id = ?',
            [rater_id]
        )
        const rater_name = rater[0].fullname

        await pool.query(
            `INSERT INTO ratings (rater_id, rated_id, rate, text, created_at) VALUES (?, ?, ?, ?, current_timestamp())`,
            [rater_id, rated_id, rate, text]
        )

        let star = ""

        for (let i = 1; i <= 5; i++) {
            if (i <= rate) {
                star += "⭐"
            }
        }


        await createNotification(
            rated_id,
            'new_rating',
            `${rater_name} értékelt téged ${star} (${rate}/5)`,
            `/profile/${rated_id}`
        )

        return res.status(200).json({ message: "Sikeres értékelés" })

    } catch (error) {
        console.log(error)
        return res.status(500).json({ message: "Szerver hiba", error: error.message })
    }
}







async function getRatingsById(req, res) {


    const { rated_id } = req.params;

    console.log(rated_id);

    try {

        const [result] = await pool.query(`SELECT AVG(rate) AS "avg",COUNT(*) AS "db" FROM ratings WHERE rated_id = ?`, [rated_id]);

        return res.status(200).json(result[0]);

    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
}

async function getRatingsByUser(req, res) {

    const { rated_id } = req.params;

    console.log(rated_id);

    try {

        const [result] = await pool.query("SELECT ratings.*,users.fullname FROM ratings INNER JOIN users ON users.user_id = ratings.rater_id WHERE rated_id = ? ORDER BY created_at DESC ", [rated_id]);

        return res.status(200).json(result);

    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
}

async function deleteRating(req, res) {

    const { rating_id } = req.params;

    try {

        const [result] = await pool.query("DELETE FROM ratings WHERE `ratings`.`rating_id` = ?", [rating_id]);

        return res.status(200).json(result);

    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }
}

async function updateRating(req, res) {

    let { rate, text } = req.body
    //console.log(`rate: ${rate}`);
    const { rating_id } = req.params;

    if (text == "") {
        text = "Nincs megadva"
    }


    try {

        const [result] = await pool.query("UPDATE `ratings` SET  `rate` = COALESCE(NULLIF(?, ''), rate) , `text` = COALESCE(NULLIF(?, ''), text) WHERE `ratings`.`rating_id` = ?", [rate, text, rating_id]);

        return res.status(200).json({ message: "Sikeres változttás" });


    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Szerver hiba", error: error.message });
    }

}




export { postRatings, getRatingsById, getRatingsByUser, deleteRating, updateRating }