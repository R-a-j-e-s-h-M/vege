



const mongoose = require("mongoose");


const vegetableSchemaSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  
  images: [
    {
      type: String,
      required: true,
    },
  ],
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  
  emaill: {
    type: String,
    required: true,
  },
  

  
  
});

const Vegetable = mongoose.model("Vegetable", vegetableSchemaSchema);
module.exports = {Vegetable,vegetableSchemaSchema}
