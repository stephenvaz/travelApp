const { db } = require("../firestore_db");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const bcrypt = require("bcryptjs");
const { v4: uuidv4 } = require('uuid');
const twilio = require('twilio');

dotenv.config();

const nodemailer = require("nodemailer");

const sendMessage = (link, phone) => {
    const accountSid = process.env.TWILIO_ACCOUNT_SID;
    const authToken = process.env.TWILIO_AUTH_TOKEN;
    const client = require('twilio')(accountSid, authToken);
    client.messages
        .create({
            body: `Verify your mail - ${link}`,
            from: '+15672922075',
            to: `+91${phone}`
        })
    //   .then(message => console.log);
}

const sendEmail = async (email, subject, text) => {
    try {
        const transporter = nodemailer.createTransport({
            host: "smtp.gmail.com",
            service: "gmail",
            port: 465,
            secure: false,
            auth: {
                user: process.env.EMAIL,
                pass: process.env.EMAILPASS,
            },
        });

        await transporter.sendMail({
            from: process.env.EMAIL,
            to: email,
            subject: subject,
            text: text,
        });
        console.log("email sent sucessfully");
    } catch (error) {
        console.log("email not sent");
        console.log(error);
    }
};

module.exports.verify_mail = (req, res) => {
    try {

        const email = req.params.email
        const userRef = db.collection("Users").doc(email)
        const userData = userRef.update({ verified_mail: true })
        res.json({
            status: "1",
            message: "Succes.",
            error: `${e}`,
        });
    }
    catch (e) {
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }

    res.send("<h1>Mail Verified successfully<h1>")
}
module.exports.verify_phone = (req, res) => {
    try {

        const email = req.params.email
        const userRef = db.collection("Users").doc(email)
        const userData = userRef.update({ verified_phone: true })

        res.send(res.json({
            status: "1",
            message: "Phone number verified",
        }))
    }
    catch (e) {
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }

    res.send("<h1>Mail Verified successfully<h1>")
}

// module.exports.SignUp = async (req, res) => {
//     try {
//         const { email, name, password, dob, interests, phone } = req.body;
//         const saltRounds = 10;
//         // hash(password, saltRounds, (err, hash) => {
//         const userRef = db.collection("Users").doc(email).set({ email, name, password, dob, interests, tripDetails: [] });
//         // }).then(() => {
//         const token = jwt.sign({ email: email }, process.env.password, {
//             expiresIn: "1111h"
//         });



//         res.json({
//             status: "1",
//             message: "SignedIn Successfully",
//             token: token
//         });

        
//         const { email, name, password, dob, interests } = req.body;
//         const salt = 10;
//         const hashed = await bcrypt.hash(password, salt);
//         console.log(hashed)
//         const userRef = await db.collection("Users").doc(email).set({email, name, password: hashed, dob, interests, tripDetails: []});
//             const token = jwt.sign({email: email}, process.env.password, {
//                 expiresIn: "1111h"
//             });
            
//             res.json({
//                 status: "1",
//                 message: "SignedIn Successfully",
//                 token: token});
//         // })

//     } catch (e) {
//         console.log(e);
//         res.json({
//             status: "0",
//             message: "Error occurred.",
//             error: `${e}`,
//         });
//     }
// }

module.exports.login = async (req, res) => {
    // const { email } = req.body;
    console.log(req.body);
    try{
    const {email} = req.body;
    const salts = 10;
    const user = await db.collection("Users").doc(email).get();
    if (!user.exists) {
        return res.json({
            status: 0,
            message: "bggf Error occurred."
        })
    }

    // bcrypt.compare(req.body.password, user.data().password).then((result) => {
            // if(result){
            //     const token = jwt.sign({email: email}, process.env.password, {
            //         expiresIn: "1111h"
            //     });   
            if(req.body.password === user.data().password){ 
                return res.json({
                    status: 1,
                    message: "LoggedIn Successfully",
                    // token: token
                });
            }else {
                return res.json({
                    status: "0",
                    message: "Passwords do not match"
                });
            }
        
    }catch(e){
        res.json({
            "status": 0,
            "message": `${e}`
        }); 
    }
}

module.exports.create_account = (req, res) => {

    const data = req.body
    console.log(data)
    let email = data.email
    let phone = data.phone_number

    try {
        const userRef = db.collection("Users").doc(email)
        const userDataObj = userRef.set(data)

        // const randId = uuidv4();
        //const verify_mail_link = `https://eff7-2409-40c0-c-5392-1cd4-d7f6-7a73-826.in.ngrok.io/verify_mail/${email}/${randId}`
        //sendEmail(email, "Verify your Mail", `${verify_mail_link}`)

        // const randId2 = uuidv4();
        //const verify_phone_link = `https://eff7-2409-40c0-c-5392-1cd4-d7f6-7a73-826.in.ngrok.io/verify_phone/${email}/${randId2}`
        //sendMessage(verify_phone_link, phone)

        res.json({
            status: 1,
            message: "success",
        });
    }
    catch (e) {
        res.json({
            status: 0,
            message: "Error occurred.",
            error: `${e}`
        });
    }
}
