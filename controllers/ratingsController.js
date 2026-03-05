import pool from "../config/db.js"


async function postRatings(req, res) {

   const { rate, text } = req.body;
   const  {rated_id}  = req.body;
   const {rater_id} = req.body
   

   console.log(rated_id,rater_id);

   if (!rate || rate < 1 || rate > 5) {
       return res.status(400).json({ message: "1 és 5 között lehet értékelni" });
   }

   try {

       await pool.query(`INSERT INTO ratings (rating_id, rater_id, rated_id, rate, text, created_at) VALUES (NULL, ?, ?, ?, ?, current_timestamp())`,[rater_id,rated_id, rate, text]);

       return res.status(200).json({ message: "Sikeres értékelés" });

   } catch (error) {
       console.log(error);
       return res.status(500).json({ message: "Szerver hiba", error: error.message });
   }
}


async function getRatingsById(req, res) {


   const  {rated_id}  = req.params;

   console.log(rated_id);


   try {

       const [result] = await pool.query(`SELECT AVG(rate) AS "avg",COUNT(*) AS "db" FROM ratings WHERE rated_id = ?`,[rated_id]);

       return res.status(200).json(result[0]);

   } catch (error) {
       console.log(error);
       return res.status(500).json({ message: "Szerver hiba", error: error.message });
   }
}

export {postRatings,getRatingsById}