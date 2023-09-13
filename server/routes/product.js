const express = require('express');
const {Product} = require('../models/product');
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

productRoute.post('/api/rate-product', auth, async (req, res)=>{
    try {
        const { _id, rating } = req.body;
      let product = await Product.findById(_id);
      for(let i =0; i<product.ratings.length; i++){
        if(product.ratings[i].userId == req.user){
            product.ratings.splice(i,1);
            break;
        }
      }

      const ratingSchema = {
        userId: req.user,
        rating,
      }

      product.ratings.push(ratingSchema);
      product = await product.save();


      res.json(product)
    } catch (error) {
        res.status(500).json({msg: error.message})
    }
  });  

productRoute.get('/api/deal-of-day', auth, async (req, res) => {
   try {
    let product = await Product.find({});
  product =  product.sort((a,b)=>{
      let aSum =0;
      let bSum = 0;

      for(let i=0; i< a.ratings.length; i++){
        aSum += a.ratings[i].rating;
      }

      for(let i=0; i< b.ratings.length; i++){
        bSum += b.ratings[i].rating;
      }
      return aSum < bSum ? 1 : -1;
    });
res.json(product[0]);
   } catch (error) {
    res.status(500).json({msg : error.message});
   }
})  



module.exports = productRoute;