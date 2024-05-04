const express=require("express")

const reviewRouter=express.Router();
const Review=require("../models/reviewmodel")




reviewRouter.post("/add/review", async (req, res) => {
    try {
      const { username,reviewcontent,date,rating } = req.body;
  
      let review = new Review({
        username,
        reviewcontent,
        date,
        rating
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  reviewRouter.get("/get/review", async (req, res) => {
    try {
      const reviews = await Review.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



module.exports=reviewRouter