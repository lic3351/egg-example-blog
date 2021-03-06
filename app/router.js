module.exports=app=>{
	//app.get('/',app.controller.home.index);
	app.post('/search',app.controller.home.search);
	app.post('/login',app.controller.home.login);
	app.get('/manage',app.controller.home.manage);
	app.get('/meta',app.controller.home.getmeta);
	app.post('/meta',app.controller.home.postmeta);
	app.put('/meta',app.controller.home.putmeta);
	app.del('/meta',app.controller.home.delmeta);
	app.get('/',app.controller.article.index);
	app.get('/:type',app.controller.article.index);
	app.get('/a/w',app.controller.article.read);
	app.get('/a/list',app.controller.article.list);
	app.post('/a/list',app.controller.article.write);
	app.get('/a/m',app.controller.article.markdown);
	app.get('/a/edit/:id',app.controller.article.edit);
	app.post('/a/m',app.controller.article.writem);
	app.get('/a/:id',app.controller.article.single);
	app.put('/a/:id',app.controller.article.addcom);
	app.del('/a/:id',app.controller.article.del);
	// app.put('/a/list/:id',app.controller.article.update);
	// app.del('/a/list/:id',app.controller.article.del);
};