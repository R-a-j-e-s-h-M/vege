


const bcrypt = require("bcryptjs");
const userServices = require("../routes/otp");



exports.otpLogin = (req, res, next) => {
    userServices.createNewOTP(req.body, (error, results) => {
      if (error) {
        return next(error);
      }
      return res.status(200).send({
        message: "Success",
        data: results,
      });
    });
  };
  
  exports.verifyOTP = (req, res, next) => {
    userServices.verifyOTP(req.body, (error, results) => {
      if (error) {
        return next(error);
      }
      return res.status(200).send({
        message: "Success",
        data: results,
      });
    });
  };