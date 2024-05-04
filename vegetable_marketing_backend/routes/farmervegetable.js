const express = require("express");
const vegetableRouter = express.Router();
const admin = require("../middlewares/admin");
const {Vegetable} = require("../models/vegetablemodel");
const User=require("../models/farmermodel")



// Add product
vegetableRouter.post("/admin/add-product",  async (req, res) => {
  try {
    const { name, images, quantity, price, category,emaill} = req.body;
    const farmer=await User.findOne({email:emaill})
    let product = new Vegetable({
      name,
      images,
      quantity,
      price,
      category,
      emaill
    });
    console.log(product)

    
    if(farmer.vegetable.length>=0){
      farmer.vegetable.push({product,quantity:5})
    }
    console.log(farmer.vegetable[0].product)
   
      
   
    await farmer.save();
    product = await product.save();

    
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your product
vegetableRouter.get("/admin/get-products",  async (req, res) => {
  try {
    const products = await Vegetable.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
vegetableRouter.post("/admin/delete-product", async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Vegetable.findByIdAndDelete(id);
    
    res.json(product);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports=vegetableRouter
