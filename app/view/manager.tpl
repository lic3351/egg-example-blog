{% extends 'base.tpl' %} {% block headadd %}
<script src="/public/js/vue@2.4.2.js"></script>
<script src="/public/js/vue-resource.js"></script>
{% endblock %} {% block content %}
  <div style='text-align:right;'> 
<table id="t1" class="table table-striped">
    <tr v-for='item in rows'>
        <td>${item.title}</td>
        <td>${item.type}</td>
        <td>${new Date(item.lastmodified).toLocaleString()}</td>
        <td>回复：${item.comments.length}</td>
        <td>
            <a class="btn" :href="'/a/edit/'+item._id">edit</a>
            <button class="btn btn-danger" @click="del(item._id)">删除</button>
        </td>
    </tr>
</table>
</div>
<div id="meta">
    <div class="form-inline">
        <div class="input-group col-md-3">
            <input type="text" v-model="row.domain" name="domain" placeholder="domain" class="form-control">
        </div>
        <div class="input-group col-md-3">
            <input type="text" v-model="row.type" name="type" placeholder="type" class="form-control">
        </div>
        <div class="input-group col-md-3">
            <input type="text" v-model="row.color" name="color" placeholder="color" class="form-control">
        </div>
        <div class="input-group col-md-2">
            <span class="btn btn-primary" @click="add">+</span>
             <span id="update" class="btn btn-info" style="display: none" @click="update">update</span>
        </div>
    </div>
   <div style='text-align:right;'> 
    <table id="t2" class="table table-striped"  style='margin:0px auto;'>
    	<tr>
    		<td>domain</td>
    		<td>type</td>
    		<td>color</td>
    		<td>操作</td>
    	</tr>
        <tr v-for='item in rows'>
            <td>${item.domain}</td>
            <td>${item.type}</td>
            <td :style="{color:item.color}">${item.color}</td>
            <td colspan="2">
                <button class="btn " @click="edit(item._id)">edit</button>
                <button @click="del(item._id)" class="btn btn-danger">—</button>
            </td>
        </tr>
    </table>
    </div>
</div>
{% endblock %}

{% block rightsider %}
                <div class="right-sider">
                    <ul class="nav" role="tablist">
                        <li role="presentation" class="active"><a href="#">日记 <span class="badge">42</span></a></li>
                        <li role="presentation"><a href="#">nodejs <span class="badge">22</span></a></li>
                        <li role="presentation"><a href="#">java <span class="badge">3</span></a></li>
                    </ul>
                </div>
{% endblock %}



{% block jscss %}
<script type="text/javascript">
new Vue({
    delimiters: ['${', '}'],
    el: '#t1',
    data: {
        msg: 'hello',
        rows: [],
        total: ''
    },
    methods:{
    	del:function(aid){
        	let self=this;
            $.ajax({
                url: '/a/'+aid,
                type: 'DELETE',
                dataType: 'JSON',
                data: {},
                success: function() {
                	self.rows=self.rows.filter(row=>{
                		return row._id!=aid;
                	});
                }
            });
        }
    },
    beforeCreate: function() {
        // GET /someUrl
        this.$http.get('/a/list').then(response => {
            // get body data
            let rs = response.body;
            this.rows = rs.rows;
            this.total = rs.total;
        }, response => {
            // error callback
        });
    }

});

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
new Vue({
    delimiters: ['${', '}'],
    el: '#meta',
    data: {
        rows:[],
        row: {
        	_id:'',
            domain: '',
            type: '',
            color: ''
        }
    },
    methods: {
        add: function() {
        	let self=this;
            $.ajax({
                url: '/meta',
                type: 'post',
                dataType: 'JSON',
                data: { data: self.row },
                success: function(data) {
                    if(self.rows.length>0)
                    	self.rows.push(data);
                    else self.rows=[data];
                }
            });
        },
        del:function(cid){
        	let self=this;
            $.ajax({
                url: '/meta',
                type: 'DELETE',
                dataType: 'JSON',
                data: { id: cid },
                success: function() {
                	self.rows=self.rows.filter(row=>{
                		return row._id!=cid;
                	});
                }
            });
        },
        edit:function(cid){
        	$('#update').css("display","inline-block");
        	let self=this;
            this.rows.forEach(function(v,i){
            	if(v._id==cid) self.row=v;
            });
        },
        update:function(){
        	let self=this;
        	 $.ajax({
                url: '/meta',
                type: 'PUT',
                dataType: 'JSON',
                data: { meta: self.row },
                success: function(data) {
                	$('#update').css("display","none");
                	self.row=null;
                }
            });
        }
    },
    beforeCreate: function() {
        // GET /someUrl
        this.$http.get('/meta').then(response => {
            // get body data
            let list = response.body;
            this.rows=list;
        }, response => {
            // error callback
        });
    }

});


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
</script>
{% endblock %}