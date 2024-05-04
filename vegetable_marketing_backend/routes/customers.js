const express=require("express")

const customerRouter=express.Router();
const customer=require("../models/customermodel")
const db=require("../utils/database")
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// SIGN UP
customerRouter.post("/api/signup/customer", async (req, res) => {
  try {
    const { name, email, password,mobile,address,state,district,place,cart } = req.body;

    const existingUser = await customer.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
      
    

    const hashedPassword = await bcryptjs.hash(password, 8);

    let customers = new customer({
      email,
      password: hashedPassword,
      name,
      mobile,
      address,
      state,
      district,
      place,
      
      
    });
    
    

    customers = await customers.save();
    res.json(customers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In Route
// Exercise
customerRouter.post("/api/signin/customer", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await customer.findOne({ email });
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

customerRouter.post("/tokenIsValid", async (req, res) => {
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
customerRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});


customerRouter.get("/get/customer", async (req, res) => {
  try {
    const customers = await customer.find({});
    res.json(customers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});





module.exports=customerRouter