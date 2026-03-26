
const admin = async (req,res,next) => 
    {
    
        try {
            if (!req.user) {
                return res.status(401).json({error: "nincs hitelesítve"})
            }
           
    
            if (req.user.role !== 'admin') {
                return res.status(403).json({error:"Nincs jogosultságod"})    
            }
    
            next()
        } catch (error) {
            return res.status(500).json({error: "Szerver hiba"})
        }

  
    }

export default admin