{% extends 'base.tpl' %}

{% block content %} 
<div class="container col-md-8 col-md-offset-3 login">
	<form class="" action="/login" method="post">
    <div class="input-group">
      <div class="input-group-addon">
      <span class="glyphicon glyphicon-user"></span></div>
      <input type="text" class="form-control" id="" name="name" placeholder="用户名" autofocus="true">
    </div>
 
    <div class="form-group">
    <div class="input-group">
      <div class="input-group-addon">
      <span class="glyphicon glyphicon-lock"></span></div>
      <input type="password" class="form-control" id="passwd" name="passwd"  placeholder="密码">
    </div>
  </div>
     <div class="form-group">
      <button  id="lg" class="submit btn btn-block btn-primary">登录</button>
        <a class="btn btn-ms btn-default btn-block" href="/">返回首页</a>
      </div>
  </form>      
</div>

{% endblock %}

{% block rightsider %}  {% endblock %}
{% block jscss %} 
<style type="text/css">
	.login{
		position: absolute;
		top:100px;
	}
</style>
{% endblock %}