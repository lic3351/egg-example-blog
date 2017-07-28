var md = require('markdown-it')();

module.exports = app => {
    return class ArticleController extends app.Controller {

        async index() {
            const ctx = this.ctx;
            let type=ctx.params.type;
            let docs;
            if(!type){
                 docs = await ctx.model.Article.find({}).sort('-lastmodified');
            }else{
                 docs = await ctx.model.Article.find({type:type}).sort('-lastmodified');
            }
            let types= await this.ctx.service.meta.find({domain:'type1'});
            let list=[];
            for(let i=0;i<types.length;i++){
                let a=types[i].type;
                let count=await this.ctx.model.Article.count({type:a});
                if(count>0)list.push({type:a,count:count});
            }
            await ctx.render('index.tpl', { docs: docs,list:list});
        }
        async read() {
            const ctx = this.ctx;
            let id = ctx.request.body.id;
            let article = await ctx.service.article.findById(id);
            await ctx.render('write.tpl', article);
        }
        async markdown() {
            const ctx = this.ctx;
            let metalist=await this.ctx.service.meta.find({domain:'type1'});
            await ctx.render('markdown.tpl',{metalist:metalist});
        }
        async list() {
            const ctx = this.ctx;
            let page = ctx.query.page || 1;
            let per_page = app.config.article.page_size;
            let start = (page - 1) * per_page;
            let data = await ctx.service.article.find(start, per_page, {});
            ctx.body = data;
        }
        async write() {
            const body = this.ctx.request.body;
            let user = this.ctx.session.user;
            let article = body;
            article = {
                author_name: user.name || 'lic',
                author_id: user.id || ''
            }
            await this.ctx.service.article.save(article);
        }
        async edit() {
            let aid = this.ctx.params.id;
            let a = await this.ctx.service.article.findById(aid);
            let metalist=await this.ctx.service.meta.find({domain:'type1'});
            await this.ctx.render('markdown.tpl', { article: a ,metalist:metalist});
        }

        async writem() {
            const body = this.ctx.request.body;
            let aid = body.aid;
            let article = {
                title: body.title,
                type: body.type,
                body: body.body
            };
            //看是否存在
            if (aid) {
                let conditions={_id:aid};
                let update={title:article.title,type:article.type,body:article.body};
                let rs= await this.ctx.service.article.update(conditions,update);
                await this.ctx.render('manager.tpl');
            } else {
                let rs = await this.ctx.service.article.save(article);
                this.ctx.redirect('/');
            }
        }
        async update() {
            const body = this.ctx.request.body;
            let user = this.ctx.session.user;
            let article = body;
            let conditions;
            let set;
            await this.ctx.service.article.update(conditions, set);
        }
        async del() {
            const aid = this.ctx.params.id;
            let rs = await this.ctx.service.article.del({ _id: aid });
            this.ctx.body = rs;
        }
        async single() {
            const aid = this.ctx.params.id;
            let article = await this.ctx.service.article.findById(aid);
            let conditions = { _id: aid };
            var update = { $inc: { views: 1 } };
            await this.ctx.service.article.update(conditions, update);
            await this.ctx.render('single.tpl', { article: article });
        }
        async addcom() {
            const aid = this.ctx.params.id;
            let body = this.ctx.request.body;
            let comment = {
                body: body.body,
                author_name: this.ctx.request.ip,
                date: Date.now()
            };
            let conditions = { _id: aid };
            let set = { $push: { comments: comment } };
            let rs = this.ctx.service.article.update(conditions, set)
            this.ctx.body = JSON.stringify(comment);
        }

    }
}