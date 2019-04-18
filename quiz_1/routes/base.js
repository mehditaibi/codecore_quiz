const express = require('express');
const router = express.Router();


 router.get('/', (request, response) => {
  response.render('home');
});

const COOKIE_MAX_AGE = 1000 * 60 * 60 * 24 * 7;
router.post("/sign_in", (req, res) => {
  const username = req.body.username;
 
  res.cookie("username", username, { maxAge: COOKIE_MAX_AGE });
  res.locals.username = username;

  res.redirect("/clucks");
});

router.post("/sign_out", (req, res) => {
  res.clearCookie("username");
  res.redirect("/");
});

 module.exports = router;