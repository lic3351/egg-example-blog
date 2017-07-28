module.exports = app => {
  const mongoose = app.mongoose;
  const ArticleSchema = new mongoose.Schema({
   author_name:{type:String,default:'lic'},
   author_id:String,
   title:String,
   body:String,
   type:String,
   lastmodified:{type:Date,default:Date.now},
   status:{type:Number,default:0},
   views:{type:Number,default:1},
   comments:[{body:String,date:Date,author_name:String}]
  });

  return mongoose.model('Article', ArticleSchema);
}