const express = require('express')
const app = express()
const cors = require('cors')
const mongo = require('mongodb')
const mongoose = require('mongoose')
require('dotenv').config()

// mongoose schemas and models

mongoose.connect(process.env.MONGODB_URI);

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true
  }
});

const exerciseSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  duration: {
    type: Number,
    required: true
  },
  date: Date
});

let User = new mongoose.model('Users', userSchema);
let Exercise = new mongoose.model('Exercises', exerciseSchema);

// express app

app.use(cors())
app.use(express.static('public'))
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

app.use('/api/', express.urlencoded())

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})

app.post('/api/users', (req, res) => {
  console.log(req.body);
  const user = new User({username: req.body.username})
  user.save().then((userData) => {
    res.json({
      username: userData.username,
      _id: userData.id
    })
  })
})

app.get('/api/users', (req, res) => {
  User.find().then((data) => {
    let allUsers = [];
    data.forEach((user) => {
      allUsers.push({
        username: user.username,
        id: user.id
      })
    })
    res.json(allUsers)
  })
}); 