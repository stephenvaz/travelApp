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
        const fromUserData = await fromUserRef.get()
        const fromUserDataObj = fromUserData.data()

        const fromFriends = {
            email: toEmail,
            rating: -999,
            review: "",
            status: "pending"
        }

        if (!("friends" in fromUserDataObj)) {
            const fromUserData = await fromUserRef.update(
                { friends: [fromFriends] }
            )
        }
        else {
            const fromUserData = await fromUserRef.update({ friends: [...fromUserDataObj.friends, fromFriends] })
        }


        const toUserRef = await db.collection("Users").doc(toEmail);
        const toUserData = await toUserRef.get()
        const toUserDataObj = toUserData.data()

        const toFriends = {
            email: fromEmail,
            rating: -999,
            review: "",
            status: "received"
        }

        if (!("friends" in toUserDataObj)) {
            const toUserData = await toUserRef.update(
                { friends: [toFriends] }
            )
        }
        else {
            const toUserData = await toUserRef.update({ friends: [...toUserDataObj.friends, toFriends] })
        }

        res.send("Updated")

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

module.exports.accept_friend_req = async (req, res) => {
    try {
        const data = req.body.data
        const userRef = await db.collection("Users").doc(data.user);
        const userData = await (await userRef.get()).data()

        const targetRef = await db.collection("Users").doc(data.target);
        const targetData = await (await targetRef.get()).data()

        const userFriends = []
        userData.friends.forEach((item) => {
            if (item.email == data.target) {
                userFriends.push({
                    ...item,
                    status: "accepted"
                })
            }
            else {

                userFriends.push(item)
            }
        })

        const userDataObj = userRef.update({ friends: userFriends })


        const targetFriends = []
        targetData.friends.forEach((item) => {
            if (item.email == data.user) {
                targetFriends.push({
                    ...item,
                    status: "accepted"
                })
            }
            else {

                targetFriends.push(item)
            }
        })

        const targetDataObj = targetRef.update({ friends: targetFriends })
        res.send("updated")
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
module.exports.remove_friend = async (req, res) => {
    try {
        
        const data = req.body.data

        const userRef = await db.collection("Users").doc(data.user);
        const userData = await (await userRef.get()).data()

        const targetRef = await db.collection("Users").doc(data.target);
        const targetData = await (await targetRef.get()).data()

        const userFriends = []
        userData.friends.forEach((item) => {
            if (item.email == data.target) {
                return
            }
            else {

                userFriends.push(item)
            }
        })

        const userDataObj = userRef.update({ friends: userFriends })


        const targetFriends = []
        targetData.friends.forEach((item) => {
            if (item.email == data.user) {
                return
            }
            else {

                targetFriends.push(item)
            }
        })

        const targetDataObj = targetRef.update({ friends: targetFriends })
        res.send("updated")

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
module.exports.review_friend = async (req, res) => {
    try {
        
        const data = req.body.data

        const userRef = await db.collection("Users").doc(data.user);
        const userData = await (await userRef.get()).data()

        const targetRef = await db.collection("Users").doc(data.target);
        const targetData = await (await targetRef.get()).data()

        const userFriends = []
        userData.friends.forEach((item) => {
            if (item.email == data.target) {
                userFriends.push({
                    ...item,
                    review : data.review,
                    rating : data.rating
                })
            }
            else {

                userFriends.push(item)
            }
        })

        const userDataObj = userRef.update({ friends: userFriends })

        res.send("updated")

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
module.exports.block_friend = async (req, res) => {
    try {
        const data = req.body.data
        const userRef = await db.collection("Users").doc(data.user);
        const userData = await (await userRef.get()).data()

        const targetRef = await db.collection("Users").doc(data.target);
        const targetData = await (await targetRef.get()).data()

        const userFriends = []
        userData.friends.forEach((item) => {
            if (item.email == data.target) {
                userFriends.push({
                    ...item,
                    status: "blocked"
                })
            }
            else {

                userFriends.push(item)
            }
        })

        const userDataObj = userRef.update({ friends: userFriends })

        res.send("updated")
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