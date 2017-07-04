
var cookie = function () {
  var cookies = document.cookie.split("; ");
  var cookieList = [];
  cookies.map(function (cookie) {
    var cookies = cookie.split("=");
    cookieList[cookies[0]] = cookies[1];
  }.bind(this));
  return cookieList;
};

module.exports = cookie;