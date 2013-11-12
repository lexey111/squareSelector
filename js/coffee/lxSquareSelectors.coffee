###
    Class for visual dropdown (selectors replacement)

    Requires: jQuery 1.2+
###

class LxSquareSelector
  ###
      Service function that makes unque IDs
  ###
  uniqueid: (len) ->
    # always start with a letter (for DOM friendlyness)
    idstr = String.fromCharCode(Math.floor((Math.random() * 25) + 65))
    # between numbers and characters (48 is 0 and 90 is Z (42-48 = 90)
    loop
      ascicode = Math.floor((Math.random() * 42) + 48)
      # exclude all chars between : (58) and @ (64)
      idstr += String.fromCharCode(ascicode)  if ascicode < 58 or ascicode > 64
      break unless idstr.length < len
    idstr

  constructor: (options) ->
    @properties = $.extend(
      list: []
      list_header: null       # top header of the list
      list_footer: null       # bottom footer of the list
      list_align: "center"    # alignment of dropdown list
      list_width: 200         # width of dropdown list, px
      custom_item: null       # additional item to place inside the button
      class_name: ""          # additional class, such as "red|green|blue-button"
      title: ""               # selector title (top line)
      subtitle: ""            # selector subtitle (bottom line)
      container: "body"       # (jQuery) container where selector will be added
      active: ""              # selected value
      callback: null          # callback "on change" - function(value)
    , options)

    @container = $(@properties.container)
    throw "Container for selector not found!"  unless @container.length

    @id = "ss-" + new Date().getTime() + "-" + @uniqueid(4)

    # cached elements
    @selector = null
    @list = null
    @list_container = null
    @title = null
    @subtitle = null
    @current_value_item = null
    @value = null

    @init()

  init: ->
    # First init: construct structure and assign handlers
    return true  if $(@container).find(@id).length

    s = @_constructSelector()
    $(@container).append s
    @selector = $(@container).find("#" + @id)
    throw "Selector not found!"  unless @selector.length

    @list_container = $(@selector).find(".square-list")
    @list = $(@list_container).find("li")
    @list_top_arrow = $(@list_container).find("span.top-arrow")
    @title = $(@selector).find(".ss-title")
    @subtitle = $(@selector).find(".ss-subtitle")
    @current_value_item = $(@selector).find(".ss-value")

    # set list width
    @list_container.width @properties.list_width + "px"

    # set list position
    square_size2 = Math.floor(@selector.width() / 2)
    list_width2 = Math.floor(@list_container.width() / 2) + 8 # 8 - padding size in the list

    if @properties.list_align == "left"
      @list_container.css
        left: "-4px",
        right: "auto"

      @list_top_arrow.css
        left: square_size2 + "px",
        right: "auto"

    if @properties.list_align == "right"
      @list_container.css
        right: "-4px",
        left: "auto"

      @list_top_arrow.css
        right: square_size2 + "px",
        left: "auto"

    if @properties.list_align == "center"
      @list_container.css
        left: "-" + (list_width2 - square_size2) + "px",
        right: "auto"

      @list_top_arrow.css
        left: (list_width2 - 8) + "px", # 8 - padding size
        right: "auto"

    # set current values
    @actualize()

    # set handlers
    @_attachHandlers()
    true

  ###
    Set selector display value according to given one
    @param [value]
  ###
  actualize: (value) ->
    search_value = value
    search_value = @properties.active  if typeof value is "undefined"

    # set according to active property
    i = 0

    search_value = search_value.toString()
    # make scan through all the values to find the required
    while i < @properties.list.length
      if @properties.list[i].value.toString() == search_value
        # set display value...
        $(@current_value_item).html @properties.list[i].display

        # change 'active' state in the list
        $(@list).removeClass "active"
        $(@list).filter("[data-value='" + search_value + "']").addClass "active"
        @properties.active = search_value
        @value = search_value
        return true
      i++
    throw "Value [" + value + "] not found!"

  ###
      Return current state
  ###
  disabled: ->
    $(@selector).hasClass('disabled')

  ###
      Disable button
  ###
  enable: ->
    $(@selector).removeClass('disabled')

  ###
      Enable button
  ###
  disable: ->
    $(@selector).addClass('disabled')

  ###
      Find item by it's value
  ###
  _findItemByValue: (value) ->
    value = value.toString()
    i = 0
    while i < @properties.list.length
      if @properties.list[i].value.toString() == value
        return i
      i++
    -1 # not found
  ###
      Get state of item in the list
  ###
  itemDisabled: (value) ->
    i = @_findItemByValue(value)
    if i >= 0
      if @properties.list[i].disabled is true
        return true
      else
        return false
    else
      throw "Value [" + value + "] not found!"
  ###
     Disable item
  ###
  disableItem: (value) ->
    i = @_findItemByValue(value)
    if i >= 0
      @properties.list[i].disabled = true
      $(@selector).find('li[data-value="' + value.toString() + '"]').addClass('disabled')
      true
    else
      throw "Value [" + value + "] not found!"
  ###
     Enable item
  ###
  enableItem: (value) ->
    i = @_findItemByValue(value)
    if i >= 0
      @properties.list[i].disabled = false
      $(@selector).find('li[data-value="' + value.toString() + '"]').removeClass('disabled')
      true
    else
      throw "Value [" + value + "] not found!"
  ###
      Rebuild whole thing
  ###
  rebuild: (list, active_value) ->
    @properties.list = $.extend list, []
    @properties.active = active_value

    $(@selector).empty()

    s = @_constructSelector true
    $(@selector).html s

    @list_container = $(@selector).find(".square-list")
    @list = $(@list_container).find("li")
    @list_top_arrow = $(@list_container).find("span.top-arrow")
    @title = $(@selector).find(".ss-title")
    @subtitle = $(@selector).find(".ss-subtitle")
    @current_value_item = $(@selector).find(".ss-value")

    @actualize()
    @_attachHandlers()

  ###
    Construct the selector html
    @returns {string}
    @private
  ###
  _constructSelector: (only_inner)->
    s = ""
    if typeof only_inner is 'undefined' then only_inner = false

    if not only_inner
      s += "<div class='square-select"

      # extra class
      s += " " + @properties.class_name unless typeof @properties.class_name is "undefined"
      s += " disabled" if @properties.disabled
      s += "' data-title='" + @properties.title + "' id='" + @id + "'>"

    # title
    s += "<span class='ss-title'>" + @properties.title + "</span>" unless typeof @properties.title is "undefined"

    s += "<i class='triangle'></i>" if @properties.list.length > 1 # open triangle
    s += "<a href='#' class='ss-value' tabindex='0'></a>" # current value

    # subtitle
    s += "<span class='ss-subtitle'>" + @properties.subtitle + "</span>" unless typeof @properties.subtitle is "undefined"

    # additional html elements (for color example etc)
    s += @properties.custom_item if @properties.custom_item
    s += "<div class='square-list'>" # list
    s += "<span class='top-arrow'></span>" # top arrow

    # custom list header
    s += "<p class='ss-header'>" + @properties.list_header + "</p>" if @properties.list_header

    # list
    if @properties.list.length > 1
      s += "<ul>"
      i = 0

      while i < @properties.list.length
        s += "<li data-value='" + @properties.list[i].value + "' data-display='" + @properties.list[i].display + "' class='"
        s += "active"  if @properties.list[i].value is @properties.active
        s += " disabled"  if @properties.list[i].disabled
        s += " separated"  if @properties.list[i].separated
        s += "'>"
        s += "<a href='#'>"
        s += if @properties.list[i].line then @properties.list[i].line else @properties.list[i].display
        s += "</a>"
        s += "</li>"
        i++

      s += "</ul>"

    # custom list footer
    s += "<p class='ss-footer'>" + @properties.list_footer + "</p>" if @properties.list_footer

    s += "</div>" # square-list

    if not only_inner
      s += "</div>" # square-select

    s # return html

  ###
    Set handlers
    @private
  ###
  _attachHandlers: ->
    selector = this

    # assign handlers for menu items (in the list)
    $(@list).find("a").unbind().click (e) ->
      e.preventDefault()

      if ($(selector.selector).hasClass('disabled'))
        return false

      if ($(this).parent().hasClass('disabled')) # li
        return false

      value = $(this).parent().data("value")

      selector.properties.callback value if typeof selector.properties.callback is "function"

      selector.actualize value

      # close selector
      $(selector.selector).removeClass "ss-open"
      $(selector.current_value_item).focus()
      false

    if @properties.list.length > 1
      # click on selector square
      $(@selector).unbind().click (e) ->
        e.preventDefault()
        if ($(selector.selector).hasClass('disabled'))
          return false

        if $(this).hasClass("ss-open")
          $(this).removeClass "ss-open"
        else
          $(".ss-open").removeClass "ss-open"
          $(this).addClass "ss-open"
        false

      $(@selector).hover null, ->
        $(this).removeClass "ss-open"

      # click on "a value" to open list
      $(@current_value_item).unbind().click (e) ->
        e.preventDefault()
        $(this).parent().trigger "click"
        false
    else
      # only one item in the list, no menu
      $(@selector).unbind().click (e) ->
        e.preventDefault()
        selector.properties.callback selector.properties.active  if typeof selector.properties.callback is "function"
        false


# keyboard events
$ ->
  $(document).keydown (e) ->
    focused_item = undefined
    selector = $(".square-select.ss-open")
    handled = false

    if ($(selector).hasClass('disabled'))
      $(selector).removeClass "ss-open"
      return false

    unless selector.length
      focused_item = document.activeElement
      if focused_item and ($(focused_item).hasClass("ss-value"))
        if (e.which is 32) or (e.which is 40)
          $(focused_item).parent().trigger "click"
          handled = true

    if not handled
      # selector list navigation
      list = $(selector).find(".square-list a")
      focused_item = $(list).filter("a:focus")
      focused_item = $(selector).find("li.active").find("a")  unless focused_item.length
      focused_item = $(list).first()  unless focused_item.length

      # up, previous item
      if e.which is 38
        $(focused_item).parent().prev().find("a").focus()
        handled = true

      # down, next item
      if e.which is 40
        $(focused_item).parent().next().find("a").focus()
        handled = true

      # escape, close list
      if e.which is 27
        $(selector).removeClass "ss-open"
        $(selector).find(".ss-value").focus()
        handled = true

    if (handled)
      e.cancelBubble = true
      if (e.stopPropagation) then e.stopPropagation()
      return false

    return true