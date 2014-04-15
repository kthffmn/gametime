# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).ready ->
    $(".remove_fields").hide()  if $(".remove_fields").filter(":visible").length < 2

    $('form').on 'click', '.remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault
      if $(".add_fields").filter(':visible').length < 1
        $(".add_fields").show()      

    $('form').on 'click', '.add_fields', (event) ->
      if $(".remove_fields").filter(':visible').length < 3
        console.log("if: " + $(".remove_fields").filter(':visible').length)
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        event.preventDefault()
      else if $(".remove_fields").filter(':visible').length >= 3 && $(".remove_fields").filter(':visible').length < 5
        console.log("else if: " + $(".remove_fields").filter(':visible').length)
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $(".add_fields").hide()
        event.preventDefault()
