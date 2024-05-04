const mongoose = require("mongoose");
const {vegetableSchemaSchema} =require("./vegetablemodel")


const userSchema = mongoose.Schema({
    name: {
      required: true,
      type: String,
      trim: true,
    },
    email: {
      required: true,
      type: String,
      trim: true,
      validate: {
        validator: (value) => {
          const re =
            /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
          return value.match(re);
        },
        message: "Please enter a valid email address",
      },
    },
    password: {
      required: true,
      type: String,
    },
    mobile: {
      required: true,
      type: String,
    },
    address: {
      required:true,
      type: String,
      
    },
    state: {
      required: true,
      type: String,
    },
    district: {
      required: true,
      type: String,
    },
    place: {
      required: true,
      type: String,
    },
    village: {
      required: true,
      type: String,
    },
    type: {
      type: String,
      default: "user",
    },

    vegetable:[
      {
        product:vegetableSchemaSchema,
        quantity: {
          type: Number,
          required: true,
        },
      },
    ],
    
  });
  
  const User = mongoose.model("User", userSchema);
  module.exports = User;