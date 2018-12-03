const express = require('express');
const router = express.Router();
const knex = require("../db/client");


router.get("/", (req, res) => {
knex("clucks")
    .orderBy("created_at", "desc")
    .then(clucks => {
    res.render("clucks", { clucks: clucks });
    });
});

router.get('/new', (req, res) => {
    res.render('clucks/new');
});

router.post("/newCluck", (req, res) => {
    knex("clucks")
      .insert({
        username: res.locals.username,
        content: req.body.content,
        imageUrl: req.body.image_url
      })
      .returning("*")
      .then(clucks => {
        const [cluck] = clucks;
        res.redirect("clucks");
    });
});



    


module.exports = router;