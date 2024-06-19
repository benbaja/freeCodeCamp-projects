// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 
app.get("/api/hello", function (req, res) {
  res.json({greeting: 'hello API'});
});



// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});

const dtFormat = {
  "weekday": "short", 
  "year": "numeric", 
  "month": "short", 
  "day": "2-digit", 
  "hour": "2-digit", 
  "minute": "2-digit", 
  "second": "2-digit", 
  "timeZone": "GMT", 
  "timeZoneName": "short", 
  "hour12": false}

app.get("/api/:date", (req, res) => {
  let inputDate;
  if (/^[0-9]*$/.test(req.params.date)) {
    inputDate = parseInt(req.params.date);
  } else {
    inputDate = req.params.date;
  }
  const parsedDate = inputDate ? new Date(inputDate) : new Date();
  console.log(parsedDate)
  if (! isNaN(parsedDate.getTime())) {
    const unixDate = parsedDate.getTime() ;

    const utcDate = parsedDate.toLocaleString("en-GB", dtFormat)
      .replace('UTC', 'GMT')
      .replace(/(?<=[0-9]{4}),/, ''); // removes comma after the year in GB formatting

    res.json({
      "unix": unixDate,
      "utc": utcDate
    });
  } else {
    res.json({
      "error": "Invalid Date"
    });
  }
})