const mongoose=require("mongoose");



const orderplaced=mongoose.Schema({
         orderplaced:{
            type:String,
            required:true
         },
         
})

const orderplace=mongoose.model("Orderplaced",orderplaced)
module.exports=orderplace