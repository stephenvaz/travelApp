const { FieldValue } = require("@google-cloud/firestore");
const {db} = require("../firestore_db");

// {
//     "email": "semic@gmail.com",
//     "end_date": "March 10, 2023 at 12:00:00 AM UTC+5:30",
//     "mode_of_transport": "Bus",
//     "start_date": "March 4, 2023 at 12:00:00 AM UTC+5:30",
//     "status":  "Completed",
//     "stops": [
//         {
//             "lat": 46,
//             "long": 56,
//             "loc_name": "Mumbai"
//         }
//     ]
// }

module.exports.addTrip = async (req, res) => {
    try {
        const tripRef = await db.collection("Users").doc(req.body.email).update({
            tripDetails: FieldValue.arrayUnion(req.body.tripDetails)
        })
        res.send("added");
    }catch(e){
        console.log(e);
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }
}

module.exports.getTrips = async (req, res) => {
    const trips = await db.collection("Users").get()
    const tripArr = []
    trips.forEach(doc => {
        if(doc.data().email != req.body.email){
            tripArr.push(doc.data().tripDetails)
        }
    })
    res.send(tripArr);
}