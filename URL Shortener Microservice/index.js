'use strict';

const { json } = require('body-parser');
const { url } = require('node:inspector');

const express = require('express'),
      mongo = require('mongodb'),
      mongoose = require('mongoose'),
      cors = require('cors'),
      dns = require('node:dns'),
      app = express();

require('dotenv').config()

// Basic Configuration 
const port = process.env.PORT || 3000;

/** this project needs a db !! **/ 
mongoose.connect(process.env.MONGOLAB_URI);

const urlSchema = new mongoose.Schema({
  url : {
    type: String,
    required: true
  }
})

let ShortenedURL = new mongoose.model('Shortened URL', urlSchema)

app.use(cors());

app.use('/api/shorturl', express.urlencoded())
app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function(req, res) {
  res.json({ greeting: 'hello API' });
});

app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});

const urlRegex = /^(?:https?:\/\/)?(?:www\.)?[a-zA-Z]+\.[a-zA-Z]+(?:\/[^\.\n]*)?$/
const dnsRegex = /(?=https?:\/\/)?(?:www\.)?[a-zA-Z]+\.[a-zA-Z]+(?!\/[^\.\n]*)?/

const matchDns = (url) => {
  if (dnsRegex.test(url)) {
    return url.match(dnsRegex)[0]
  } else {
    return null
  }
} 

app.post("/api/shorturl", (req, res) => {
  const longUrl = req.body.url;
  const longUrlDns = matchDns(longUrl);

  if (!longUrlDns) {
    res.json({ error: 'invalid url' })
  } else {
    dns.lookup(longUrlDns, (err, address, family) => {
      if (err) {
        console.log(!err && urlRegex.test(longUrl))
        res.json({ error: 'invalid url' })

      } else {
        const shortUrl = new ShortenedURL({
          url: longUrl
        })

        shortUrl.save().then((savedShortUrl) => {
          console.log(savedShortUrl.id);
          res.json({
            original_url: longUrl,
            short_url: shortUrl.id
          })
        })
      }
    })
  }
})

app.get("/api/shorturl/:short", (req, res) => {
  console.log(req.body)
})