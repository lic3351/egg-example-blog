const moment = require('moment');
moment.locale('zh-cn');
exports.relativeTime = time => moment(new Date(time)).fromNow();