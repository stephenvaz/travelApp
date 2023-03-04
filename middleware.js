const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");

dotenv.config();

module.exports.isAuth = (req, res, next) => {
    const token = req.headers.authorization.split(" ")[1];
    const isCustomAuth = token.length < 500;
    
    if (token && isCustomAuth) {
    decodedData = jwt.verify(req.body.token, process.env.password); 
    req.body.email = decodedData
    next()
    }else{
        res.redirect("/")
    }
}