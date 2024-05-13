const express=require("express")

const orderRouter=express.Router();
const orderdeliver=require("../models/orderdeliver")
const orderdispatch=require("../models/orderdispatched")
const orderpack=require("../models/orderpacked")
const orderplace=require("../models/orderplaced")




orderRouter.post("/add/orderdelivered", async (req, res) => {
    try {
      const { orderdelivered } = req.body;
  
      let review = new orderdeliver({
        orderdelivered
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  orderRouter.get("/get/orderdelivered", async (req, res) => {
    try {
      const reviews = await orderdelivered.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



  
orderRouter.post("/add/orderdispatched", async (req, res) => {
    try {
      const { orderdispatched } = req.body;
  
      let review = new orderdispatch({
        orderdispatched
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  orderRouter.get("/get/orderdispatched", async (req, res) => {
    try {
      const reviews = await orderdispatch.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



  orderRouter.post("/add/orderplaced", async (req, res) => {
    try {
      const { orderplaced } = req.body;
  
      let review = new orderplace({
        orderplaced
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  orderRouter.get("/get/orderplaced", async (req, res) => {
    try {
      const reviews = await orderplace.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  
orderRouter.post("/add/orderpacked", async (req, res) => {
    try {
      const { orderpacked } = req.body;
  
      let review = new orderpack({
        orderpacked
        
      });
      
      
  
      review = await review.save();
      res.json(review);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  orderRouter.get("/get/orderpacked", async (req, res) => {
    try {
      const reviews = await orderpack.find({});
      res.json(reviews);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

module.exports=orderRouter