const {db} = require("../firestore_db");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");

dotenv.config();

module.exports.SignUp = (req, res) => {
    try {
        const { email } = req.body;
        const userRef = db.collection("Users").add(req.body);
        const token = jwt.sign({email: email}, process.env.password, {
            expiresIn: "1111h"
          });
        // console.log("Sign Up", email, token);
        res.json({
            status: "1",
            message: "Logged In Successfully",
            token: token})
    }catch(e){
        console.log(e);
        res.send("0");res.json({
            status: "0",
            message: "Error occurred.",
            error: `${error}`,
        });
    }
}
module.exports.login = () => {

}

