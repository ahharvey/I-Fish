# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/





#articles = new Bloodhound(
#  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('scientific_name')
#  queryTokenizer: Bloodhound.tokenizers.whitespace
#  
#articles.initialize()
#$('#get_fish').typeahead {
#  hint: true
#  highlight: true
#  minLength: 1
#},
#  name: 'scientific_name'
#  displayKey: 'scientific_name'
#  source: articles.ttAdapter()


# instantiate the bloodhound suggestion engine
#numbers = new Bloodhound(
#  datumTokenizer: Bloodhound.tokenizers.whitespace
#  queryTokenizer: Bloodhound.tokenizers.whitespace
#  remote: url: '/api/fishes/?v=1&q=%QUERY')
## initialize the bloodhound suggestion engine
#numbers.initialize()
#$('#get_fish').typeahead
#  items: 4
#  source: numbers.ttAdapter()

# ---
# generated by js2coffee 2.0.0

#alert $('#get_fish').data('provide')
#bestPictures = new Bloodhound(
#  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('scientific_name')
#  queryTokenizer: Bloodhound.tokenizers.whitespace
#  local: $.map($('#get_fish').data('provide'), (fish) ->
#    { name: fish }
#  ))
#bestPictures.initialize()
#$('#get_fish').typeahead null,
#  name: 'best-pictures'
#  displayKey: 'name'
#  source: bestPictures.ttAdapter()

jQuery ->
  $('#get_fish').autocomplete
    source: $('#get_fish').data('autocomplete-source')
jQuery ->
  $('#get_bait').autocomplete
    source: $('#get_bait').data('autocomplete-source')
jQuery ->
  $('#get_gear').autocomplete
    source: $('#get_gear').data('autocomplete-source')
jQuery ->
  $('#get_company').autocomplete
    source: $('#get_company').data('autocomplete-source')
jQuery ->
  $('#get_office').autocomplete
    source: $('#get_office').data('autocomplete-source')
jQuery ->
  $('#get_role').autocomplete
    source: $('#get_role').data('autocomplete-source')
jQuery ->
  $('#fishery_protocol_id').select2
    placeholder: 'Select a protocol'
    allowClear: true


