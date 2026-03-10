import pool from '../config/db.js'



async function postOrder(req,res) 
{

    const {user_id} = req.body


    const {buyer_id,seller_id,product_id,order_status} = req.body

   try {
    

    const [result] = await pool.query("INSERT INTO `orders` (`order_id`, `buyer_id`, `seller_id`, `product_id`, `order_status`, `order_date`) VALUES (NULL, ?, ?, ?, ?, current_timestamp())",[user_id,seller_id,product_id,order_status])
    console.log(result);
    return res.status(200).json({message: "Sikeres rendelés!"})  
  
   } catch (error) {
    console.log(error);
    return  res.status(500).json({message: "Szerver hiba", error:error.message})
   }
}


const getOrder = async (req, res) => {
    try {
        const [response] = await pool.query("SELECT * FROM `orders` INNER JOIN product ON product.product_id = orders.product_id;");
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

const getOrderById = async (req, res) => {
    const  {order_id} = req.params
    try {
        const [response] = await pool.query("SELECT * FROM `orders` INNER JOIN product ON product.product_id = orders.product_id WHERE order_id = ?",[order_id]);
        console.log(response);
       
        
       res.status(200).json(response);
       
    }
    catch (error) {
        return res.status(500).json({ message: 'Szerver hiba', error: error.message });
    }
}

async function deleteOrder(req,res)
{
    const {order_id} = req.params
    req.user.user_id;
   
    try {
        const [result] = await pool.query("DELETE FROM orders WHERE `orders`.`order_id` = ?", [order_id]);
     
        if(result.affectedRows === 0){
            return res.status(404).json({message: 'Termék nem található'});
        }
        res.status(200).json({message: 'Rendelés sikeresen törölve'});
    } catch (error) {
         res.status(500).json({message: "Szerver hiba", error: error.message})
    }
    
}

async function updateOrder(req,res) 
{

    const user_id = req.user.user_id


    const {order_id,buyer_id,seller_id,product_id,order_status} = req.body

   try {
    

    const [result] = await pool.query("UPDATE `orders` SET `buyer_id` = ?, `seller_id` = ?, `product_id` = ?, `order_status` = 'pending' WHERE `orders`.`order_id` = ?",[order_id,user_id,seller_id,product_id,order_status])
    console.log(result);
    return res.status(200).json({message: "Rendelés módosítva!"})  
  
   } catch (error) {
    console.log(error);
    return  res.status(500).json({message: "Szerver hiba", error:error.message})
   }
}







export {postOrder,getOrder,deleteOrder,updateOrder,getOrderById}