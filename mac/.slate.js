// Create Operations
var defaultWidth = 2560;
var defaultHeight = 1440;

var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});
var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});
var pushTop = slate.operation("push", {
  "direction" : "top",
  "style" : "bar-resize:screenSizeY/2"
});

var pushBottom = slate.operation("push", {
  "direction" : "bottom",
  "style" : "bar-resize:screenSizeY/2"
});

var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var pushTopRight = function(width, height) {
  width = width === null? width : defaultWidth/2;
  height = height === null? height : defaultHeight/2;

  slate.operation("corner", {
    "direction" : "top-right",
    "width" : width,
    "height" : height
  }).run();
};

var pushTopLeft = slate.operation("corner", {
  "direction" : "top-left",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});

var pushCenterRight = slate.operation("move", {
  "x" : "screenSizeX/2",
  "y" : "screenSizeY/3",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});

//var pushTopLeft = slate.operation("push", {
//  "direction" : "left",
//  "height" : "screenSizeX/2"
//});

var pushBottomRight = slate.operation("corner", {
  "direction" : "bottom-right",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});

var pushBottomLeft = slate.operation("corner", {
  "direction" : "bottom-left",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});

// Bind A Crazy Function to 1+ctrl
slate.bindAll({
  "d:alt": slate.op("chain", {
    "operations": [
      pushRight,
      pushCenterRight
    ]
  }),
  "a:alt": pushLeft,
  "w:alt": pushTop,
  "x:alt": pushBottom,
  "s:alt": fullscreen,
  "e:alt": pushTopRight,
  "q:alt": pushTopLeft,
  "c:alt": pushBottomRight,
  "z:alt": pushBottomLeft,
  "r:alt;shift;ctrl": slate.op('relaunch')
});
