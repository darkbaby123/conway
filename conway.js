// Generated by CoffeeScript 1.4.0
(function() {
  var CanvasRenderer;

  CanvasRenderer = (function() {

    CanvasRenderer.prototype.gridSize = 50;

    CanvasRenderer.prototype.canvasSize = 600;

    CanvasRenderer.prototype.lineColor = '#cdcdcd';

    CanvasRenderer.prototype.liveColor = '#666';

    CanvasRenderer.prototype.deadColor = '#eee';

    function CanvasRenderer(options) {
      var i, j, _i, _j, _ref, _ref1;
      if (options == null) {
        options = {};
      }
      for (i = _i = 0, _ref = this.gridSize; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        for (j = _j = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
          this.draw({
            col: i,
            row: j,
            live: false
          });
        }
      }
    }

    CanvasRenderer.prototype.draw = function(cell) {
      var coords;
      this.context || (this.context = this.createDrawingContext());
      this.cellsize || (this.cellsize = this.canvasSize / this.gridSize);
      coords = [cell.row * this.cellsize, cell.col * this.cellsize, this.cellsize, this.cellsize];
      this.context.strokeStyle = this.lineColor;
      this.context.strokeRect.apply(this.context, coords);
      this.context.fillStyle = cell.live ? this.liveColor : this.deadColor;
      return this.context.fillRect.apply(this.context, coords);
    };

    CanvasRenderer.prototype.createDrawingContext = function() {
      var canvas;
      canvas = document.createElement('canvas');
      canvas.width = this.canvasSize;
      canvas.height = this.canvasSize;
      document.body.appendChild(canvas);
      return canvas.getContext('2d');
    };

    return CanvasRenderer;

  })();

  window.conway = function(options) {
    if (options == null) {
      options = {};
    }
    return window.canvas = new CanvasRenderer(options);
  };

}).call(this);