$(document).on 'turbolinks:load', ->
  $('.alluserDropDown').on 'change', (e) ->
    userId = $('#user_id :selected').val();
    window.location = "/events?user_id=#{userId}"
