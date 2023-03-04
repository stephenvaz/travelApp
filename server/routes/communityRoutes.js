const express = require("express");
const router = express.Router()
const community = require("../contollers/community");

router.post("/get-comm", community.getAll);
router.post("/create", community.createCommunity);
router.post("/leave", community.leaveCommunity);
router.post('/join', community.joinCommunity);
 

module.exports = router;