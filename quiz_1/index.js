const express = require("express");
const app = express();
const path = require("path");
const cookieParser = require("cookie-parser");

const logger = require("morgan");
app.use(logger("dev"));

app.use(express.urlencoded({ extended: true }));

app.use(cookieParser());

app.set("view engine", "ejs");


app.use(express.static(path.join(__dirname, "public")));

app.use((req, res, next) => {
    console.log("Cookies:", req.cookies);
    
    const username = req.cookies.username;
  
    res.locals.username = "";
    if (username) {
      res.locals.username = username;
      console.log(`sign in as ${username}`);
    }
    next();
  });
  

const baseRouter = require('./routes/base');
app.use('/', baseRouter);

const clucksRouter = require('./routes/clucks');
app.use('/clucks', clucksRouter);


const PORT = 4545;
const HOST = "localhost"; 
app.listen(PORT, HOST, () => {
  console.log(`Server listening on http://${HOST}:${PORT}`);
});