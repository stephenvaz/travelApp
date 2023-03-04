const express = require("express");
const router = express.Router()
const user = require("../contollers/user");
const {isAuth} = require("../middleware");

router.post("/add-trip", isAuth, user.addTrip);

//get all trips
router.get("/get-nearby", user.getTrips);

module.exports = router;