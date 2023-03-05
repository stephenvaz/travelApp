const { FieldValue } = require("@google-cloud/firestore");
const {db} = require("../firestore_db");

module.exports.getAll = async (req, res) => {
    console.log("getting");
    const {email} = req.body;
    try {
        const comm = await db.collection("Community").get();
        commArr = []
        comm.forEach((doc) => {
            doc.data().members.forEach(user => {
                if(user === email){
                   db.collection("Community").doc(doc.data().title).update({
                    status: true
                   }) 
                }
            })
            commArr.push(doc.data())
            // console.log(doc.data())
        })
        res.json({
            "Communities": commArr
        });
    }catch(e){
        console.log(e);
        res.json({
            "status": 0,
            "message": "Error occurred."
        });
    }
}

module.exports.createCommunity = async (req, res) => {
    try {
        const {title, desc, date, imageUrl, email} = req.body;
        // const commExists = await db.collection("Community").doc(title).get()
        // console.log(commExists);
        // if(commExists.createTime !== undefined){
        //     return res.json({
        //         "status": -1, 
        //         "message": `${title}`
        //     })
        // }   
        const comm = await db.collection("Community").doc(title).set({title, desc, date, imageUrl, mod: email, members: []});
        res.json({
            "status": 1, 
            "message": `Added to ${title} community`
        });
    } catch (error) {
        console.log(error);
        res.json({
            "status": 0,
            "message": "Error occurred."
        });
        
    }
    
}

module.exports.leaveCommunity = async (req, res) => {
    try {
        const {title, email} = req.body; 
        const comm = await db.collection("Community").doc(title).update({
            members: FieldValue.arrayRemove(email)
        });
        res.json({
            "status": 1,
            "message": "Successfully left community"
        });
    } catch (error) {
        res.json({
            "status": 0,
            "message": "Error occurred. sdfds"
        });
    }
    
}

module.exports.joinCommunity = async (req, res) => {
    try {
        const {title, email} = req.body;
        const comm = await db.collection("Community").doc(title).update({
            members: FieldValue.arrayUnion(email)
        });
        res.json({
            "status": 1,
            "message": "Successfully joined community"
        });
    } catch (error) {
        res.json({
            "status": 0,
            "message": "Error occurred. sdfds"
        });
    }
}

//get all comms
