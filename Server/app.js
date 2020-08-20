const express=require('express')
const app=express()
const mongoose=require('mongoose')
const PORT=8000

const {MONGOURI}=require('./keys')
mongoose.connect(MONGOURI)
mongoose.connection.on('connected',()=>{
    console.log("connected")
})
mongoose.connection.on('error',(err)=>
{
    console.log("error")
})
require('./models/users')
require('./models/post')
app.use(express.json())
app.use(require('./routes/auth'))
app.use(require('./routes/post'))


app.listen(8000,'192.168.1.85',()=>{
    console.log("App is listning on port",PORT)
})