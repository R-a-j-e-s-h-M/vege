

const mongoose=require("mongoose");



const orderpacked=mongoose.Schema({
         orderpacked:{
            type:String,
            required:true
         },
         
})

const orderpack=mongoose.model("Orderpacked",orderpacked)
module.exports=orderpack