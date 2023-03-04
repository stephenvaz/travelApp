const express = require("express");
const app = express();
const db = require("./firestore_db");


app.use(express.json());
app.use(express.urlencoded({ extended: true }));


//initialize app

// const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");

//routes
app.use('/', userRoutes);


app.listen(3000, () => {
    console.log("Listening on port 3000");
})