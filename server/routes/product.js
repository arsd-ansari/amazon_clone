const express = require('express');
const Product = require('../models/product');
const auth = require('../middlewares/auth');

const productRoute = express.Router();

productRoute.get('/api/products', auth, async (req, res)=>{
  try {
    const product = await Product.find({category : req.query.category});
    res.json(product)
  } catch (error) {
      res.status(500).json({msg: error.message})
  }
});

productRoute.get('/api/products/search/:name', auth, async (req, res)=>{
    try {
      const product = await Product.find({
        name: {$regex: req.params.name, $options: 'i'},
      });
      res.json(product)
    } catch (error) {
        res.status(500).json({msg: error.message})
    }
  });



module.exports = productRoute;