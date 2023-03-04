// const firebase = require("firebase/app");
// const db = require("../firestore_db");
// const {getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword, signOut} = require("firebase/auth");
// const auth = require("../firestore_db");
// module.exports.register = (req, res) => {
//   try {
//     const {email, username, password} = req.body;
//     createUserWithEmailAndPassword(auth, email, password)
//     .then((userCredential) => {
//     const user = userCredential.user;
//       res.send("added user");
//       console.log(user);
//     })
//     .catch((error) => {
//     const errorCode = error.code;
//     const errorMessage = error.message;
//       console.log(error);
//     });
//     res.redirect('/');
//     } catch(e) {
//       console.log(e)
//     res.redirect('/register');
//   }
// }
// module.exports.login = (req, res) => {
//   const {email, password} = req.body;
//   signInWithEmailAndPassword(auth, email, password)
//   .then((userCredential) => {
//     res.send("Logged in");
//   var user = userCredential.user;
//   })
//   .catch((error) => {
//   var errorCode = error.code;
//   var errorMessage = error.message;
//   });
//   res.redirect('/');
// }

// module.exports.logout =  (req, res) => {
//   signOut().then(() => {
//     res.redirect('/login');
//   }).catch((error) => {
//     console.log(error);
//   });
// }