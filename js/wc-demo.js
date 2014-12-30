// Generated by CoffeeScript 1.8.0
(function() {
  $(function() {
    var wcResize;
    window.WC.style.val({
      ".wc-window": "{ position: absolute; # -khtml-border-radius: 6px; # border-radius: 6px; border: 2px outset #d0d0d0; padding: 16px; background-color: #eaeaea; }",
      ".wc-window .window-title": "{ background-color: #327cb0; color: white; padding: 8px; -khtml-border-radius: 6px; border-radius: 6px; margin-bottom: 16px; }",
      ".wc-window .window-title span": "{ background-color: #cd573a; padding: 4px 8px ; -khtml-border-radius: 8px; border-radius: 16px; font-size: 14px; float: right; margin-top: -4px; }",
      '.windowMove': '{ border: 2px outset #d0d0d0; -webkit-box-shadow: 0 0 8px #bfbfbf; }'
    });
    wcResize = function() {
      var Size, calc, curs, f, h, podbor, w;
      h = window.innerHeight - 64;
      w = window.innerWidth;
      f = 16;
      Size = (function() {
        Size.prototype.f = 16;

        Size.prototype.h = h;

        Size.prototype.w = window.innerWidth;

        function Size(data) {
          var _ref, _ref1, _ref2;
          this.data = data;
          if ((_ref = this.data) != null ? _ref.place : void 0) {
            this.Place = this.data.place;
          }
          if ((_ref1 = this.data) != null ? _ref1.size : void 0) {
            this.Size = this.data.size;
          }
          if ((_ref2 = this.data) != null ? _ref2.f : void 0) {
            this.f = this.data.f;
          }
          this;
        }

        Size.prototype.feed = function() {
          return [this.Place[0] + this.Size[0], this.Place[1] + this.Size[1]];
        };

        Size.prototype.place = function() {
          return [this.Place[0] + this.f, this.Place[1] + this.f];
        };

        Size.prototype.size = function() {
          return [this.Size[0] - (3 * this.f), this.Size[1] - (3 * this.f)];
        };

        return Size;

      })();
      if (w < 768) {
        podbor = new Size({
          place: [0, 0],
          size: [w - f, h * .8]
        });
        curs = new Size({
          place: [0, podbor.feed()[1]],
          size: [w - f, h * .8]
        });
        calc = new Size({
          place: [0, curs.feed()[1]],
          size: [w - f, h * .8]
        });
      } else if ((769 < w && w < 1024)) {
        podbor = new Size({
          place: [0, 0],
          size: [w * .5, h * .6]
        });
        curs = new Size({
          place: [w * .5, 0],
          size: [(w * .5) - f, h * .6]
        });
        calc = new Size({
          place: [0, podbor.feed()[1]],
          size: [w - f, (h * .4) - 2 * f]
        });
      } else {
        curs = new Size({
          place: [0, 0],
          size: [w * .7, h * .6]
        });
        podbor = new Size({
          place: [w * .7, 0],
          size: [(w * .3) - f, h * .6]
        });
        calc = new Size({
          place: [0, podbor.feed()[1]],
          size: [w - f, (h * .4) - 2 * f]
        });
      }
      return window.WC.style.val({
        '#podbor': "{ position: absolute; left:" + (podbor.place()[0]) + "px; top:" + (podbor.place()[1]) + "px; width:" + (podbor.size()[0]) + "px; height:" + (podbor.size()[1]) + "px;}",
        '#podbor iframe': "{ height:" + (podbor.size()[1] - 36 - 16) + "px;}",
        '#curs': "{ position: absolute; left:" + (curs.place()[0]) + "px; top:" + (curs.place()[1]) + "px; width:" + (curs.size()[0]) + "px; height:" + (curs.size()[1]) + "px;}",
        '#calc': "{ position: absolute; left:" + (calc.place()[0]) + "px; top:" + (calc.place()[1]) + "px; width:" + (calc.size()[0]) + "px; height:" + (calc.size()[1]) + "px;}"
      });
    };
    wcResize();
    return $(window).resize(function() {
      return setTimeout(wcResize, 400);
    });
  });

}).call(this);

//# sourceMappingURL=wc-demo.js.map
