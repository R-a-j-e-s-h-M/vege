const mongoose=require("mongoose");



const orderdispatched=mongoose.Schema({
         orderdispatched:{
            type:String,
            required:true
         },
         
})

const orderdispatch=mongoose.model("Orderdispatched",orderdispatched)
module.exports=orderdispatch