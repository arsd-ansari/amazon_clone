const express = require('express');
const admin = require('../middlewares/admin');
const Product = require('../models/product');

const adminRoute = express.Router();

adminRoute.post('/admin/add-product', admin, async (req, res)=>{
    try {
      const  {name, description, images, quantity, price, category} = req.body;
      let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category
      })
      product = await product.save();
      res.json(product)
    } catch (error) {
        res.status(500).json({msg: error.message})
    }
});

adminRoute.get('/admin/get-products', admin, async (req, res)=>{
  try {
    const product = await Product.find({});
    res.json(product)
  } catch (error) {
      res.status(500).json({msg: error.message})
  }
});

adminRoute.post('/admin/delete-product', admin, async (req, res) => {
  try {
    const _id = req.body
    await Product.findByIdAndDelete(_id)
    res.json({'msg' : 'Product Removed'});
  } catch (error) {
    res.status(500).json({msg: error.message})
  }
})

module.exports = adminRoute;