const express = require("express")
const router = express.Router()
const friend = require("../contollers/friend");
        //add, remove(accepted, blocked, reject)

router.post('/friends', friend.get_friends )
router.post("/friend_req_send", friend.send_friend_req);
router.post("/friend_req_accepted", friend.accepted_friend_req);

router.post("/friend_remove", friend.remove_friend );
router.post("/friend_block", friend.block_friend);

module.exports = router
