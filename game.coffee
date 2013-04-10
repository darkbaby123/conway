# 说明：
#
# 页面加载后会生成board对象，在控制台中可以直接使用
#
# 运行 board.step() 改变画布一次
# 运行 board.run() 循环改变画布，时间间隔一秒
# 运行 board.stop() 停止循环改变
#
# PS: 浏览器中可以打开source maps～

class Board
  constructor: (rows, cols) ->
    @rows   = rows
    @cols   = cols
    @points = []

    for x in [0..@rows]
      @points[x] = []
      for y in [0..@cols]
        @points[x][y] = new Point(x, y, Math.random() > 0.5, @)

  render: ->
    for rows in @points
      for point in rows
        point.render()
    null

  step: ->
    for rows in @points
      for point in rows
        neighbours = point.neighbours()
        liveCount  = (n for n in neighbours when n.live).length

        # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        # Any live cell with two or three live neighbours lives on to the next generation.
        # Any live cell with more than three live neighbours dies, as if by overcrowding.
        # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        switch
          when point.live and liveCount < 2
            # 这里可以把when语句合并成两个，不过为了可读性还是分开好点
            point.live = false
          when point.live and 2 <= liveCount <= 3
            point.live = true
          when point.live and liveCount > 3
            point.live = false
          when not point.live and liveCount == 3
            point.live = true

    @render()

  run: ->
    @intervalId = setInterval (=> @step()), 1000

  stop: ->
    clearInterval @intervalId


class Point
  constructor: (x, y, live, board) ->
    @x     = x
    @y     = y
    @live  = live
    @board = board  # 引用board，一是为了获得画布边界，而是为了获得points集合

  render: ->
    canvas.draw(col: @x, row: @y, live: @live)

  neighbours: ->
    minX = if @x == 0 then 0 else @x - 1
    maxX = if @x == @board.rows then @board.rows else @x + 1
    minY = if @y == 0 then 0 else @y - 1
    maxY = if @y == @board.cols then @board.cols else @y + 1

    points = []
    for x in [minX..maxX]
      for y in [minY..maxY]
        continue if @x == x and @y == y
        points.push(@board.points[x][y])
    points


window.game = ->
  window.board = new Board(50, 50)
  board.render()
