const express = require('express');
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const Order = require('../models/order');

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

adminRoute.get('/admin/get-orders', admin, async (req, res)=>{
  try {
    const orders = await Order.find({})
    res.json(orders)
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
});

adminRoute.post('/admin/change-order-status', admin, async (req, res) => {
  try {
    const {_id, status} = req.body
   let order = await Order.findById(_id);
   order.status = status;
   order = await order.save();
    res.json(order);
  } catch (error) {
    res.status(500).json({msg: error.message})
  }
});

adminRoute.get('/admin/analytics', async (req,res) => {
  try {
    const orders = await Order.find({})
    let totalEarnings = 0;
    for(let i =0; i < orders.length; i++){
      console.log(orders[i].products.length);
      for(let j =0; j < orders[i].products.length; j++){
        totalEarnings += orders[i].products[j].product.quantity * orders[i].products[j].product.price;
      }
    }
    let mobileEarning = await fetchCategoryWise('Mobile');
    let essentialsEarning = await fetchCategoryWise('Essentials');
    let appliancesEarning = await fetchCategoryWise('Appliances');
    let booksEarning = await fetchCategoryWise('Books');
    let fashionEarning = await fetchCategoryWise('Fashion');

    let earnings = {
      totalEarnings,
      mobileEarning,
      essentialsEarning,
      appliancesEarning,
      booksEarning,
      fashionEarning
    }

    res.json(earnings)
  } catch (error) {
    res.status(500).json({msg: error.message});
  }
});

async function fetchCategoryWise(category){
  let earning =0;
  const categoryOrders = await Order.find({
    'products.product.category' : category
  });
  for(let i =0; i < categoryOrders.length; i++){
    for(let j =0; j < categoryOrders[i].products.length; j++){
      earning += categoryOrders[i].products[j].product.quantity * categoryOrders[i].products[j].product.price;
    }
  }
  return earning;
}

module.exports = adminRoute;