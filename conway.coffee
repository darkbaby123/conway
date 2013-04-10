# Conway's Game of Life

class CanvasRenderer
  # number of rows and columns to populate
  gridSize: 50

  # size of the canvas
  canvasSize: 600

  # color to use for the lines on the grid
  lineColor: '#cdcdcd'

  # color to use for live cells on the grid
  liveColor: '#666'

  # color to use for dead cells on the grid
  deadColor: '#eee'

  constructor: (options = {}) ->
    for i in [0..@gridSize]
      for j in [0..@gridSize]
        @draw(col: i, row: j, live: false)

  # Draw a given cell
  draw: (cell) ->
    @context  ||= @createDrawingContext()
    @cellsize ||= @canvasSize/@gridSize
    coords = [cell.row * @cellsize, cell.col * @cellsize, @cellsize, @cellsize]
    @context.strokeStyle = @lineColor
    @context.strokeRect.apply @context, coords
    @context.fillStyle = if cell.live then @liveColor else @deadColor
    @context.fillRect.apply @context, coords

  # Create the canvas drawing context.
  createDrawingContext: ->
    canvas        = document.createElement 'canvas'
    canvas.width  = @canvasSize
    canvas.height = @canvasSize
    document.body.appendChild canvas
    canvas.getContext '2d'


window.conway = (options = {}) ->
  window.canvas = new CanvasRenderer(options)
