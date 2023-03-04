const express = require("express");
const router = express.Router()
const user = require("../contollers/user");

// router.post('/login', auth.login);
// router.post('/register', auth.register);
// router.post('/logout', auth.logout);
router.post("/sign-up", user.SignUp);

module.exports = router;