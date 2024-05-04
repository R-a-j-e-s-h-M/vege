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


productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Vegetable.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports=productRouter