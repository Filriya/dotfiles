S.log('[SLATE] ----------- Start Loading Config -----------');
var util = {
  //  eachAppWindow: function(f) {
  //    S.eachApp(function(app) {
  //      app.eachWindow(f);
  //    });
  //  },

  //  key: function(k, mod) {
  //    return k + ':alt' + (mod ? ',' + mod : '');
  //  },

  //  focusWindow: function(f) {
  //    var hit = false;
  //    S.eachApp(function(app) {
  //      if (hit) return;
  //      app.eachWindow(function(win) {
  //        if (hit) return;
  //        if (f(win)) {
  //          win.focus();
  //          hit = true;
  //        }
  //      });
  //    });
  //  },

  //nextScreen: function(screen) {
  //  return S.screenForRef(String( (screen.id()+1)%S.screenCount() ));
  //},

  getScreenRect: function(win) {
    var win = S.window();
    var sc = win.screen();
    return sc.rect();
  }
};
// Create Operations
var windowWidth = 2560/2;
var windowHeight = 1440/2;

//S.log('[SLATE] win.screen:' + sc.rect().width);
//S.log('[SLATE] rect.width:' + rect.width + ' rect.height:' + rect.height);

var pushRight = S.op("chain", {
  'operations': [
    function(win) {
      if (!win) return;
      var scRect = util.getScreenRect(win);
      var rect = {
        "x" : scRect.width - windowWidth,
        "y" : scRect.y,
        "width" : windowWidth,
        "height" : scRect.height,
      }
        win.doOperation('move', rect);
      },
      function(win) {
        if (!win) return;
        var scRect = util.getScreenRect(win);
        var rect = {
          "x" : scRect.width - windowWidth,
          "y" : (scRect.height - windowHeight) /2,
          "width" : windowWidth,
          "height" : windowHeight
        }
        win.doOperation('move', rect);
      }
    ]
  }
);

var pushLeft = function(win) {
  if (!win) return;

  var scRect = util.getScreenRect(win);

  var rect = {
    "x": scRect.x,
    "y": 0,
    "width": windowWidth,
    "height": scRect.height
  }
  win.doOperation('move', rect);
};

var fullscreen = S.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var pushTopRight = S.operation("corner", {
  "direction" : "top-right",
  "width" : windowWidth,
  "height" : windowHeight
});

var pushTopLeft = S.operation("corner", {
  "direction" : "top-left",
  "width" : windowWidth,
  "height" : windowHeight
});

var pushBottomRight = S.operation("corner", {
  "direction" : "bottom-right",
  "width" : windowWidth,
  "height" : windowHeight
});

var pushBottomLeft = S.operation("corner", {
  "direction" : "bottom-left",
  "width" : windowWidth,
  "height" : windowHeight
});

var nextWindow = function(win) {
}


S.bindAll({
  "d:alt": pushRight,
  "a:alt": pushLeft,
  //"w:alt": pushTop,
  //"x:alt": pushBottom,
  "s:alt": fullscreen,
  "e:alt": pushTopRight,
  "q:alt": pushTopLeft,
  "c:alt": pushBottomRight,
  "z:alt": pushBottomLeft,
  "r:alt,shift": S.op('relaunch')
});

S.log('[SLATE] ----------- End Loading Config -----------');
