# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#Estos son archivos para generar codigo tipo javascript pero con la sintaxis de coffeescript, que reduce las funcion
#como quitar puntos y comas y codigo mas reducido de javascript

$(document).ready ->
  $("#comment-form").on("ajax:success", (xhr, status, err) ->
    $(this).find("textarea").val("")
    console.log xhr.originalEvent.detail[0].user.email
    $("#comments-box").append("<li class='li-comment'> - #{xhr.originalEvent.detail[0].body} - <strong>Escrito por: </strong> #{xhr.originalEvent.detail[0].user.email} </li>")
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#comments-box").append "<p>ERROR</p>"