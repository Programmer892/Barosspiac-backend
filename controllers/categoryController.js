import pool from "../config/db.js"



const getCategory = async (req, res) => {

    try {
        const [response] = await pool.query("SELECT * FROM `main_categories` INNER JOIN sub_category ON sub_category.category_id = main_categories.category_id INNER JOIN subsubcategory ON subsubcategory.sub_category_id = sub_category.sub_category_id");
        console.log(response);

        const categories = []

       response.forEach((row) =>{
            
      

            let category = categories.find(c => c.category_id === row.category_id)
            if(!category){
               
                category = {   
                    category_id : row.category_id,
                    name: row.category_name,
                    subcategories: []
                }
                categories.push(category)
            }
            let subcategory = category.subcategories.find(s => s.sub_category_id === row.sub_category_id)
            if(!subcategory){
                subcategory ={
                    sub_category_id: row.sub_category_id,
                    name: row.sub_category_name,
                    items: []
                }
                
                category.subcategories.push(subcategory)
            }
            if(row.sub_sub_category_id){
                subcategory.items.push({
                    sub_sub_category_id: row.sub_sub_category_id,
                    name: row.sub_sub_name
                })
            }
            

       })
       
       console.log(categories);
       res.status(200).json(categories);


       
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Szerver hiba', error: error });
    }
}


export {getCategory }