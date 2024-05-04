const mongoose=require("mongoose")



const reviewschema=mongoose.Schema({
    username:{
        type:String,
        trime:true,
    },
    reviewcontent:{
        type:String,
        required:true,

    },
    rating:{
         type:String,

    },
    date: {
        
         type: Date,
          default: Date.now,
    }
    
})

const Review = mongoose.model("Review", reviewschema);
module.exports = Review