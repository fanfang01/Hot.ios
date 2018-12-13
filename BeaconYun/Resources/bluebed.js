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

	__weex_define__('@weex-component/8db323bae9791d288a414b1ab474341d', [], function(__weex_require__, __weex_exports__, __weex_module__) {

	    __weex_script__(__weex_module__, __weex_exports__, __weex_require__)
	    if (__weex_exports__.__esModule && __weex_exports__.default) {
	      __weex_module__.exports = __weex_exports__.default
	    }

	    __weex_module__.exports.template = __weex_template__

	    __weex_module__.exports.style = __weex_style__

	})

	__weex_bootstrap__('@weex-component/8db323bae9791d288a414b1ab474341d',undefined,undefined)

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
	          "type": "image",
	          "classList": [
	            "top-img-logo"
	          ],
	          "attr": {
	            "src": "bed.png"
	          }
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
	                  }
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
	    "backgroundColor": "#262955",
	    "alignItems": "center",
	    "justifyContent": "center"
	  },
	  "top-img-logo": {
	    "width": 325,
	    "height": 325,
	    "backgroundColor": "#262955",
	    "borderRadius": 200,
	    "borderWidth": 3,
	    "borderColor": "#FFFFFF"
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
	    "width": 50,
	    "height": 50,
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

	module.exports = function(module, exports, __weex_require__){"use strict";

	var bleManager = __weex_require__('@weex-module/minewModule');

	function sendData(data, callback) {

	    bleManager.sendData(data, true, function (result) {
	        if (result === 0) {
	            callback(false);
	        } else {
	            callback(true);
	        }
	    });
	}

	module.exports = {

	    data: function () {return {

	        configCmd: [{
	            cmd: "0x11",
	            param: "0x00"
	        }, {
	            cmd: "0x11",
	            param: "0x01"
	        }, {
	            cmd: "0x12",
	            param: "0x00"
	        }, {
	            cmd: "0x12",
	            param: "0x01"
	        }, {
	            cmd: "0x13",
	            param: "0x00"
	        }, {
	            cmd: "0x13",
	            param: "0x01"
	        }],

	        powerCmd: {
	            cmd: "0x00"
	        },

	        list: [[{
	            identifer: 1,
	            text: "背部",
	            image: "up.png"
	        }, {
	            identifer: 2,
	            text: "腿部",
	            image: "up.png"
	        }, {
	            identifer: 3,
	            text: "背腿齐升",
	            image: "union_up.png"
	        }], [{
	            identifer: 4,
	            text: "背部",
	            image: "down.png"
	        }, {
	            identifer: 5,
	            text: "腿部",
	            image: "down.png"
	        }, {
	            identifer: 6,
	            text: "背腿齐降",
	            image: "union_down.png"
	        }]]
	    }},

	    methods: {
	        created: function created() {},

	        configButtonClick: function configButtonClick(button) {

	            var index = button.target.attr.index;
	            var cmd = this.configCmd[index - 1];

	            sendData(cmd, function (result) {

	                console.log("send result" + result);
	            });
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