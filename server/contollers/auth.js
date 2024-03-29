const {db} = require("../firestore_db");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const bcrypt = require("bcryptjs");
dotenv.config();
 

module.exports.SignUp = (req, res) => {
    try {
        const { email, name, password, dob, interests } = req.body;
        const saltRounds = 10;
        // hash(password, saltRounds, (err, hash) => {
            const userRef = db.collection("Users").doc(email).set({email, name, password, dob, interests, tripDetails: []});
        // }).then(() => {
            const token = jwt.sign({email: email}, process.env.password, {
                expiresIn: "1111h"
            });
            
            res.json({
                status: "1",
                message: "SignedIn Successfully",
                token: token});
        // })

    }catch(e){
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }
}

module.exports.login = async (req, res) => {
    const {email} = req.body;
    console.log(req.body);
    const salts = 10;
    const user = await db.collection("Users").doc(email).get();
    if(!user.exists){
        return res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        })
    }
    console.log(req.body.password, user.data().password);
    const hash = await bcrypt.hash(user.data().password, salts);
    console.log(hash);
    bcrypt.compare(req.body.password, hash).then((result) => {
            if(result){
                res.json({
                    status: "1",
                    message: "LoggedIn Successfully"
                });
            }else {
                res.json({
                    status: "0",
                    message: "Passwords do not match"
                });
            }
    
        })
}