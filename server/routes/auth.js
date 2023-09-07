const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        
        const {name, email, password} = req.body;
    
       const userExit = await User.findOne({email});
    
       if(userExit){
        return res.status(400).json({msg:'User with same email already exist'}) 
       }
       const hashedpassswors = await bcryptjs.hash(password, 8)
       let user = new User({
        email,
        password : hashedpassswors,
        name
       })
       user = await user.save();
       res.json(user);
    } catch (e) {
        res.status(500).json(e.message);
        // if(e.email.is)
        // else 
        // res.status(400).json(e);
    }
})

module.exports = authRouter;