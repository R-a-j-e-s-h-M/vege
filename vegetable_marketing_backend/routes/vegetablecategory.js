const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Vegetable= require("../models/vegetablemodel");
const User = require("../models/farmermodel");

productRouter.get("/api/products/",  async (req, res) => {
  try {
    const products = await Vegetable.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


productRouter.get("/api/products/search/name/:name",  async (req, res) => {
  try {
    
    const product = await User.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.json(product);
    
  
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


productRouter.get("/api/products/search/village/:name",  async (req, res) => {
  try {
    const produc = await User.find({
      village: { $regex: req.params.name, $options: "i" },
    });

    res.json(produc);
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/products/search/place/:name",  async (req, res) => {
  try {
    const products = await User.find({
      place: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/products/search/district/:name",  async (req, res) => {
  try {
    const products = await User.find({
      district: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports=productRouter