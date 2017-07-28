<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>写</title>

   <script src="/public/js/es5-shim.min.js"></script>
    <script src="/public/js/jquery.min.js"></script>
    <script src="/public/js/lodash.js"></script>
   <script src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/public/css/github.min.css">
   <script src="/public/js/markdown-it.js"></script>
    <script src="https://twemoji.maxcdn.com/twemoji.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/public/css/markdown.css">
    <script src="/public/js/markdown-index.js"></script>
</head>
<body>

 <div class="container-fluid" style="">
      <h2>
        Licblog
         <small>...</small>
      </h2>
    </div>
    <div class="container-fluid">
     <form id="f1" action="/a/m" method="post" class="form-inline" data-aid="  {{article._id}}">
        <div class="input-group col-md-4">
          <span class="input-group-addon glyphicon glyphicon-pencil"></span>
            <input id="" name="title" placeholder="Title" type="input" class="form-control" value="{{article.title}}"> 
        </div>
        <div class="input-group">
           <select class="form-control" name="type">
            {% for item in metalist %}
            <option value="{{item.type}}" {% if(item.type==article.type)%} selected {%endif%}>{{item.type}}</option>
            {% endfor %}
          </select>
          <input type="hidden" name="aid" value="{{article._id}}">
          <input type="hidden" name="body">
        </div>
          <button id="submit" class="btn btn-primary">保存</button> 
      </form> 
    </div>
    <div id="markdown" class="container-fluid full-height">
      <div class="row full-height">
        <div class="col-md-6 full-height">
         <div class="demo-control"></div>
          <textarea class="source full-height">{% if(article.body)%}{{article.body}}{%else%}# hello{%endif%}</textarea>
        </div>
        <section class="col-md-6 full-height">
          <div class="demo-control">
          <a href="/" class="source-clear">返回</a><a href="#" class="source-clear">clear</a>
          <a href="#" data-result-as="html">html</a><a href="#" data-result-as="src">source</a><a href="#" data-result-as="debug">debug</a></div>
          <div class="result-html full-height"></div>
          <pre class="hljs result-src full-height"><code class="result-src-content full-height"></code></pre>
          <pre class="hljs result-debug full-height"><code class="result-debug-content full-height"></code></pre>
        </section>
      </div>
    </div>
    <div class="gh-ribbon"><a href="https://github.com/lic3351" target="_blank">Fork me on GitHub</a></div>
  

<script type="text/javascript">
$('#submit').on('click',function(){
  var body=$('.source').val();
  $('input[name=body]').val(body);
  
});
</script>
<style type="text/css">
 
</style>
</body>
</html>