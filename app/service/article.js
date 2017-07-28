module.exports=app=>{
	return class ArticleService extends app.Service{
		async find(skip,limit,conditions){
			let total=await this.ctx.model.Article.count(conditions);
			let list=await this.ctx.model.Article.find(conditions).sort('-lastmodified').skip(skip).limit(limit).exec();
			let data={
				total:total,
				rows:list
			};
			return data;
		}

		async save(article){
			let a=this.ctx.model.Article(article);
			return await a.save();
		}
		async del(conditions){
			return await this.ctx.model.Article.deleteOne(conditions);
		}
		async update(conditions,set){
			return await this.ctx.model.Article.update(conditions,set);
		}
		async findById(id){
			return await this.ctx.model.Article.findOne({_id:id});
		}








	}
}