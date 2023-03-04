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

module.exports.SignUp = (req, res) => {
    try {
        const { email, name, password, dob, interests, phone } = req.body;
        const saltRounds = 10;
        // hash(password, saltRounds, (err, hash) => {
        const userRef = db.collection("Users").doc(email).set({ email, name, password, dob, interests, tripDetails: [] });
        // }).then(() => {
        const token = jwt.sign({ email: email }, process.env.password, {
            expiresIn: "1111h"
        });



        res.json({
            status: "1",
            message: "SignedIn Successfully",
            token: token
        });

        const randId = uuidv4();
        const verify_mail_link = `http://localhost:3000/verify_mail/${email}/${randId}`
        sendEmail(email, "Verify your Mail", `${verify_mail_link}`)

        const randId2 = uuidv4();
        const verify_phone_link = `https://07a4-2409-40c0-1028-2ab6-bd10-fc8b-ac21-bd58.in.ngrok.io/verify_phone/${email}/${randId2}`
        sendMessage(verify_phone_link, phone)
        // })

    } catch (e) {
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }
}

module.exports.login = async (req, res) => {
    const { email } = req.body;
    console.log(req.body);
    const salts = 10;
    const user = await db.collection("Users").doc(email).get();
    if (!user.exists) {
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
        if (result) {
            res.json({
                status: "1",
                message: "LoggedIn Successfully"
            });
        } else {
            res.json({
                status: "0",
                message: "Passwords do not match"
            });
        }

    })
}

module.exports.create_account = (req, res) => {

    const data = req.body
    // console.log(data)
    let userEmail = data.email

    try {
        const userRef = db.collection("Users").doc(userEmail)
        const userDataObj = userRef.set(data)

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