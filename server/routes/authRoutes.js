const express = require("express");
const router = express.Router()
const auth = require("../contollers/auth");

router.post("/sign-up", auth.SignUp);
router.post("/login", auth.login);
router.post("/create_acc", auth.create_account);
router.get("/verify_mail/:email", auth.verify_mail);

module.exports = router;