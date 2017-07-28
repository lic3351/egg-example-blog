{% extends 'base.tpl' %}

{% block content %}
    <div class="news-list">
        <ul>
            {% for item in docs %}
            <li class="news-item"><span class="score">{{item.views}}</span><span class="title"><a href="/a/{{item._id}}">{{item.title}}</a><span class="host"></span></span>
                <br><span class="meta"><span class="by">
          by <a href="#">{{item.author_name}}</a></span><span class="time">
          {{ helper.relativeTime(item.lastmodified)}}
        </span><span class="comments-link">
          | <a href="javascript:showcom()">{{item.comments.length}} comments</a></span></span>
            </li>
           {% endfor %}
        </ul>

    </div>
{% endblock %}


