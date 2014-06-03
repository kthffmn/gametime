jQuery ->
  $(document).ready ->

    $('#game_tag_ids').chosen()
    $('#game_relation_ids').chosen()

    $("#game_is_an_exercise").iphoneStyle
      checkedLabel: "EXERCISE"
      uncheckedLabel: "GAME"

    $(".iPhoneCheckHandle").css("width", "96")

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
      if $('.add-name').filter(':visible').length == 0
        $('.add-name').show()
      if $('.add-tag').filter(':visible').length == 0
        $('.add-tag').show()
      if $('.remove_fields').filter(':visible').length == 0     
        $('#game_names_attributes_0_popularity').hide()  

    $('form').on 'click', '.add-name', (event) ->
      if $('.new-name-form').children().filter("fieldset").filter(':visible').length < 2
        time = new Date().getTime() 
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $('#game_names_attributes_0_popularity').show()
        event.preventDefault()
      else if $('.new-name-form').children().filter("fieldset").filter(':visible').length >= 2
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $(this).hide()
        event.preventDefault()

    $('form').on 'click', '.add-tag', (event) ->
      if $('.new-tag-form').children().filter("fieldset").filter(':visible').length < 3
        time = new Date().getTime() 
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        event.preventDefault()
      else if $('.new-tag-form').children().filter("fieldset").filter(':visible').length >= 3
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $(this).hide()
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