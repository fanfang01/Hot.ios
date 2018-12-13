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

	__weex_define__('@weex-component/99935c93eef5980950b3ee5d8edcd9f1', [], function(__weex_require__, __weex_exports__, __weex_module__) {

	    __weex_script__(__weex_module__, __weex_exports__, __weex_require__)
	    if (__weex_exports__.__esModule && __weex_exports__.default) {
	      __weex_module__.exports = __weex_exports__.default
	    }

	    __weex_module__.exports.template = __weex_template__

	    __weex_module__.exports.style = __weex_style__

	})

	__weex_bootstrap__('@weex-component/99935c93eef5980950b3ee5d8edcd9f1',undefined,undefined)

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
	            "top-img-logo"
	          ],
	          "children": [
	            {
	              "type": "image",
	              "classList": [
	                "top-img-logo-image"
	              ],
	              "attr": {
	                "src": "fan.png"
	              }
	            },
	            {
	              "type": "text",
	              "classList": [
	                "top-img-logo-text"
	              ],
	              "attr": {
	                "value": function () {return this.decountText}
	              }
	            }
	          ]
	        }
	      ]
	    },
	    {
	      "type": "div",
	      "classList": [
	        "middle-div"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "repeat": {
	            "expression": function () {return this.list},
	            "value": "row"
	          },
	          "classList": [
	            "middle-row"
	          ],
	          "attr": {
	            "index": function () {return 'row-' + (this.$index)}
	          },
	          "children": [
	            {
	              "type": "div",
	              "repeat": {
	                "expression": function () {return this.row},
	                "value": "obj"
	              },
	              "classList": [
	                "middle-item"
	              ],
	              "attr": {
	                "index": function () {return 'item-' + (this.$index)}
	              },
	              "events": {
	                "click": "configButtonClick"
	              },
	              "children": [
	                {
	                  "type": "image",
	                  "classList": [
	                    "middle-item-img"
	                  ],
	                  "events": {
	                    "click": "configButtonClick"
	                  },
	                  "attr": {
	                    "index": function () {return this.obj.identifer},
	                    "src": function () {return this.obj.image}
	                  },
	                  "id": function () {return this.obj.identifer}
	                },
	                {
	                  "type": "text",
	                  "classList": [
	                    "middle-item-text"
	                  ],
	                  "attr": {
	                    "index": function () {return this.obj.identifer},
	                    "value": function () {return this.obj.text}
	                  }
	                }
	              ]
	            }
	          ]
	        }
	      ]
	    },
	    {
	      "type": "div",
	      "classList": [
	        "bottom-div"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "classList": [
	            "bottom-image-div"
	          ],
	          "events": {
	            "click": "powerClick"
	          },
	          "children": [
	            {
	              "type": "image",
	              "classList": [
	                "bottom-image"
	              ],
	              "events": {
	                "click": "powerClick"
	              },
	              "attr": {
	                "src": "onoff.png"
	              }
	            }
	          ]
	        },
	        {
	          "type": "text",
	          "classList": [
	            "bottom-text"
	          ],
	          "events": {
	            "click": "powerClick"
	          },
	          "attr": {
	            "value": "开关"
	          }
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
	    "backgroundColor": "#22A9C2",
	    "alignItems": "center",
	    "justifyContent": "center"
	  },
	  "top-img-logo": {
	    "width": 325,
	    "height": 325,
	    "backgroundColor": "#22A9C2",
	    "borderRadius": 200,
	    "borderWidth": 3,
	    "borderColor": "#FFFFFF"
	  },
	  "top-img-logo-image": {
	    "marginTop": 87,
	    "marginLeft": 87,
	    "width": 150,
	    "height": 150,
	    "alignContent": "center"
	  },
	  "top-img-logo-text": {
	    "marginTop": 20,
	    "textAlign": "center",
	    "fontSize": 20,
	    "color": "#FFFFFF"
	  },
	  "middle-div": {
	    "backgroundColor": "#FF0000",
	    "flex": 2
	  },
	  "middle-row": {
	    "flexDirection": "row",
	    "flex": 1
	  },
	  "middle-item": {
	    "flex": 1,
	    "backgroundColor": "#FFFFFF",
	    "justifyContent": "center",
	    "alignItems": "center",
	    "borderWidth": 1,
	    "borderColor": "#cccccc"
	  },
	  "middle-item-img": {
	    "height": 70,
	    "width": 70
	  },
	  "middle-item-text": {
	    "textAlign": "center",
	    "color": "#767676",
	    "fontSize": 20
	  },
	  "bottom-div": {
	    "flex": 1,
	    "flexDirection": "column",
	    "alignItems": "center",
	    "justifyContent": "center",
	    "backgroundColor": "#FFFFFF",
	    "paddingTop": 50
	  },
	  "bottom-image-div": {
	    "width": 120,
	    "height": 120,
	    "borderRadius": 100,
	    "borderWidth": 2,
	    "borderColor": "#aaaaaa",
	    "alignItems": "center",
	    "justifyContent": "center"
	  },
	  "bottom-image": {
	    "width": 40,
	    "height": 40,
	    "paddingTop": 30
	  },
	  "bottom-text": {
	    "marginTop": 10,
	    "width": 200,
	    "flex": 1,
	    "color": "#767676",
	    "textAlign": "center",
	    "fontSize": 20
	  }
	}

/***/ },
/* 3 */
/***/ function(module, exports) {

	module.exports = function(module, exports, __weex_require__){'use strict';

	var bleManager = __weex_require__('@weex-module/minewModule');
	var modal = weex.requireModule("modal");

	function sendData(data, callback) {

	    bleManager.sendData(data, true, function (result) {
	        if (result === 0) {
	            callback(false);
	        } else {
	            callback(true);
	        }
	    });
	};

	module.exports = {

	    data: function () {return {

	        decountText: ' ',
	        currentDecount: 0,
	        currentLastTime: 0,
	        timer: null,

	        configCmd: [{
	            cmd: "11",
	            param: "00"
	        }, {
	            cmd: "12",
	            param: "00"
	        }, {
	            cmd: "13",
	            param: "00"
	        }, {
	            cmd: "11",
	            param: "01"
	        }, {
	            cmd: "12",
	            param: "01"
	        }, {
	            cmd: "13",
	            param: "01"
	        }],

	        languageObj: {},

	        powerCmd: {
	            cmd: "00"
	        },

	        list: [[{
	            identifer: 1,
	            text: "风速+",
	            image: "up.png"
	        }, {
	            identifer: 2,
	            text: "摇头设置",
	            image: "osc.png"
	        }, {
	            identifer: 3,
	            text: "定时设置",
	            image: "timer.png"
	        }], [{
	            identifer: 4,
	            text: "风速-",
	            image: "down.png"
	        }, {
	            identifer: 5,
	            text: "自动模式",
	            image: "auto.png"
	        }, {
	            identifer: 6,
	            text: "睡眠模式",
	            image: "sleep.png"
	        }]],

	        languageJSON: {
	            en: {
	                back: "Back",
	                leg: "Leg",
	                backLegUp: "UnionUp",
	                backLegDown: "UnionDown",

	                FailedToSend: "Failed to send",
	                Clear: "Clear",
	                TransmissionPeriod: "Transmission period",
	                Manual: "Manual",
	                Send: "Send",
	                Connected: "Device connected！",
	                ConnectFailed: "Connect failed, please try again.",
	                Disconnect: "Device disconnected！",
	                SendMsg: "Send:",
	                SendError: "Send Error:"
	            },
	            zh_CN: {
	                back: "背部",
	                leg: "腿部",
	                backLegUp: "背腿齐升",
	                backLegDown: "背腿齐降",

	                FailedToSend: "发送信息失败",
	                Clear: "清除数据",
	                TransmissionPeriod: "发送周期",
	                Manual: "手动",
	                Send: "发送",
	                Connected: "设备已连接",
	                ConnectFailed: "连接失败，请重试。",
	                Disconnected: "设备已经断开连接。",
	                SendMsg: "发送信息:",
	                SendError: "发送失败:"
	            }
	        }

	    }},

	    methods: {

	        ready: function ready() {

	            var self = this;

	            bleManager.getLanguage(function (lang) {

	                console.log("+++++++++", lang);
	                if (lang == "zh") {
	                    self.languageObj = self.languageJSON.zh_CN;
	                } else {
	                    self.languageObj = self.languageJSON.en;
	                }
	            });

	            bleManager.getLastIdentifer(function (info) {

	                bleManager.connect(info, function (handler) {

	                    if (handler.state === '1') {
	                        modal.toast({ message: self.languageObj.Connected, duration: 0.5 });
	                    } else if (handler.state === '0') {
	                        modal.alert({ message: self.languageObj.ConnectFailed, duration: 0.5 }, function () {
	                            bleManager.disconnect("fuck");
	                        });
	                    } else if (handler.state === '-1') {
	                        modal.alert({ message: self.languageObj.Disconnect, duration: 0.5 }, function () {
	                            bleManager.disconnect("fuck");
	                        });
	                    }
	                });

	                bleManager.dataReceive(function (data) {});
	            });
	        },

	        configButtonClick: function configButtonClick(button) {

	            var index = button.target.attr.index;
	            var c = this.configCmd[index - 1];

	            sendData(c.cmd + c.param, function (result) {

	                console.log("send result" + result);
	            });

	            if (index == 3) {

	                this.currentDecount++;
	                if (this.currentDecount > 4) this.currentDecount = 0;
	                var seconds = [0, 15, 30, 60, 120];

	                if (seconds == 0) {
	                    this.decountText = " ";
	                    self.resetTime();
	                    return;
	                }

	                this.setTimeConfigImg(true);
	                this.startCount(seconds[this.currentDecount] * 60);
	            }
	        },

	        startCount: function startCount(seconds) {
	            clearInterval(this.timer);
	            this.currentLastTime = seconds;

	            var self = this;
	            this.timer = setInterval(function () {

	                self.currentLastTime--;

	                if (self.currentLastTime < 0) {
	                    clearInterval(self.timer);
	                    self.decountText = " ";
	                    self.setTimeConfigImg(false);
	                    return;
	                }

	                var min = self.currentLastTime / 60;
	                var second = self.currentLastTime % 60;
	                self.decountText = "倒计时:\n" + parseInt(min) + ":" + second;
	                if (self.currentLastTime == 0) {
	                    clearInterval(self.timer);
	                    self.setTimeConfigImg(false);
	                }
	            }, 1000);
	        },

	        setTimeConfigImg: function setTimeConfigImg(selected) {
	            console.log("########" + this.$el('3'));
	            this.$el('3').attr.src = selected ? "timer_select.png" : "timer.png";
	        },

	        powerClick: function powerClick() {
	            sendData(this.powerCmd.cmd, function (result) {
	                console.log("data sent.");
	            });
	        }

	    }
	};}
	/* generated by weex-loader */


/***/ }
/******/ ]);