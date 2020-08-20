const express=require('express')
const router=express.Router()
const mongoose=require('mongoose')
const Post=mongoose.model("Post")
const requireLogin=require('../middleware/requireLogin')


router.get('/allpost',(req,res)=>{
    Post.find().populate('postedBy','_id name').then(results=>{
     res.json({results})
    })
})

router.post('/createpost',requireLogin,(req,res)=>{
    const{title,body}=req.body
    if(!title||!body)
    {
        return res.status(422).json({error:"please add title and body"})
    }
    req.user.password=undefined
    const post=new Post({
        title,
        body,
        postedBy:req.user
    })
    post.save().then(result=>{
        res.json({post:result})
    }).catch(err=>{
        console.log(err)
    })
})
router.get('/mypost',requireLogin,(req,res)=>{
    Post.find({postedBy:req.user._id}).populate('postedBy','_id name').then(results=>{
        res.json({results})
       }).catch(err=>{
           console.log(err)
       })
       
})

module.exports=router