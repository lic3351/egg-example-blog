module.exports=app=>{
	return class MetaService extends app.Service{
		async find(conditions){
			let data=await this.ctx.model.Meta.find(conditions).exec();
			return data;
		}

		async save(meta){
			let a=this.ctx.model.Meta(meta);
			return await a.save();
		}
		async del(conditions){
			return await this.ctx.model.Meta.deleteOne(conditions);
		}
		async update(conditions,set){
			return await this.ctx.model.Meta.update(conditions,set);
		}
		async findById(id){
			return await this.ctx.model.Meta.findOne({_id:id});
		}








	}
}