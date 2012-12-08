# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

hide_desa_info = () ->
  $("#desa_info").hide()

show_desa_info = (title, x, y) ->
  console.log "Show info at #{x}, #{y}"
  $("#desa_info").css("left", x)
  $("#desa_info").css("top", y)

  # TODO: Put any info about the Desa onto the list here
  $("#desa_info").show()

$(document).ready ->
  # Global list of map markers
  window.map_markers = []

  # Set up Google map
  map_options =
    center: new google.maps.LatLng(-6.21154, 106.84517)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.ROADMAP

  # Initiate map and overlay
  map = new google.maps.Map(document.getElementById("map_canvas"), map_options)
  overlay = new google.maps.OverlayView()
  overlay.draw = ->
  overlay.setMap map

  # Add markers once map is loaded
  google.maps.event.addListener map, 'tilesloaded', () ->
    rows = $("#desa_table tr:gt(0)")
    rows.each (i, row) ->
      console.log $(row.children[1]).html()
      console.log $(row.children[2]).html()
      loc = new google.maps.LatLng($(row.children[1]).html(), $(row.children[2]).html())
      marker = new google.maps.Marker
        position: loc
        map: map
        title: $(row.children[0]).html()

      # Add to global list of markers
      window.map_markers.push marker

  # Add marker click events once map is idle
  google.maps.event.addListener map, 'idle', () ->
    proj = overlay.getProjection()
    for marker in window.map_markers
      # Add click event to show info
      google.maps.event.addListener marker, 'click', () ->
        pos = proj.fromLatLngToContainerPixel(this.getPosition())
        show_desa_info(this.title, pos.x, pos.y)


  hide_desa_info()