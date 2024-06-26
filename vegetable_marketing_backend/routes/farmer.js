const express=require("express")

const farmerRouter=express.Router();
const User=require("../models/farmermodel")
const db=require("../utils/database")
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// SIGN UP
farmerRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password,mobile,address,state,district,place,village,vegetable } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
      
    

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
      mobile,
      address,
      state,
      district,
      place,
      village,
      
    });
    
    

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In Route
// Exercise
farmerRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    console.log(user);
    if (!user) {
      return res
        .status(400)
        .json({ msg: "incorrect email!" });
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

farmerRouter.post("/tokenIsValid", async (req, res) => {
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
farmerRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});


farmerRouter.get("/get/farmer", async (req, res) => {
  try {
    const farmers = await User.find({});
    res.json(farmers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});





module.exports=farmerRouter