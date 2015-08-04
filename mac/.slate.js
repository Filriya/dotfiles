S.log('[SLATE] ----------- Start Loading Config -----------');

// Create Operations
var defaultWidth = 2560;
var defaultHeight = 1440;
var width = defaultWidth/2;
var height = defaultHeight/2;
//var win = S.window();
//var rect = win.size();
var sc = S.screen();
var rect = sc.rect();

var pushRight = [
  S.operation("move", {
    "x" : width,
    "y" : 0,
    "width" : width,
    "height" : "screenSizeY",
  }),
  S.operation("move", {
    "x" : width,
    "y" : height * 2/3,
    "width" : width,
    "height" : height
  })
];

var pushLeft = S.operation("move", {
  "x" : 0,
  "y" : 0,
  "width" : width,
  "height" : "screenSizeY"
});
var pushTop = S.operation("move", {
  "x" : 0,
  "y" : 0,
  "width" : "screenSizeX",
  "height" : height
});

var pushBottom = S.operation("push", {
  "direction" : "bottom",
  "style" : "bar-resize:screenSizeY/2"
});

var fullscreen = S.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var pushTopRight = S.operation("corner", {
  "direction" : "top-right",
  "width" : width,
  "height" : height
});

var pushTopLeft = S.operation("corner", {
  "direction" : "top-left",
  "width" : width,
  "height" : height
});


//var pushTopLeft = S.operation("push", {
//  "direction" : "left",
//  "height" : width
//});

var pushBottomRight = S.operation("corner", {
  "direction" : "bottom-right",
  "width" : width,
  "height" : height
});

var pushBottomLeft = S.operation("corner", {
  "direction" : "bottom-left",
  "width" : width,
  "height" : height
});

var focusUp = S.operation("focus", {
  "direction": "up"
});

var focusDown = S.operation("focus", {
  "direction": "down"
});

var focusLeft = S.operation("focus", {
  "direction": "left"
});

var focusRight = S.operation("focus", {
  "direction": "right"
});

S.bindAll({
  "d:alt": S.op("chain", {
    "operations": pushRight
  }),
  "a:alt": pushLeft,
  "w:alt": pushTop,
  "x:alt": pushBottom,
  "s:alt": fullscreen,
  "e:alt": pushTopRight,
  "q:alt": pushTopLeft,
  "c:alt": pushBottomRight,
  "z:alt": pushBottomLeft,
  "h:alt": focusLeft,
  "j:alt": focusDown,
  "k:alt": focusUp,
  "l:alt": focusRight,
  "r:alt;shift;ctrl": S.op('relaunch')
});

S.log('[SLATE] ----------- End Loading Config -----------');
