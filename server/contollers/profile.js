const { FieldValue } = require("@google-cloud/firestore");
const { db } = require("../firestore_db");
// {
//     "data" : {
//     "email": "malay@gmail.com",
//     "interests": [
//       "trekking",
//       "hiking"
//     ],
//     "name": "malay",
//     "dob": "19 september",
//     "bio": "hey hi"
//   }
//   }
module.exports.update_profile = async (req, res) => {
    const data = req.body.data;
    // console.log(data) 
    let userEmail = data.email
    delete data.email 
    try {

        const userRef = db.collection("Users").doc(userEmail);
        const response = await userRef.update(data);
        res.send("Updated")
        
    }catch(e){
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }
} 