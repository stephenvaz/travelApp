const { FieldValue } = require("@google-cloud/firestore");
const { db } = require("../firestore_db");

module.exports.get_friends = async (req, res) => {
    try {

        const userEmail = req.body.data.email
        const userRef = await db.collection("Users").doc(userEmail);
        const userData = await userRef.get()
        const userDataObj = userData.data()
        if ("friends" in userDataObj) {
            const friendsArr = userData.data().friends
            let friendCount = friendsArr.length
            let totalRating = 0
            friendsArr.forEach((item) => {
                if (item.rating.status = "accepted" && item.rating == -999) {
                    friendCount--;
                }
                else {
                    totalRating = totalRating + item.rating
                }
            })

            res.send({
                friendList: friendsArr,
                avgRating: !friendCount ? 0 : totalRating / friendCount
            })
        }
        else {
            res.send({
                friendList: [],
                avgRating: 0
            })
        }
    }
    catch (e) {
        console.log(e)
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }

}
module.exports.send_friend_req = async (req, res) => {
    try {
        const data = req.body.data
        const toEmail = data.to
        const fromEmail = data.from
        const fromUserRef = await db.collection("Users").doc(fromEmail);
        const fromFriends = {
            email: toEmail,
            rating: -999,
            review: "",
            status: "received"
        }
        if (!("friends" in userDataObj)) {    
            const fromUserData = await fromUserRef.update({ friends: fromFriends })
        }
        else {
            const fromUserData = await fromUserRef.update({friends: [... ,fromFriends] })
        }

    }
    catch (e) {
        console.log(e)
        res.json({
            status: "0",
            message: "Error occurred.",
            error: `${e}`,
        });
    }
}

module.exports.accepted_friend_req = (req, res) => {
    console.log("yes")

}
module.exports.remove_friend = (req, res) => {
    console.log("yes")

}
module.exports.block_friend = (req, res) => {
    console.log("yes")

}