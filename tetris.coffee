DELAY = 1000

MATRIX_COLS = 10
MATRIX_ROWS = 10

CELL_WIDTH  = 50
CELL_HEIGHT = 50
CELL_MARGIN = 0

EASING_FUNCTION = "cubic-out"
DURATION = 500

rows = []

bindData = (data) ->
  row = d3
    .select("#matrix")
    .selectAll("g")
    .data(data, (d) -> d.id)

  row
    .enter()
    .insert("svg:g", "g")
    .attr("transform", "translate(0, -#{CELL_HEIGHT})")
    .attr("opacity", 1e-6)
    .transition()
    .duration(DURATION)
    .ease(EASING_FUNCTION)
    .attr("transform", "translate(0, 0)")
    .attr("opacity", 1)

  row
    .transition()
    .duration(DURATION)
    .ease(EASING_FUNCTION)
    .attr("transform", (d, i) -> "translate(0, #{i * CELL_HEIGHT})")
    .attr("opacity", 1)

  row
    .exit()
    .transition()
    .duration(DURATION)
    .ease(EASING_FUNCTION)
    .attr("transform", "translate(0, #{MATRIX_ROWS * CELL_HEIGHT})")
    .attr("opacity", 1e-6)
    .remove()

  rect = row
    .selectAll("rect")
    .data((d) -> d.cells)

  rect.enter().append("svg:rect")

  rect
    .attr("x", (d) -> d.x * CELL_WIDTH)
    .attr("y", 0)
    .attr("width",  CELL_WIDTH)
    .attr("height", CELL_HEIGHT)
    .attr("fill", (d) -> d.fill)

  rect.exit().remove()

addRow = ->
  cells = for i in [0..4]
    {
      x: Math.floor(Math.random() * MATRIX_COLS),
      y: Math.floor(Math.random() * MATRIX_ROWS),
      fill: "rgb(#{Math.floor(Math.random() * 255)}, #{Math.floor(Math.random() * 255)}, #{Math.floor(Math.random() * 255)})"
    }

  rows.unshift(id: uuid(), cells: cells)
  rows.pop() if rows.length > MATRIX_ROWS
  bindData(rows)

setInterval(addRow, DELAY)

addRow()
