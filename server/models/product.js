const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    name :{
        type: String,
        required: true,
        trim: true
    },
    description : {
        type: String,
        required : true,
        trim : true,
    },
    images: [
        {
            type : String,
            require : true
        }
    ],
    quantity : {
        type :  Number,
        require : true
    },
    price: {
        type : Number,
        require : true,
    },
    category : {
        type: String,
        required : true
    }

});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;