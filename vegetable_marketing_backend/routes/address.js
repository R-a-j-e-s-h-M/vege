const express=require("express")

const addressRouter=express.Router();
const addres=require("../models/addressmodel")




addressRouter.post("/add/address", async (req, res) => {
    try {
      const { address,phonenumber,landmark } = req.body;
  
      let review = new addres({
        address,
        phonenumber,
        landmark
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  addressRouter.get("/get/address", async (req, res) => {
    try {
      const reviews = await addres.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



module.exports=addressRouter