# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).ready ->

    $(".remove_fields").first().hide()

    if $(".remove_fields").filter(':visible').length > 3
      $(".add_fields").hide()

    unless $("#game_names_attributes_1_content").length > 0
      $('#game_names_attributes_0_popularity').first().hide()

    $('form').on 'click', '#game-all-ages', (event) ->


    $('form').on 'click', '.remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault
      if $(".add_fields").filter(':visible').length == 0
        $(".add_fields").show()
      if $(".remove_fields").filter(':visible').length == 0     
        $('#game_names_attributes_0_popularity').hide()  

    $('form').on 'click', '.add_fields', (event) ->
      if $(".remove_fields").filter(':visible').length < 3
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $('#game_names_attributes_0_popularity').show()
        event.preventDefault()
      else if $(".remove_fields").filter(':visible').length >= 3
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $(".add_fields").hide()
        event.preventDefault()