const express = require('express');
const userRoute = express.Router();
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');


userRoute.post('/api/add-to-cart', auth, async (req, res)=>{
    try {
    const {id}= req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);   
    if(user.cart.length == 0){
        user.cart.push({product, quantity :1})
    } else {
        let isProductFound = false
        for(let i=0; i < user.cart.length; i++){
            if(user.cart[i].product){

                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
                }
            }
        }

        if(isProductFound){
            let producttt = user.cart.find((productt) => productt.product ? productt.product._id.equals(product._id) : false);
            producttt.quantity +=1;
        } else {
            user.cart.push({product, quantity : 1});
        }
    }
    user = await user.save();
    res.json(user);
    } catch (error) {
        res.status(500).json({msg: error.message})
    }
});

userRoute.delete('/api/remove-from-cart/:_id', auth, async (req, res)=>{
    try {
    const _id = req.params;
    const product = await Product.findById(_id);
    let user = await User.findById(req.user);   
    for(let i=0; i < user.cart.length; i++){
        if(user.cart[i].product){

            if(user.cart[i].product._id.equals(product._id)){
                if(user.cart[i].quantity == 1){

                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
            }
        }
    }
    user = await user.save();
    res.json(user);
    } catch (error) {
        res.status(500).json({msg: error.message})
    }
});

module.exports = userRoute;