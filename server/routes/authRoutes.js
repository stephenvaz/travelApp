const express = require("express");
const router = express.Router()
const auth = require("../contollers/auth");

router.post("/sign-up", auth.SignUp);
router.post("/login", auth.login);
router.post("/create_acc", auth.create_account);

module.exports = router;