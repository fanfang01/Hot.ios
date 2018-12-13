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

	__weex_define__('@weex-component/0fac78121cd50e8114456af0cff9e3ba', [], function(__weex_require__, __weex_exports__, __weex_module__) {

	    __weex_script__(__weex_module__, __weex_exports__, __weex_require__)
	    if (__weex_exports__.__esModule && __weex_exports__.default) {
	      __weex_module__.exports = __weex_exports__.default
	    }

	    __weex_module__.exports.template = __weex_template__

	    __weex_module__.exports.style = __weex_style__

	})

	__weex_bootstrap__('@weex-component/0fac78121cd50e8114456af0cff9e3ba',undefined,undefined)

/***/ },
/* 1 */
/***/ function(module, exports) {

	module.exports = {
	  "type": "div",
	  "id": "main",
	  "classList": [
	    "wrapper"
	  ],
	  "children": [
	    {
	      "type": "div",
	      "classList": [
	        "box",
	        "content"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "classList": [
	            "row",
	            "",
	            "row-height",
	            "absolute-top",
	            "row-border-bottom",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "div",
	              "classList": [
	                "col-2",
	                "center"
	              ],
	              "children": [
	                {
	                  "type": "text",
	                  "attr": {
	                    "value": function () {return this.languageObj.TransmittedData}
	                  }
	                }
	              ]
	            },
	            {
	              "type": "div",
	              "classList": [
	                "col-1",
	                "row"
	              ],
	              "children": [
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-2",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "text",
	                      "classList": [
	                        "text-right"
	                      ],
	                      "attr": {
	                        "value": function () {return this.languageObj.hex}
	                      }
	                    }
	                  ]
	                },
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-1_5",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "switch",
	                      "events": {
	                        "change": "HEX_show_on_off"
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
	            "row",
	            "absolute-center",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "list",
	              "children": [
	                {
	                  "type": "cell",
	                  "append": "tree",
	                  "classList": [
	                    "row"
	                  ],
	                  "repeat": {
	                    "expression": function () {return this.dataList},
	                    "value": "item"
	                  },
	                  "children": [
	                    {
	                      "type": "div",
	                      "classList": [
	                        "col-3",
	                        "content-center"
	                      ],
	                      "children": [
	                        {
	                          "type": "text",
	                          "shown": function () {return this.item.type=='sendSuccess'},
	                          "attr": {
	                            "value": function () {return this.item.time}
	                          }
	                        },
	                        {
	                          "type": "text",
	                          "style": {
	                            "color": "#FF0000"
	                          },
	                          "shown": function () {return this.item.type=='sendError'},
	                          "attr": {
	                            "value": function () {return this.item.time}
	                          }
	                        },
	                        {
	                          "type": "text",
	                          "style": {
	                            "color": "#0082fc"
	                          },
	                          "shown": function () {return this.item.type=='receiv'},
	                          "attr": {
	                            "value": function () {return this.item.time}
	                          }
	                        }
	                      ]
	                    },
	                    {
	                      "type": "div",
	                      "classList": [
	                        "col-7",
	                        "content-center"
	                      ],
	                      "children": [
	                        {
	                          "type": "text",
	                          "shown": function () {return this.item.type=='sendSuccess'},
	                          "attr": {
	                            "value": function () {return (this.languageObj.TX) + ' : ' + (this.hexShow?this.item.hexValue:this.item.value)}
	                          }
	                        },
	                        {
	                          "type": "text",
	                          "style": {
	                            "color": "#FF0000"
	                          },
	                          "shown": function () {return this.item.type=='sendError'},
	                          "attr": {
	                            "value": function () {return (this.languageObj.FailedToSend) + ' : ' + (this.hexShow?this.item.hexValue:this.item.value)}
	                          }
	                        },
	                        {
	                          "type": "text",
	                          "style": {
	                            "color": "#0082fc"
	                          },
	                          "shown": function () {return this.item.type=='receiv'},
	                          "attr": {
	                            "value": function () {return (this.languageObj.RX) + ' : ' + (this.hexShow?this.item.hexValue:this.item.value)}
	                          }
	                        }
	                      ]
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
	            "row",
	            "row-height",
	            "row-border-top",
	            "absolute-bottom",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "div",
	              "classList": [
	                "col-3",
	                "row"
	              ],
	              "children": [
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-2",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "text",
	                      "attr": {
	                        "value": function () {return (this.languageObj.tx) + ':' + (this.sendDatasNum)}
	                      }
	                    }
	                  ]
	                },
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-2",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "text",
	                      "attr": {
	                        "value": function () {return (this.languageObj.rx) + ':' + (this.receivDatasNum)}
	                      }
	                    }
	                  ]
	                },
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-1"
	                  ]
	                }
	              ]
	            },
	            {
	              "type": "div",
	              "classList": [
	                "col-1",
	                "center"
	              ],
	              "events": {
	                "click": "clearDataList"
	              },
	              "children": [
	                {
	                  "type": "text",
	                  "style": {
	                    "textAlign": "right"
	                  },
	                  "attr": {
	                    "value": function () {return this.languageObj.Clear}
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
	        "box",
	        "bottom"
	      ],
	      "children": [
	        {
	          "type": "div",
	          "classList": [
	            "row",
	            "",
	            "row-height",
	            "row-border-bottom",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "div",
	              "classList": [
	                "col-5",
	                "center"
	              ],
	              "children": [
	                {
	                  "type": "text",
	                  "attr": {
	                    "value": function () {return this.languageObj.TransmissionPeriod}
	                  }
	                }
	              ]
	            },
	            {
	              "type": "div",
	              "classList": [
	                "col-1",
	                "row"
	              ],
	              "events": {
	                "click": "openList"
	              },
	              "children": [
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-2",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "text",
	                      "classList": [
	                        "text-center"
	                      ],
	                      "attr": {
	                        "value": function () {return this.cellList.selected.title}
	                      }
	                    }
	                  ]
	                },
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-1_5",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "image",
	                      "style": {
	                        "width": 45,
	                        "height": 45
	                      },
	                      "shown": function () {return !this.cellList.opened},
	                      "attr": {
	                        "src": "http://sacreleefile.qiniudn.com/right.png"
	                      }
	                    },
	                    {
	                      "type": "image",
	                      "style": {
	                        "width": 45,
	                        "height": 45
	                      },
	                      "shown": function () {return this.cellList.opened},
	                      "attr": {
	                        "src": "http://sacreleefile.qiniudn.com/bottom.png"
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
	            "list"
	          ],
	          "shown": function () {return this.cellList.opened},
	          "children": [
	            {
	              "type": "list",
	              "children": [
	                {
	                  "type": "cell",
	                  "append": "tree",
	                  "repeat": {
	                    "expression": function () {return this.cellList.items},
	                    "value": "item"
	                  },
	                  "children": [
	                    {
	                      "type": "div",
	                      "classList": [
	                        "cell-text"
	                      ],
	                      "events": {
	                        "click": "selectCell"
	                      },
	                      "attr": {
	                        "value": function () {return this.$index}
	                      },
	                      "children": [
	                        {
	                          "type": "text",
	                          "style": {
	                            "textAlign": "left"
	                          },
	                          "attr": {
	                            "value": function () {return this.item.title}
	                          }
	                        }
	                      ]
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
	            "row",
	            "",
	            "row-height",
	            "row-border-bottom",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "div",
	              "classList": [
	                "col-2",
	                "center"
	              ],
	              "children": [
	                {
	                  "type": "text",
	                  "attr": {
	                    "value": function () {return (this.languageObj.hex1) + (this.languageObj.Send)}
	                  }
	                }
	              ]
	            },
	            {
	              "type": "div",
	              "classList": [
	                "col-1",
	                "row"
	              ],
	              "children": [
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-2",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "text",
	                      "classList": [
	                        "text-right"
	                      ]
	                    }
	                  ]
	                },
	                {
	                  "type": "div",
	                  "classList": [
	                    "col-1_5",
	                    "center"
	                  ],
	                  "children": [
	                    {
	                      "type": "switch",
	                      "events": {
	                        "change": "HEX_switch_on_off"
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
	            "row",
	            "textarea-height",
	            "margin-left-right"
	          ],
	          "children": [
	            {
	              "type": "div",
	              "classList": [
	                "col-5",
	                "center"
	              ],
	              "children": [
	                {
	                  "type": "textarea",
	                  "id": "textareaId",
	                  "classList": [
	                    "textarea"
	                  ],
	                  "attr": {
	                    "type": "text",
	                    "placeholder": "Input Something",
	                    "value": ""
	                  },
	                  "events": {
	                    "change": "onchange",
	                    "input": "oninput"
	                  }
	                }
	              ]
	            },
	            {
	              "type": "div",
	              "classList": [
	                "col-1",
	                "center"
	              ],
	              "children": [
	                {
	                  "type": "div",
	                  "classList": [
	                    "btn",
	                    "center"
	                  ],
	                  "events": {
	                    "click": "pushButtonClick"
	                  },
	                  "children": [
	                    {
	                      "type": "text",
	                      "style": {
	                        "textAlign": "center"
	                      },
	                      "attr": {
	                        "value": function () {return this.languageObj.Send}
	                      }
	                    }
	                  ]
	                }
	              ]
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
	  "wrapper": {
	    "position": "absolute",
	    "top": 0,
	    "right": 0,
	    "bottom": 0,
	    "left": 0,
	    "backgroundColor": "#cccccc"
	  },
	  "box": {
	    "position": "absolute"
	  },
	  "content": {
	    "bottom": 360,
	    "top": 0,
	    "left": 0,
	    "right": 0,
	    "backgroundColor": "#FFFFFF"
	  },
	  "bottom": {
	    "bottom": 0,
	    "left": 0,
	    "right": 0,
	    "height": 340,
	    "backgroundColor": "#FFFFFF"
	  },
	  "text-center": {
	    "textAlign": "center"
	  },
	  "text-right": {
	    "textAlign": "right"
	  },
	  "row-height": {
	    "height": 80
	  },
	  "row-border-top": {
	    "borderTopStyle": "\"solid\"",
	    "borderTopWidth": 1,
	    "borderTopColor": "#000000"
	  },
	  "row-border-bottom": {
	    "borderBottomStyle": "'solid'",
	    "borderBottomWidth": 1,
	    "borderBottomColor": "#000000"
	  },
	  "absolute-bottom": {
	    "position": "absolute",
	    "right": 0,
	    "bottom": 0,
	    "left": 0
	  },
	  "absolute-top": {
	    "position": "absolute",
	    "right": 0,
	    "top": 0,
	    "left": 0
	  },
	  "absolute-center": {
	    "position": "absolute",
	    "right": 0,
	    "top": 80,
	    "bottom": 80,
	    "left": 0
	  },
	  "textarea-height": {
	    "height": 180
	  },
	  "margin-left-right": {
	    "marginLeft": 15,
	    "marginRight": 15
	  },
	  "row": {
	    "flexDirection": "row"
	  },
	  "column": {
	    "flexDirection": "column"
	  },
	  "center": {
	    "justifyContent": "center"
	  },
	  "flex-end": {
	    "justifyContent": "flex-end"
	  },
	  "col-1_5": {
	    "flex": 1.5
	  },
	  "col-1": {
	    "flex": 1
	  },
	  "col-2": {
	    "flex": 2
	  },
	  "col-3": {
	    "flex": 3
	  },
	  "col-4": {
	    "flex": 4
	  },
	  "col-5": {
	    "flex": 5
	  },
	  "col-6": {
	    "flex": 6
	  },
	  "col-7": {
	    "flex": 7
	  },
	  "col-8": {
	    "flex": 8
	  },
	  "btn": {
	    "margin": 5,
	    "borderWidth": 1,
	    "borderStyle": "solid",
	    "borderColor": "#efefef",
	    "borderRadius": 15,
	    "height": 140
	  },
	  "textarea": {
	    "borderWidth": 1,
	    "borderStyle": "solid",
	    "borderColor": "#efefef",
	    "borderRadius": 15,
	    "height": 140
	  },
	  "cell-list": {
	    "backgroundColor": "#FFFFFF"
	  },
	  "title": {
	    "height": 80,
	    "flexDirection": "row",
	    "borderWidth": 1,
	    "borderColor": "#000000",
	    "paddingLeft": 15,
	    "paddingRight": 15
	  },
	  "title-text": {
	    "flex": 10,
	    "justifyContent": "center"
	  },
	  "title-icon": {
	    "flex": 2,
	    "justifyContent": "center",
	    "flexDirection": "row"
	  },
	  "title-icon-text": {
	    "flex": 2,
	    "justifyContent": "center"
	  },
	  "title-icon-img": {
	    "flex": 1,
	    "justifyContent": "center"
	  },
	  "list": {
	    "height": 250,
	    "borderWidth": 1,
	    "borderColor": "#000000",
	    "backgroundColor": "#F5F5F5"
	  },
	  "cell-text": {
	    "height": 80,
	    "borderBottomStyle": "'solid'",
	    "borderBottomWidth": 1,
	    "borderBottomColor": "#000000",
	    "paddingLeft": 15,
	    "paddingRight": 15,
	    "paddingTop": 20,
	    "paddingBottom": 20,
	    "backgroundColor": "#F5F5F5"
	  }
	}

/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = function(module, exports, __weex_require__){'use strict';

	var _defineProperty2 = __webpack_require__(4);

	var _defineProperty3 = _interopRequireDefault(_defineProperty2);

	var _zh_CN, _methods;

	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

	var modal = weex.requireModule('modal');
	var bleManager = __weex_require__('@weex-module/minewModule');
	var deviceIdentifer;
	var senddingString;
	var messages = [];

	function strToHexCharCode(str) {
	    if (str === "") return "";
	    var hexCharCode = [];
	    hexCharCode.push("0x");
	    for (var i = 0; i < str.length; i++) {
	        hexCharCode.push(str.charCodeAt(i).toString(16));
	    }
	    return hexCharCode.join("");
	}

	function hexCharCodeToStr(hexCharCodeStr) {
	    var trimedStr = hexCharCodeStr.trim();
	    var rawStr = trimedStr.substr(0, 2).toLowerCase() === "0x" ? trimedStr.substr(2) : trimedStr;
	    var len = rawStr.length;
	    if (len % 2 !== 0) {
	        return "";
	    }
	    var curCharCode;
	    var resultStr = [];
	    for (var i = 0; i < len; i = i + 2) {
	        curCharCode = parseInt(rawStr.substr(i, 2), 16);
	        resultStr.push(String.fromCharCode(curCharCode));
	    }
	    return resultStr.join("");
	}

	function checkHex(hexValue) {
	    hexValue = hexValue.substring(2, hexValue.length);
	    var isHex = true;
	    for (var i = 0; i < hexValue.length; i++) {
	        try {
	            var c = hexValue.substring(i, i + 1);
	            var n = parseInt("0x" + c);
	            if (!n) {
	                isHex = false;
	                break;
	            }
	        } catch (e) {
	            isHex = false;
	            break;
	        }
	    }
	    return isHex;
	}

	module.exports = {
	    data: function () {return {
	        language: "zh",
	        languageObj: {},
	        txtInput: '',
	        txtChange: '',
	        hexShow: false,
	        hexSend: false,
	        cellList: {
	            opened: false,
	            title: "发送周期",
	            items: [{
	                id: 1,
	                type: 0,
	                title: "手动",
	                icon: "icon"
	            }, {
	                id: 2,
	                type: 1,
	                title: "1s",
	                value: 1,
	                icon: "icon"
	            }, {
	                id: 3,
	                type: 1,
	                title: "5s",
	                value: 5,
	                icon: "icon"
	            }, {
	                id: 4,
	                type: 1,
	                title: "10s",
	                value: 10,
	                icon: "icon"
	            }],
	            selected: {
	                id: 1,
	                type: 0,
	                title: "手动",
	                icon: "icon"
	            }
	        },
	        deviceData: {
	            mac: "AA:BB:CC:DD:EE:F4",
	            rssi: "-40bBm",
	            model: "ABC"
	        },
	        dataList: [],
	        sendDatasNum: 0,
	        receivDatasNum: 0,
	        languageJSON: {
	            en: {
	                TransmittedData: "Transmitted data",
	                hex: "HEX",
	                hex1: "HEX",
	                TX: "TX",
	                RX: "RX",
	                tx: "TX",
	                rx: "RX",
	                Model: "Model",
	                MAC: "MAC",
	                RSSI: "RSSI",
	                ConnectedTo: "Connected to",
	                FailedToSend: "Failed to send",
	                Disconnected: "Disconnected",
	                Clear: "Clear",
	                TransmissionPeriod: "Transmission period",
	                Manual: "Manual",
	                Send: "Send",
	                Connected: "Device connected！",
	                ConnectFailed: "It's not a module device or connect failed.",
	                Disconnect: "Device disconnected！",
	                SendMsg: "Send:",
	                SendError: "Send Error:",
	                ReceiveMsg: "Receive:",
	                ErrorHex: "Error hex value!"
	            },
	            zh_CN: (_zh_CN = {
	                TransmittedData: "透传数据",
	                hex: "HEX显示",
	                hex1: "HEX",
	                TX: "发送信息",
	                RX: "收到信息",
	                tx: "发送",
	                rx: "收到",
	                Model: "蓝牙模块",
	                MAC: "MAC",
	                RSSI: "RSSI",
	                ConnectedTo: "连接到",
	                FailedToSend: "发送信息失败",
	                Disconnected: "Disconnected",
	                Clear: "清除数据",
	                TransmissionPeriod: "发送周期",
	                Manual: "手动",
	                Send: "发送",
	                Connected: "设备已连接",
	                ConnectFailed: "这不是一个透传设备或者设备连接失败，请重试。"
	            }, (0, _defineProperty3.default)(_zh_CN, 'Disconnected', "设备已经断开连接。"), (0, _defineProperty3.default)(_zh_CN, 'SendMsg', "发送信息:"), (0, _defineProperty3.default)(_zh_CN, 'SendError', "发送失败:"), (0, _defineProperty3.default)(_zh_CN, 'ReceiveMsg', "接收信息:"), (0, _defineProperty3.default)(_zh_CN, 'ErrorHex', "错误的十六进制数据！"), _zh_CN)
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
	                self.cellList.items[0].title = self.languageObj.Manual;
	                self.cellList.selected.title = self.languageObj.Manual;
	            }
	        });
	    },

	    methods: (_methods = {

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

	                deviceIdentifer = info;

	                bleManager.dataReceive(function (data) {
	                    self.addMessage(data, '2');
	                });
	            });
	        },

	        oninput: function oninput(event) {
	            this.txtInput = event.value;
	        },
	        HEX_show_on_off: function HEX_show_on_off() {
	            this.hexShow = !this.hexShow;
	        },
	        HEX_switch_on_off: function HEX_switch_on_off() {
	            this.hexSend = !this.hexSend;
	            this.stopSenddingCycle();
	            this.cellList.selected = this.cellList.items[parseInt(0)];
	        },
	        selectCell: function selectCell(e) {
	            var index = e.target.attr.value;
	            this.cellList.selected = this.cellList.items[parseInt(index)];
	            this.cellList.opened = false;

	            if (index > 0) this.startSenddingCycle(index);else this.stopSenddingCycle();
	        },
	        openList: function openList() {
	            this.cellList.opened = !this.cellList.opened;
	        },
	        clearDataList: function clearDataList() {
	            this.dataList = [];
	            this.sendDatasNum = 0;
	            this.receivDatasNum = 0;
	        },
	        receivData: function receivData() {
	            this.receivDatasNum = this.receivDatasNum + 1;
	        },
	        sendData: function sendData(event) {},

	        pushButtonClick: function pushButtonClick() {
	            this.stopSenddingCycle();
	            this.sendData();
	            this.cellList.selected = this.cellList.items[parseInt(0)];
	        },

	        startSenddingCycle: function startSenddingCycle(type) {

	            var time;

	            if (type == 1) time = '1';else if (type === 2) time = '5';else if (type === 3) time = '10';

	            var self = this;
	            bleManager.sendCycleData(this.txtInput, this.hexSend, time, function (result) {
	                self.addMessage(self.txtInput, result, self.hexSend);
	            });
	        },

	        stopSenddingCycle: function stopSenddingCycle() {
	            bleManager.stopCycleTimer();
	        }

	    }, (0, _defineProperty3.default)(_methods, 'sendData', function sendData(event) {

	        var self = this;

	        bleManager.sendData(this.txtInput, this.hexSend, function (result) {
	            self.addMessage(self.txtInput, result, self.hexSend);
	            console.log("send+++++" + result);
	        });

	        console.log(this.cellList.selected);

	        if (this.hexSend) {}
	    }), (0, _defineProperty3.default)(_methods, 'addMessage', function addMessage(message, type, isHex) {

	        var msgType = isHex ? 1 : 0;
	        var desc;
	        var colorType;
	        var sourceData;
	        var hexData;

	        if (type === '0') {
	            this.sendDatasNum = this.sendDatasNum + 1;
	            desc = this.languageObj.SendError;
	            colorType = "sendError";
	            sourceData = isHex ? "0x" + message : message;
	            hexData = isHex ? "0x" + message : strToHexCharCode(message);
	        } else if (type === '1') {
	            this.sendDatasNum = this.sendDatasNum + 1;
	            desc = this.languageObj.SendMsg;
	            colorType = "sendSuccess";
	            sourceData = isHex ? "0x" + message : message;
	            hexData = isHex ? "0x" + message : strToHexCharCode(message);
	        } else {
	            this.receivDatasNum = this.receivDatasNum + 1;
	            desc = this.languageObj.ReceiveMsg;
	            colorType = "receiv";
	            sourceData = hexCharCodeToStr(message);
	            hexData = "0x" + message;
	        }

	        var date = new Date();
	        var now = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "." + date.getMilliseconds();

	        this.dataList.unshift({
	            time: now,
	            desc: desc,
	            value: sourceData,
	            hexValue: hexData,
	            type: colorType
	        });
	    }), (0, _defineProperty3.default)(_methods, 'showToast', function showToast(msg) {

	        modal.toast({
	            message: msg,
	            duration: 0.8
	        });
	    }), (0, _defineProperty3.default)(_methods, 'showAlert', function showAlert(msg, handler) {

	        modal.alert({
	            message: msg,
	            duration: 0.3
	        }, function (value) {
	            handler();
	        });
	    }), _methods)
	};}
	/* generated by weex-loader */


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	exports.__esModule = true;

	var _defineProperty = __webpack_require__(5);

	var _defineProperty2 = _interopRequireDefault(_defineProperty);

	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

	exports.default = function (obj, key, value) {
	  if (key in obj) {
	    (0, _defineProperty2.default)(obj, key, {
	      value: value,
	      enumerable: true,
	      configurable: true,
	      writable: true
	    });
	  } else {
	    obj[key] = value;
	  }

	  return obj;
	};

/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = { "default": __webpack_require__(6), __esModule: true };

/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(7);
	var $Object = __webpack_require__(10).Object;
	module.exports = function defineProperty(it, key, desc){
	  return $Object.defineProperty(it, key, desc);
	};

/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	var $export = __webpack_require__(8);
	// 19.1.2.4 / 15.2.3.6 Object.defineProperty(O, P, Attributes)
	$export($export.S + $export.F * !__webpack_require__(18), 'Object', {defineProperty: __webpack_require__(14).f});

/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	var global    = __webpack_require__(9)
	  , core      = __webpack_require__(10)
	  , ctx       = __webpack_require__(11)
	  , hide      = __webpack_require__(13)
	  , PROTOTYPE = 'prototype';

	var $export = function(type, name, source){
	  var IS_FORCED = type & $export.F
	    , IS_GLOBAL = type & $export.G
	    , IS_STATIC = type & $export.S
	    , IS_PROTO  = type & $export.P
	    , IS_BIND   = type & $export.B
	    , IS_WRAP   = type & $export.W
	    , exports   = IS_GLOBAL ? core : core[name] || (core[name] = {})
	    , expProto  = exports[PROTOTYPE]
	    , target    = IS_GLOBAL ? global : IS_STATIC ? global[name] : (global[name] || {})[PROTOTYPE]
	    , key, own, out;
	  if(IS_GLOBAL)source = name;
	  for(key in source){
	    // contains in native
	    own = !IS_FORCED && target && target[key] !== undefined;
	    if(own && key in exports)continue;
	    // export native or passed
	    out = own ? target[key] : source[key];
	    // prevent global pollution for namespaces
	    exports[key] = IS_GLOBAL && typeof target[key] != 'function' ? source[key]
	    // bind timers to global for call from export context
	    : IS_BIND && own ? ctx(out, global)
	    // wrap global constructors for prevent change them in library
	    : IS_WRAP && target[key] == out ? (function(C){
	      var F = function(a, b, c){
	        if(this instanceof C){
	          switch(arguments.length){
	            case 0: return new C;
	            case 1: return new C(a);
	            case 2: return new C(a, b);
	          } return new C(a, b, c);
	        } return C.apply(this, arguments);
	      };
	      F[PROTOTYPE] = C[PROTOTYPE];
	      return F;
	    // make static versions for prototype methods
	    })(out) : IS_PROTO && typeof out == 'function' ? ctx(Function.call, out) : out;
	    // export proto methods to core.%CONSTRUCTOR%.methods.%NAME%
	    if(IS_PROTO){
	      (exports.virtual || (exports.virtual = {}))[key] = out;
	      // export proto methods to core.%CONSTRUCTOR%.prototype.%NAME%
	      if(type & $export.R && expProto && !expProto[key])hide(expProto, key, out);
	    }
	  }
	};
	// type bitmap
	$export.F = 1;   // forced
	$export.G = 2;   // global
	$export.S = 4;   // static
	$export.P = 8;   // proto
	$export.B = 16;  // bind
	$export.W = 32;  // wrap
	$export.U = 64;  // safe
	$export.R = 128; // real proto method for `library` 
	module.exports = $export;

/***/ },
/* 9 */
/***/ function(module, exports) {

	// https://github.com/zloirock/core-js/issues/86#issuecomment-115759028
	var global = module.exports = typeof window != 'undefined' && window.Math == Math
	  ? window : typeof self != 'undefined' && self.Math == Math ? self : Function('return this')();
	if(typeof __g == 'number')__g = global; // eslint-disable-line no-undef

/***/ },
/* 10 */
/***/ function(module, exports) {

	var core = module.exports = {version: '2.4.0'};
	if(typeof __e == 'number')__e = core; // eslint-disable-line no-undef

/***/ },
/* 11 */
/***/ function(module, exports, __webpack_require__) {

	// optional / simple context binding
	var aFunction = __webpack_require__(12);
	module.exports = function(fn, that, length){
	  aFunction(fn);
	  if(that === undefined)return fn;
	  switch(length){
	    case 1: return function(a){
	      return fn.call(that, a);
	    };
	    case 2: return function(a, b){
	      return fn.call(that, a, b);
	    };
	    case 3: return function(a, b, c){
	      return fn.call(that, a, b, c);
	    };
	  }
	  return function(/* ...args */){
	    return fn.apply(that, arguments);
	  };
	};

/***/ },
/* 12 */
/***/ function(module, exports) {

	module.exports = function(it){
	  if(typeof it != 'function')throw TypeError(it + ' is not a function!');
	  return it;
	};

/***/ },
/* 13 */
/***/ function(module, exports, __webpack_require__) {

	var dP         = __webpack_require__(14)
	  , createDesc = __webpack_require__(22);
	module.exports = __webpack_require__(18) ? function(object, key, value){
	  return dP.f(object, key, createDesc(1, value));
	} : function(object, key, value){
	  object[key] = value;
	  return object;
	};

/***/ },
/* 14 */
/***/ function(module, exports, __webpack_require__) {

	var anObject       = __webpack_require__(15)
	  , IE8_DOM_DEFINE = __webpack_require__(17)
	  , toPrimitive    = __webpack_require__(21)
	  , dP             = Object.defineProperty;

	exports.f = __webpack_require__(18) ? Object.defineProperty : function defineProperty(O, P, Attributes){
	  anObject(O);
	  P = toPrimitive(P, true);
	  anObject(Attributes);
	  if(IE8_DOM_DEFINE)try {
	    return dP(O, P, Attributes);
	  } catch(e){ /* empty */ }
	  if('get' in Attributes || 'set' in Attributes)throw TypeError('Accessors not supported!');
	  if('value' in Attributes)O[P] = Attributes.value;
	  return O;
	};

/***/ },
/* 15 */
/***/ function(module, exports, __webpack_require__) {

	var isObject = __webpack_require__(16);
	module.exports = function(it){
	  if(!isObject(it))throw TypeError(it + ' is not an object!');
	  return it;
	};

/***/ },
/* 16 */
/***/ function(module, exports) {

	module.exports = function(it){
	  return typeof it === 'object' ? it !== null : typeof it === 'function';
	};

/***/ },
/* 17 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = !__webpack_require__(18) && !__webpack_require__(19)(function(){
	  return Object.defineProperty(__webpack_require__(20)('div'), 'a', {get: function(){ return 7; }}).a != 7;
	});

/***/ },
/* 18 */
/***/ function(module, exports, __webpack_require__) {

	// Thank's IE8 for his funny defineProperty
	module.exports = !__webpack_require__(19)(function(){
	  return Object.defineProperty({}, 'a', {get: function(){ return 7; }}).a != 7;
	});

/***/ },
/* 19 */
/***/ function(module, exports) {

	module.exports = function(exec){
	  try {
	    return !!exec();
	  } catch(e){
	    return true;
	  }
	};

/***/ },
/* 20 */
/***/ function(module, exports, __webpack_require__) {

	var isObject = __webpack_require__(16)
	  , document = __webpack_require__(9).document
	  // in old IE typeof document.createElement is 'object'
	  , is = isObject(document) && isObject(document.createElement);
	module.exports = function(it){
	  return is ? document.createElement(it) : {};
	};

/***/ },
/* 21 */
/***/ function(module, exports, __webpack_require__) {

	// 7.1.1 ToPrimitive(input [, PreferredType])
	var isObject = __webpack_require__(16);
	// instead of the ES6 spec version, we didn't implement @@toPrimitive case
	// and the second argument - flag - preferred type is a string
	module.exports = function(it, S){
	  if(!isObject(it))return it;
	  var fn, val;
	  if(S && typeof (fn = it.toString) == 'function' && !isObject(val = fn.call(it)))return val;
	  if(typeof (fn = it.valueOf) == 'function' && !isObject(val = fn.call(it)))return val;
	  if(!S && typeof (fn = it.toString) == 'function' && !isObject(val = fn.call(it)))return val;
	  throw TypeError("Can't convert object to primitive value");
	};

/***/ },
/* 22 */
/***/ function(module, exports) {

	module.exports = function(bitmap, value){
	  return {
	    enumerable  : !(bitmap & 1),
	    configurable: !(bitmap & 2),
	    writable    : !(bitmap & 4),
	    value       : value
	  };
	};

/***/ }
/******/ ]);