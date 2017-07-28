exports.keys = '<此处改为你自己的 Cookie 安全字符串>';
exports.session = {
  key: 'EGG_SESS', // 承载 Session 的 Cookie 键值对名字
  maxAge: 86400000, // Session 的最大有效时间
};

exports.view = {
  defaultViewEngine: 'nunjucks',
  mapping: {
    '.tpl': 'nunjucks',
  },
};
exports.mongoose = {
  url: 'mongodb://139.159.219.245/licblog',
  options: {}
};

exports.article={
	page_size:6
};
