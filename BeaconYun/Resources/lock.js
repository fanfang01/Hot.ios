// { "framework": "Weex" }
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var __weex_template__ = __webpack_require__(1)
	var __weex_style__ = __webpack_require__(2)
	var __weex_script__ = __webpack_require__(3)

	__weex_define__('@weex-component/9082fd8b30e33ba72afcea604ebcc52f', [], function(__weex_require__, __weex_exports__, __weex_module__) {

	    __weex_script__(__weex_module__, __weex_exports__, __weex_require__)
	    if (__weex_exports__.__esModule && __weex_exports__.default) {
	      __weex_module__.exports = __weex_exports__.default
	    }

	    __weex_module__.exports.template = __weex_template__

	    __weex_module__.exports.style = __weex_style__

	})

	__weex_bootstrap__('@weex-component/9082fd8b30e33ba72afcea604ebcc52f',undefined,undefined)

/***/ },
/* 1 */
/***/ function(module, exports) {

	module.exports = {
	  "type": "div",
	  "classList": [
	    "global-div"
	  ],
	  "children": [
	    {
	      "type": "div",
	      "classList": [
	        "top-div"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "classList": [
	            "border-div"
	          ],
	          "children": [
	            {
	              "type": "image",
	              "classList": [
	                "top-img-logo"
	              ],
	              "attr": {
	                "src": "lock.png"
	              }
	            }
	          ]
	        }
	      ]
	    },
	    {
	      "type": "div",
	      "classList": [
	        "middle-row"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "classList": [
	            "middle-item_left"
	          ],
	          "events": {
	            "click": "unlock"
	          },
	          "children": [
	            {
	              "type": "image",
	              "classList": [
	                "middle-item-img"
	              ],
	              "attr": {
	                "src": "key.png"
	              }
	            },
	            {
	              "type": "text",
	              "classList": [
	                "middle-item-text"
	              ],
	              "attr": {
	                "value": "开锁"
	              }
	            }
	          ]
	        },
	        {
	          "type": "div",
	          "classList": [
	            "middle-item_right"
	          ],
	          "events": {
	            "click": "lock"
	          },
	          "children": [
	            {
	              "type": "image",
	              "classList": [
	                "middle-item-img"
	              ],
	              "attr": {
	                "src": "switchimg.png"
	              }
	            },
	            {
	              "type": "text",
	              "classList": [
	                "middle-item-text"
	              ],
	              "attr": {
	                "value": "关锁"
	              }
	            }
	          ]
	        }
	      ]
	    }
	  ]
	}

/***/ },
/* 2 */
/***/ function(module, exports) {

	module.exports = {
	  "top-div": {
	    "flex": 3,
	    "backgroundColor": "#3f51b5",
	    "alignItems": "center"
	  },
	  "top-img-logo": {
	    "width": 200,
	    "height": 200,
	    "backgroundColor": "#3f51b5"
	  },
	  "border-div": {
	    "marginTop": 120,
	    "width": 436,
	    "height": 436,
	    "alignItems": "center",
	    "justifyContent": "center",
	    "backgroundColor": "#3f51b5",
	    "borderRadius": 500,
	    "borderWidth": 3,
	    "borderColor": "#FFFFFF"
	  },
	  "img-logo": {
	    "width": 300,
	    "height": 300
	  },
	  "middle-row": {
	    "height": 300,
	    "flexDirection": "row",
	    "justifyContent": "center",
	    "alignItems": "center"
	  },
	  "middle-item_left": {
	    "flex": 1,
	    "marginLeft": 50,
	    "marginRight": 50,
	    "width": 130,
	    "height": 100,
	    "backgroundColor": "#FFFFFF",
	    "borderWidth": 1,
	    "justifyContent": "center",
	    "alignItems": "center",
	    "flexDirection": "row"
	  },
	  "middle-item_right": {
	    "flex": 1,
	    "marginLeft": 50,
	    "marginRight": 50,
	    "width": 130,
	    "height": 100,
	    "backgroundColor": "#FFFFFF",
	    "borderWidth": 1,
	    "justifyContent": "center",
	    "alignItems": "center",
	    "flexDirection": "row"
	  },
	  "middle-item-img": {
	    "height": 44,
	    "width": 44,
	    "marginRight": 50
	  },
	  "middle-item-text": {
	    "fontSize": 30
	  }
	}

/***/ },
/* 3 */
/***/ function(module, exports) {

	module.exports = function(module, exports, __weex_require__){'use strict';

	var modal = weex.requireModule('modal');
	var bleManager = __weex_require__('@weex-module/minewModule');

	module.exports = {

	    data: function () {return {
	        language: "zh",
	        languageObj: {},
	        languageJSON: {
	            en: {
	                Connected: "Device connected！",
	                ConnectFailed: "It's not a module device or connect failed.",
	                Disconnect: "Device disconnected！",
	                SendMsg: "Send Success",
	                SendError: "Send Error",
	                ReceiveMsg: "Receive:"
	            },
	            zh_CN: {
	                Connected: "设备已连接",
	                ConnectFailed: "这不是一个透传设备或者设备连接失败，请重试。",
	                Disconnected: "设备已经断开连接。",
	                SendSuc: "发送成功",
	                SendError: "发送失败",
	                ReceiveMsg: "接收信息:"
	            }
	        }
	    }},

	    created: function created() {
	        var self = this;

	        bleManager.getLanguage(function (lang) {

	            console.log("+++++++++", lang);
	            if (lang == "zh") {
	                self.languageObj = self.languageJSON.zh_CN;
	            } else {
	                self.languageObj = self.languageJSON.en;
	            }
	        });
	    },

	    methods: {
	        ready: function ready() {

	            var self = this;

	            bleManager.getLastIdentifer(function (info) {

	                bleManager.connect(info, function (handler) {

	                    if (handler.state === '1') self.showToast(self.languageObj.Connected);else if (handler.state === '0') {
	                        self.showAlert(self.languageObj.ConnectFailed, function () {
	                            bleManager.disconnect("fuck");
	                        });
	                    } else if (handler.state === '-1') {
	                        self.showAlert(self.languageObj.Disconnected, function () {
	                            bleManager.disconnect("fuck");
	                        });
	                    }
	                });

	                bleManager.dataReceive(function (data) {});
	            });
	        },

	        unlock: function unlock(button) {
	            console.log(button);
	            var self = this;
	            bleManager.sendData("00", "1", function (result) {
	                self.addMessage(result);
	                console.log("send+++++" + result);
	            });
	        },
	        lock: function lock(button) {
	            var self = this;
	            console.log(button);
	            bleManager.sendData("01", "1", function (result) {
	                self.addMessage(result);
	                console.log("send+++++" + result);
	            });
	        },

	        addMessage: function addMessage(type) {
	            var self = this;
	            if (type === '0') {
	                self.showToast(self.languageObj.SendError);
	            } else if (type === '1') {
	                self.showToast(self.languageObj.SendSuc);
	            }
	        },

	        showToast: function showToast(msg) {

	            modal.toast({
	                message: msg,
	                duration: 0.8
	            });
	        },

	        showAlert: function showAlert(msg, handler) {

	            modal.alert({
	                message: msg,
	                duration: 0.3
	            }, function (value) {
	                handler();
	            });
	        }

	    }
	};}
	/* generated by weex-loader */


/***/ }
/******/ ]);
