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

// users endpoints

app.post('/api/users', (req, res) => {
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
        _id: user.id
      })
    })
    res.json(allUsers)
  })
}); 

// exercises endpoint

app.post('/api/users/:_id/exercises', (req, res) => {
  User.findById(req.params._id).then((userData) => {
    const exercise = new Exercise({
      username: userData.username,
      description: req.body.description,
      duration: req.body.duration,
      date: req.body.date ? new Date(req.body.date) : new Date()
    })

    exercise.save().then((exerciseData) => {
        res.json({
          username: userData.username,
          description: exerciseData.description,
          duration: exerciseData.duration,
          date: exerciseData.date.toDateString(),
          _id: userData.id
        })
      })
    }).catch((err) => res.json({error: "invalid user ID"}))
})

// log endpoint

app.get('/api/users/:_id/logs', (req, res) => {
  let exerciseFilter = {};
  console.log(req.query)
  if (req.query.from) {
    exerciseFilter.date = {} ;
    exerciseFilter.date.$gte = req.query.from ;
  }
  if (req.query.to) {
    exerciseFilter.date = exerciseFilter.date ? exerciseFilter.date : {} ;
    exerciseFilter.date.$lte = req.query.to ;
  }

  User.findById(req.params._id).then((userData) => {
    exerciseFilter.username = userData.username;
    console.log(exerciseFilter)
    Exercise.find(exerciseFilter)
      .limit(req.query.limit ? parseInt(req.query.limit) : null)
      .then((exercisesData) => {
        let allExercises = [];

        exercisesData.forEach((exercise) => {
          allExercises.push({
            description: exercise.description,
            duration: exercise.duration,
            date: exercise.date.toDateString()
          })
        })
      
        res.json({
          username: userData.username,
          count: allExercises.length,
          _id: userData.id,
          log: allExercises
        })
    })
    }).catch((err) => res.json({error: "invalid user ID"}))
})