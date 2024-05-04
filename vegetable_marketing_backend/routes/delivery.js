const express=require("express")

const deliveryRouter=express.Router();
const Delivery=require("../models/deliveryboymodel")
const db=require("../utils/database")
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const adress=require("../models/addressmodel")

// SIGN UP
deliveryRouter.post("/api/signup/delivery", async (req, res) => {
  try {
    const { name, email, password,mobile,address,state,district,place,license,vechicle } = req.body;

    const existingUser = await Delivery.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
      
    

    const hashedPassword = await bcryptjs.hash(password, 8);

    let customers = new Delivery({
      email,
      password: hashedPassword,
      name,
      mobile,
      address,
      state,
      district,
      place,
      license,
      vechicle
      
      
    });
    
    

    customers = await customers.save();
    res.json(customers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In Route
// Exercise
deliveryRouter.post("/api/signin/delivery", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await Delivery.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

deliveryRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
deliveryRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

deliveryRouter.get("/delivery/:id",async (req,res)=>{
 const add=await adress.findById(req.params.id)
 res.json(add)
})
// deliveryRouter.get("/delivery/:id",  async (req, res) => {
//   try {
//     const products = await adress.find({
//       id: { $regex: req.params.id, $options: "i" },
//     });

//     res.json(products);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

deliveryRouter.get("/get/delivery", async (req, res) => {
  try {
    const customers = await Delivery.find({});
    res.json(customers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});





module.exports=deliveryRouter