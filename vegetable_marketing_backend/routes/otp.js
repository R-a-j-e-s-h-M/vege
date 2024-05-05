


const otpGenerator = require("otp-generator");
const crypto = require("crypto");
const key = "verysecretkey"; // Key for cryptograpy. Keep it secret
var msg91 = require("msg91").default;
msg91.initialize({authKey: key});
const accountid="ACf79fd7053c2a3a97c838d8c26ad7c560"
const authtoken="e4a1f06bab63f53ebfedb7de96d02c6a"





async function createNewOTP(params, callback) {
    // Generate a 4 digit numeric OTP
    var otp = Math.floor(1000 + Math.random() * 9000);
    const ttl = 5 * 60 * 1000; //5 Minutes in miliseconds
    const expires = Date.now() + ttl; //timestamp to 5 minutes in the future
    const data = `${params.phone}.${otp}.${expires}`; // phone.otp.expiry_timestamp
    const hash = crypto.createHmac("sha256", key).update(data).digest("hex"); // creating SHA256 hash of the data
    const fullHash = `${hash}.${expires}`; // Hash.expires, format to send to the user
    // you have to implement the function to send SMS yourself. For demo purpose. let's assume it's called sendSMS
    //sendSMS(phone, `Your OTP is ${otp}. it will expire in 5 minutes`);
  
    console.log(`Your OTP is ${otp}. it will expire in 5 minutes`);
  
    var otpMessage = `Dear Customer, ${otp} is the One Time Password ( OTP ) for your login.`;
  
    msg91.getSMS(key).send(`+91${params.phone}`, otpMessage, function (err, response) {
      console.log(response);
    });
       


    return callback(null, fullHash);
  }
  
  async function verifyOTP(params, callback) {
    // Separate Hash value and expires from the hash returned from the user
    let [hashValue, expires] = params.hash.split(".");
    // Check if expiry time has passed
    let now = Date.now();
    if (now > parseInt(expires)) return callback("OTP Expired");
    // Calculate new hash with the same key and the same algorithm
    let data = `${params.phone}.${params.otp}.${expires}`;
    let newCalculatedHash = crypto
      .createHmac("sha256", key)
      .update(data)
      .digest("hex");
    // Match the hashes
    if (newCalculatedHash === hashValue) {
      return callback(null, "Success");
    }
    return callback("Invalid OTP");
  }
  

  module.exports = {
    
    createNewOTP,
    verifyOTP,
  };