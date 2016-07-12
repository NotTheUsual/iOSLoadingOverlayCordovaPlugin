var exec = require('cordova/exec');

exports.show = function(title, message, success, error) {
  exec(success, error, 'LoadingOverlayPlugin', 'show', [title, message]);
};

exports.hide = function(success, error) {
  exec(success, error, 'LoadingOverlayPlugin', 'hide');
};
