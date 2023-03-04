const {db} = require("../firestore_db");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const bcrypt = require("bcryptjs");
dotenv.config();
 

module.exports.SignUp = async (req, res) => {
    try {
        const { email, name, password, dob, interests } = req.body;
        const salt = 10;
        const hashed = await bcrypt.hash(password, salt);
        console.log(hashed)
        const userRef = await db.collection("Users").doc(email).set({email, name, password: hashed, dob, interests, tripDetails: []});
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
    try{
    const {email} = req.body;
    const salts = 10;
    const user = await db.collection("Users").doc(email).get();
    if(!user.exists){
        return res.json({
            status: "0",
            message: "bggf Error occurred."
        })
    }
    bcrypt.compare(req.body.password, user.data().password).then((result) => {
            if(result){
                const token = jwt.sign({email: email}, process.env.password, {
                    expiresIn: "1111h"
                });    
                res.json({
                    status: "1",
                    message: "LoggedIn Successfully",
                    token: token
                });
            }else {
                res.json({
                    status: "0",
                    message: "Passwords do not match"
                });
            }
        })
    }catch(e){
        res.send(e);
    }
} 