module.exports = app => {
  const mongoose = app.mongoose;
  const MetaSchema = new mongoose.Schema({
   domain:String,
   type:String,
   color:String
  });

  return mongoose.model('Meta', MetaSchema);
}