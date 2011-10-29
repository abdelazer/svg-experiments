rows = []

bindData = (data) ->
  row = d3.select("#matrix").selectAll("g").data(data)

  row
    .transition()
    .duration(750)
    .attr("transform", (d, i) -> "translate(0, #{i * 50})")

  row.enter().append("svg:g")

  row.exit().remove()

  rect = row.selectAll("rect").data (d) -> d

  rect
    .attr("x", (d) -> d.x * 50)
    .attr("y", 0)
    .attr("width",  50)
    .attr("height", 50)
    .attr("fill", (d) -> d.fill)

  rect.enter().append("svg:rect")

  rect.exit().remove()

update = ->
  row = for i in [0..4]
    {
      x: Math.floor(Math.random() * 10),
      y: Math.floor(Math.random() * 10),
      fill: "rgb(#{Math.floor(Math.random() * 255)}, #{Math.floor(Math.random() * 255)}, #{Math.floor(Math.random() * 255)})"
    }

  rows.unshift(row)
  rows.pop() if rows.length > 10
  bindData(rows)

setInterval(update, 500)

update()
