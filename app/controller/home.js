module.exports=app=>{
	return class HomeController extends app.Controller{
		async index(){
			await this.ctx.render('index.tpl');
		}

		async search(){
			let body=this.ctx.request.body;
			let v=body.search;
			if(v=='login'){
				await this.ctx.render('login.tpl');
			}else{
				await this.ctx.redirect('/');
			}
		}

		async login(){
			let body=this.ctx.request.body;
			if(body.name=='lic' && body.passwd=='lic3351'){
				await this.ctx.redirect('/manage');
			}else{
				await this.ctx.redirect('/');
			}
			
		}

		async manage(){
			await this.ctx.render('manager.tpl');
		}
		async getmeta(){
			let list=await this.ctx.service.meta.find({});
			this.ctx.body=list;
		}
		async postmeta(){
			let body=this.ctx.request.body.data;
			let m={
				domain:body.domain,
				type:body.type,
				color:body.color
			};
			let rs=await this.ctx.service.meta.save(m);
			this.ctx.body=rs;
		}

		async delmeta(){
			let id=this.ctx.request.body.id;
			let rs=await this.ctx.service.meta.del({_id:id});
			this.ctx.body=rs;
		}
		async putmeta(){
			let meta=this.ctx.request.body.meta;
			let m={
				domain:meta.domain,
				type:meta.type,
				color:meta.color
			};
			let conditions={_id:meta._id};
			let update={domain:m.domain,type:m.type,color:m.color};
			let rs=await this.ctx.service.meta.update(conditions,update);
			this.ctx.body=rs;
		}
	}
};