const express = require('express');
const app = express();
const nodemon = require('nodemon');
app.use(express.json());

//MongoDB Package
const mongoose = require('mongoose');

const PORT = 1250;
//using CryptMessage table... :(
const dbUrl = "mongodb+srv://admin:Password1@cluster.qtabs.mongodb.net/CryptMessage?retryWrites=true&w=majority";

//Connect to MongoDB
mongoose.connect(dbUrl,
  {
    useNewUrlParser: true,
    useUnifiedTopology: true
  });

//MongoDB Connection
const db = mongoose.connection;

//Handle DB Error, display connection
db.on('error', () => {
  console.error.bind(console, 'connection error: ');
});
db.once('open', () => {
  console.log('MongoDB Connected');
});

require('./Models/Cryptocurrency');

const Crypto = mongoose.model('Crypto');

app.get('/', (req, res) => {
  return res.status(200).json("{message: OK}");
});

app.post('/addCoin', async (req, res) => {
  try {
    let coin = {
      price: req.body.price,
      coinName: req.body.coinName,
      coinTicker: req.body.coinTicker
    }

    await Crypto(coin).save().then(c => {
      return res.status(201).json("Coin Added!");
    });
  }
  catch {
    return res.status(500).json("{message: Failed to add coin - bad data}");
  }
});

app.get('/getCoins', async (req, res) => {
  try {
    let coins = await Crypto.find({}).lean();
    //make sure to return a json object to deserialize
    return res.status(200).json({ "coins": coins });
  }
  catch {
    return res.status(500).json("{message: Failed to access coin data}");
  }
});

app.post('/editCoin', async (req, res) => {
  try {
    coin = await Crypto.updateOne({ _id: req.body.id }
      , {
        price: req.body.price
      });
    if (coin) {
      res.status(200).json("{message: Coin Edited}");
    }
    else {
      res.status(200).json("{message: No Coin Changed}");
    }
  }
  catch {
    return res.status(500).json("{message: Failed to edit coin}");
  }
});

app.post('/deleteCoin', async (req, res) => {
  try {
    let coin = await Crypto.findOne({ _id: req.body.id });

    if (coin) {
      await Crypto.deleteOne({ _id: req.body.id });
      return res.status(200).json("{message: Coin deleted}");
    }
    else {
      return res.status(200).json("{message: No coin deleted - query null}")
    }
  }
  catch {
    return res.status(500).json("{message: Failed to delete coin}");
  }
});

app.listen(PORT, () => {
  console.log(`Server Started on port ${PORT}`);
});