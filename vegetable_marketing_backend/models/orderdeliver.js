const mongoose=require("mongoose");



const orderdelivered=mongoose.Schema({
         orderdelivered:{
            type:String,
            required:true
         },
         
})

const orderdeliver=mongoose.model("Orderdelivered",orderdelivered)
module.exports=orderdeliver