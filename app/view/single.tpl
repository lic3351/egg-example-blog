{% extends 'base.tpl' %}
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"> {% block head%}
    <title>文章</title>
    <script src="/public/js/jquery.min.js"></script>
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/public/css/index.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="/public/js/lodash.js"></script>
    <link rel="stylesheet" href="/public/css/github.min.css">
    <script src="/public/js/markdown-it.js"></script>
    <script src="https://twemoji.maxcdn.com/twemoji.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/public/css/markdown.css">
    <!-- <script src="/public/js/markdown-index.js"></script> -->
    {% endblock %}
</head>

<body>
    {% block content %}
    <div class="article" data-aid="{{article._id}}">
        <span><h2>{{article.title}}</h2>           
         </span>
         <label class="label label-info">{{article.type}}</label>
        <hr class="red">
        <div id="body" data-body="{{article.body}}">
        </div>
    </div>
    <hr class="blue">
    <div class="comments" style="">
        <ul>
            {% for item in article.comments %}
            <li>{{item.body}}<span class="meta pright"><span class="by">
                  
              by <a href="/user/ryanlol">{{item.author_name}}</a></span> |<span class="time"> {{ helper.relativeTime(item.date)}}
            </span></li>
            {% endfor %}
        </ul>
    </div>
    <div class="input-group liuyan">
        <span class="input-group-addon glyphicon glyphicon-comment"></span>
        <input type="text" name="liuyan" class="form-control">
        <span id="liuyan" class="input-group-addon btn btn-primary">留言</span>
    </div>
    {% endblock %} 



 {% block jscss %}
    <style type="text/css">

    </style>
    <script type="text/javascript">
    var showcom = function() {
        $('.comments').slideToggle(300);
    }
    </script>
    <style type="text/css">
    .article {
        background-color: #fff;
        padding: 20px 20px 20px 20px;
        border-bottom: 1px solid #eee;
        position: relative;
        line-height: 20px;
        margin: 0px;
    }

    hr.red {
        border: 1px solid red;
    }

    hr.blue {
        border: 1px solid #42b983;
    }

    h2 {
        display: inline-block;
    }

    .liuyan {
        margin-bottom: 60px;
    }

    .pright {
        display: block;
        text-align: right;
    }
    </style>
    <script type="text/javascript">
    $(function() {
        var str = $('#body').data('body');
        var md = window.markdownit();
        var result = md.render(str);
        $('#body').html(result);

        //处理table 和 img
        $('table').addClass('table table-striped');
        $('img').css("max-width", "50%");

        var csrftoken = getCookie('csrfToken');

        function csrfSafeMethod(method) {
            // these HTTP methods do not require CSRF protection
            return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
        }
        $.ajaxSetup({
            beforeSend: function(xhr, settings) {
                if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
                    xhr.setRequestHeader('x-csrf-token', csrftoken);
                }
            },
        });
        $('#liuyan').on('click', function() {

            var aid = $('.article').data('aid');
            var str = $('input[name=liuyan]').val();
            $.ajax({
                url: '/a/' + aid,
                type: 'put',
                dataType: 'JSON',
                data: { body: str },
                success: function(data) {
                    location.reload('/a/' + aid);
                }
            });

        })
    })


    function getCookie(c_name) {
        if (document.cookie.length > 0) {
            c_start = document.cookie.indexOf(c_name + "=")
            if (c_start != -1) {
                c_start = c_start + c_name.length + 1
                c_end = document.cookie.indexOf(";", c_start)
                if (c_end == -1) c_end = document.cookie.length
                return unescape(document.cookie.substring(c_start, c_end))
            }
        }
        return ""
    }

    function setCookie(c_name, value, expiredays) {
        var exdate = new Date()
        exdate.setDate(exdate.getDate() + expiredays)
        document.cookie = c_name + "=" + escape(value) +
            ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString())
    }
    </script>
     {% endblock %}
</body>

</html>