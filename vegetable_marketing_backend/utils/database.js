const mongoose=require("mongoose")


MONGODB_URL="mongodb+srv://mstrajesh:KL29R9542M@vegtablemarketing.gndjusd.mongodb.net/"


const db=async()=>{
    try{
        const con=await mongoose.connect(MONGODB_URL)
        console.log("mongodb connected")
    }
    catch(error){
           console.log(error)
    }
}

module.exports=db