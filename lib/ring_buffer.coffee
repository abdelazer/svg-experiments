window.RingBuffer =
  class RingBuffer
    constructor: (length) ->
      @buffer = new Array(length)
      @start = @end = @length = 0

    isEmpty: ->
      @length == 0

    isFull: ->
      @length == @buffer.length

    first: ->
      if !this.isEmpty() then @buffer[@start] else null

    last: ->
      if !this.isEmpty() then @buffer[@end] else null

    push: (object) ->
      this.shift() if this.isFull()
      @end = this._wrap(@end + 1) unless this.isEmpty()
      @length++
      @buffer[@end] = object
      this

    pop: ->
      return null if this.isEmpty()
      object = @buffer[@end]
      @length--
      @end = this._wrap(@end - 1) unless this.isEmpty()
      object

    unshift: (object) ->
      this.pop() if this.isFull()
      @start = this._wrap(@start - 1) unless this.isEmpty()
      @length++
      @buffer[@start] = object
      this

    shift: ->
      return null if this.isEmpty()
      object = @buffer[@start]
      @length--
      @start = this._wrap(@start + 1) unless this.isEmpty()
      object

    toArray: ->
      if this.isEmpty()
        []
      else if @start <= @end
        @buffer.slice(@start, @end + 1)
      else
        first  = @buffer.slice(@start, @buffer.length)
        second = @buffer.slice(0, @end + 1)
        first.concat(second)

    _wrap: (index) ->
      if index < 0
        @buffer.length + index
      else if index > @buffer.length - 1
        index - @buffer.length
      else
        index
