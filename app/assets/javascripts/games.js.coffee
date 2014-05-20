# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('#game_tag_ids').chosen()
  $('#game_relation_ids').chosen()

  $(document).ready ->

    $('.remove_fields').first().hide()

    if $('.remove_fields').filter(':visible').length > 3
      $('.add_fields').hide()

    unless $('#game_names_attributes_1_content').length > 0
      $('#game_names_attributes_0_popularity').first().hide()

    $('form').on 'click', '.add-a-tag', (event) ->
      if $(this).hasClass("active")
        $('.new-tag-form').hide()
        $('#game_tags_attributes_0_name').val(undefined);
        $(this).removeClass("active")
        $(this).text("Make new tag")
      else
        $('.new-tag-form').show()
        $(this).text("Remove tag")
        $(this).addClass("active")

    $('form').on 'click', '.remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault
      if $('.add_fields').filter(':visible').length == 0
        $('.add_fields').show()
      if $('.remove_fields').filter(':visible').length == 0     
        $('#game_names_attributes_0_popularity').hide()  

    $('form').on 'click', '.add_fields', (event) ->
      if $('.remove_fields').filter(':visible').length < 3
        time = new Date().getTime() 
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $('#game_names_attributes_0_popularity').show()
        event.preventDefault()
      else if $('.remove_fields').filter(':visible').length >= 3
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $('.add_fields').hide()
        event.preventDefault()

    $('form').on 'click', '#game_all_ages', (event) ->
      if $('#game_all_ages').is(':checked') 
        trueOrFalse = true
      else
        trueOrFalse = false
      $('#game_early_childhood, #game_elementary_school, #game_middle_school, #game_high_school, #game_college, #game_adulthood').prop("checked", trueOrFalse)

    $('form').on 'click', '#game_early_childhood, #game_elementary_school, #game_middle_school, #game_high_school, #game_college, #game_adulthood', (event) ->
      if $("#game_all_ages").is(":checked")
        $("#game_all_ages").prop "checked", false
      if $("#game_early_childhood").is(':checked') and $("#game_elementary_school").is(':checked') and $("#game_middle_school").is(':checked') and $("#game_high_school").is(':checked') and $("#game_college").is(':checked') and $("#game_adulthood").is(':checked')
        $("#game_all_ages").prop "checked", true

      
