// Generated by CoffeeScript 1.8.0
(function() {
  var WC, Wnd;

  WC = window.WC;

  Wnd = (function() {
    Wnd.prototype.resizeZone = 16;

    Wnd.prototype.moveZone = 36;

    Wnd.prototype.genId = function() {
      return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 5);
    };

    function Wnd(opt, el) {
      this.opt = opt;
      this.el = el;
      if (this.el) {
        this.$el = $(el);
      }
      this.id = this.$el.attr('id');
      this.parseCss(this.opt.style.val("#" + this.id));
      this.$body = this.$el.find('.window-body');
      this.events();
      window[this.id] = this;
      this;
    }

    Wnd.prototype.parseCss = function(str) {
      var place, size;
      if (!this.data) {
        this.data = {};
      }
      size = [0, 0];
      place = [0, 0];
      str.replace(/^\{/, '').replace(/\}$/, '').split(';').forEach((function(_this) {
        return function(value) {
          var name, val;
          value = value.split(':');
          name = $.trim(value[0]);
          val = $.trim(value[1]);
          if (name === 'width') {
            size[0] = parseInt(val);
          }
          if (name === 'height') {
            size[1] = parseInt(val);
          }
          if (name === 'left') {
            place[0] = parseInt(val);
          }
          if (name === 'top') {
            place[1] = parseInt(val);
          }
          if (name) {
            return _this.data[name] = val;
          }
        };
      })(this));
      this.data.size = size;
      this.data.place = place;
      return this;
    };

    Wnd.prototype.updateStyle = function() {
      var css, name;
      css = {};
      for (name in this.data) {
        switch (name) {
          case 'place':
            css.left = this.data.place[0] + 'px';
            css.top = this.data.place[1] + 'px';
            break;
          case 'size':
            css.width = this.data.size[0] + 'px';
            css.height = this.data.size[1] + 'px';
            break;
          default:
            css[name] = this.data[name];
        }
      }
      this.opt.style.val('#' + this.id, css);
      return this;
    };

    Wnd.prototype.val = function(name, val) {
      if (val) {
        this.data[name] = val;
        return this.updateStyle();
      } else {
        return this.data[name];
      }
    };

    Wnd.prototype.mouseMove = function(e) {
      var place;
      switch (this.state) {
        case 'bottomResize':
          this.val('size', [this.size[0], this.size[1] + (e.pageY - this.cursor[1])]);
          this.onResize();
          break;
        case 'rightResize':
          this.val('size', [this.size[0] + (e.pageX - this.cursor[0]), this.size[1]]);
          this.onResize();
          break;
        case 'leftResize':
          this.val('size', [this.size[0] - (e.pageX - this.cursor[0]), this.size[1]]);
          place = this.val('place');
          place[0] = e.pageX - this.offset[0];
          this.val('place', place);
          this.onResize();
          break;
        case 'move':
          this.val('place', [e.pageX - this.offset[0], e.pageY - this.offset[1]]);
      }
      return this;
    };

    Wnd.prototype.events = function() {
      var clean, self, state;
      self = this;
      state = this.state;
      clean = function(e) {
        $(window).off('mousemove');
        self.opt.style.enableSelection();
        self.state = false;
        self.$el.removeClass('windowMove');
        self.$body.show();
        return self.$el.css('z-index', self.z);
      };
      this.$el.on('mouseup', clean);
      this.$el.on('mousedown', (function(_this) {
        return function(e) {
          _this.opt.style.disableSelection();
          _this.$body.hide();
          _this.$el.addClass('windowMove');
          _this.z = _this.$el.css('z-index');
          _this.$el.css('z-index', 10000);
          _this.cursor = [e.pageX, e.pageY];
          _this.size = _this.data.size;
          _this.offset = [e.pageX - _this.el.offsetLeft, e.pageY - _this.el.offsetTop];
          $(window).on('mousemove', $.proxy(self.mouseMove, self));
          return _this.state = (e.offsetY < _this.moveZone ? 'move' : e.offsetX < _this.resizeZone ? 'leftResize' : self.data.size[0] - e.offsetX < _this.resizeZone ? 'rightResize' : self.data.size[1] - e.offsetY < _this.resizeZone ? 'bottomResize' : false);
        };
      })(this));
      return this;
    };

    Wnd.prototype.onResize = function() {};

    return Wnd;

  })();

  $(function() {
    WC.style.val({
      '.windowMove': '{border: 1px solid #bfbfbf; -webkit-box-shadow: 0 0 8px #bfbfbf; }'
    });
    $.fn.wnd = function(options) {
      options = options || {};
      return this.each(function(i, el) {
        options.style = WC.style;
        return new Wnd(options, el);
      });
    };
    $('#podbor').wnd();
    $('#curs').wnd();
    return $('#calc').wnd();
  });

}).call(this);

//# sourceMappingURL=wc-demo2.js.map
