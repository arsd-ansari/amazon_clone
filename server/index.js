const  express = require("express");
const authRouter = require("./routes/auth")
const adminRoute = require("./routes/admin")
const productRoute = require("./routes/product")
const mongoose = require("mongoose");
const userRoute = require("./routes/user");

const PORT = 3000;
const DB = "mongodb+srv://arsdansari291:43ngrcWf3kYIV7RN@cluster0.ymujl0e.mongodb.net/?retryWrites=true&w=majority"

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
app.use(productRoute);
app.use(userRoute);

mongoose.connect(DB).then(()=> {
    console.log('Connection Successfull');
}).catch((e)=>{
    console.log(`Error--${e}`)
})

app.listen(PORT, "0.0.0.0", () => {
    console.log('Connected at port' + PORT)
})