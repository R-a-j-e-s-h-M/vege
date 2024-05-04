const mongoose=require("mongoose");



const addressschema=mongoose.Schema({
         address:{
            type:String,
            required:true
         },
         phonenumber:{
            type:String,
            required:true
         },
         landmark:{
            type:String,
            required:true
         }
})

const addres=mongoose.model("Address",addressschema)
module.exports=addres