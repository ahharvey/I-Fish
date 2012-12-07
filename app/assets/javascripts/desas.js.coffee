# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

place_desa_markers = (map) ->
  rows = $("#desa_table tr:gt(0)")
  rows.each (i, row) ->
    console.log $(row.children[1]).html()
    console.log $(row.children[2]).html()
    loc = new google.maps.LatLng($(row.children[1]).html(), $(row.children[2]).html())
    new google.maps.Marker
      position: loc
      map: map
      title: $(row.children[0]).html()

$(document).ready ->
  # Set up Google map
  map_options =
    center: new google.maps.LatLng(-6.21154, 106.84517)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), map_options)
  google.maps.event.addListener(map, 'tilesloaded', place_desa_markers(map))