# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#Estos son archivos para generar codigo tipo javascript pero con la sintaxis de coffeescript, que reduce las funcion
#como quitar puntos y comas y codigo mas reducido de javascript

$(document).on "ajax:success", "form#comment-form", (e) ->
	e.preventDefault() 	
	console.log e
	$(this).find("textarea").val("")
    #$("#comments-box").append("<li> #{e} </li>")
#  ).on "ajax:error", (e, xhr, status, error) ->
#    $("#comments-box").append "<p>ERROR</p>"