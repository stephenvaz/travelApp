const express = require("express");
const bodyParser = require("body-parser");
const db = require("./firestore_db");
const multer = require("multer");
const cors = require("cors");
const profile = require('./routes/profileRoutes')
const friend = require('./routes/friendRoutes')

const app = express();
const upload = multer();
app.use(upload.array());
app.use(cors());

app.use(bodyParser.json());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


//initialize app

// const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");
const authRoutes = require("./routes/authRoutes");
//routes
app.use('/', userRoutes);
app.use('/', authRoutes);
app.use('/', profile);
app.use('/', friend);

app.listen(3000, () => {
    console.log("Listening on port 3000");
})