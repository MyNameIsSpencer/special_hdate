// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(){

  var button2 = document.querySelectorAll("#ticketMaster")
  if (button2){
    button2.forEach(function(button2Each){
      button2Each.addEventListener("click", function(event){
        event.preventDefault()
        var topic = button2Each.parentNode.parentElement.classList[1]
        $.ajax({
          url: "/find_event",
          method: "GET",
          dataType: 'json',
          data: { topic: topic}
        }).done(function(data){
          if (data["_embedded"]=== undefined || data["_embedded"]["events"][0]["url"] === undefined){
            alert("No events for "+topic+" Nearby");
          }else{
            window.location.replace(data["_embedded"]["events"][0]["url"]);
          }
        })
      })
    })
  }
  
})
