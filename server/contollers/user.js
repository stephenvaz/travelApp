const { FieldValue } = require("@google-cloud/firestore");
const {db} = require("../firestore_db");
const request = require("request");

const { Configuration, OpenAIApi } = require("openai");
const dotenv = require("dotenv");
dotenv.config()

const configuration = new Configuration({
  apiKey: process.env.apiKeyOpenAi
});
const openai = new OpenAIApi(configuration);

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


//reverse geocoding
const getSublocality = (lat, lng) => {
    console.log(lat, lng);
    const requestOptions = {
        url: `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=AIzaSyDtnPmw3rJGTqdCbNl_GAHvNK6XHEO-0aU`,
        method: 'GET'
      };
      console.log(requestOptions.url);
      request(requestOptions, (err, response, body) => {
        if (err) {
          console.log(err);
        } else if (response.statusCode === 200) {
          const result = JSON.parse(body).results;
          result[0].address_components.forEach(doc => {
            if (doc.types[0] === "neighborhood"){
                //console.log(doc);
                return doc;
            }
          }); 
        } else {
          console.log(response.statusCode); 
        }
      });  
}
module.exports.addTrip = async (req, res) => {
    const {email, end_date, start_date, mode_of_transport, interests, status, stops} = req.body
    console.log(req.body);
    try {
        // stops.forEach(stop => {
        //     const location_name = getSublocality(stop.lat, stop.lng);
        //     console.log(location_name) 
        // })
 
        //add user email
        const tripRef = await db.collection("Users").doc(email).update({
            tripDetails: FieldValue.arrayUnion({end_date, start_date, mode_of_transport, interests, status, stops}) 
        })
        res.json({
            "status": 1,
            "message": "Added Successfully"
        });
    }catch(e){
        console.log(e); 
        res.json({
            status: 0,
            message: "Error occurred. sdfds"
        });
    }
}

module.exports.getTrips = async (req, res) => {
    const trips = await db.collection("Users").get()
    const getUser = await db.collection("Users").doc(req.body.email).get()
    const userLoc = getUser.data().tripDetails[0].stops;
    const userStops = []
    const nearby = []
    userLoc.forEach(stop => {
        userStops.push(stop.location_name);
    }) 
    trips.forEach(doc => {
        if(doc.data().email != req.body.email){ 
            stopsArr = []
            //console.log(doc.data())
            if(doc.data().tripDetails){
                doc.data().tripDetails.forEach(trips => { 
                    stopsArr.push(trips.stops[0].location_name);
                    userStops.forEach(stop => {
                        //console.log(stop);
                        if(trips.stops[0].location_name === stop){
                            //console.log("matched");
                            console.log(trips.start_date);
                            nearby.push({user: doc.data().email, name: doc.data().name, start_location: userStops[0], end_location: userStops[userStops.length - 1], start_date: trips.start_date})
                        }
                    })
    
                })
    
            }

        }
    })
    res.send({"arr": nearby});
}

module.exports.getTripDetails = async (req, res) => {
    const getUser = await db.collection("Users").doc(req.body.email).get()
    tripDets = []
    getUser.data().tripDetails.forEach(doc => {
        const {start_date} = doc;
        //console.log(doc.stops[0])
        tripDets.push({start_date, start_location: doc.stops[0].location_name, end_location: doc.stops[doc.stops.length-1].location_name})
    })
    res.json({"list": tripDets})
}

module.exports.tripImages = async (req, res) => {
        const getUser = await db.collection("Users").doc(req.body.email).get()
        const start_loc = getUser.data().tripDetails[0].stops[0].location_name
        const end_loc = getUser.data().tripDetails[0].stops[getUser.data().tripDetails[0].stops.length-1].location_name
        const response = await openai.createImage({
        prompt: `Popular spots at ${start_loc}`,
        n: 5,
        size: "1024x1024",
        })
      
      //console.log(response.data);
      imageArr = []
      response.data.data.forEach(url => {
          imageArr.push(url);
      })
    //   console.log(imageArr);
    res.json({"arr": imageArr})

}
