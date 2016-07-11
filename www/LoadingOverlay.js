var exec = require('cordova/exec');

exports.show = function(title, message, success, error) {
  exec(success, error, 'LoadingOverlay', 'show', [title, message]);
};

exports.hide = function(success, error) {
  exec(success, error, 'LoadingOverlay', 'hide');
};
