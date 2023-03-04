const express = require("express");
const router = express.Router()
const auth = require("../contollers/auth");

router.post("/sign-up", auth.SignUp);
router.post("/login", auth.login);

module.exports = router;