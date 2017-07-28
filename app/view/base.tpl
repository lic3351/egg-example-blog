<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"> {% block head %}
    <title>日记</title>
    <script src="/public/js/jquery.min.js"></script>
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/public/css/index.css">
    <meta name="viewport" content="width=device-width, initial-scale=1"> {% endblock %}
    {% block headadd %}{% endblock %}
</head>

<body>
    {% block nav %}
    <div class="bar">
        <nav class="navbar navbar-default col-md-8 col-md-offset-2">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">licblog</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
                    <li><a href="/a/m">写</a></li>
                </ul>
                <form class="navbar-form navbar-right" method="post" action="/search">
                    <div class="form-group">
                        <input type="text" name="search" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </form>
            </div>
            <!-- /.navbar-collapse -->
            <!-- /.container-fluid -->
        </nav>
    </div>
    {% endblock %}
    <div class="container col-md-8 col-md-offset-2">
        <div class="row">
            <div class="col-md-9 content">
                {% block content %} {% endblock %}
            </div>
            <div class="col-md-3 hidden-xs">
                {% block rightsider %}
                <div class="right-sider">
                    <ul class="nav" role="tablist">
                        {% for item in list%}
                        <li role="presentation" class="active"><a href="/{{item.type}}">{{item.type}} <span class="badge">{{item.count}} </span></a></li>
                        {% endfor %}
                        
                    </ul>
                </div>
                {% endblock %}
            </div>
        </div>
    </div>
    {% block jscss %} {% endblock %}
</body>

</html>