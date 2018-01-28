// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener('DOMContentLoaded', function(){
  var first_step = document.querySelector('.first_step');
  var second_step = document.querySelector('.second_step');
  var next = document.querySelector('.next');
  var input = document.querySelector('#user_name');

  var userModal = document.querySelector('.user_modal');

  if(next){
    next.addEventListener('click', function(e){
      e.preventDefault();
      first_step.style.display = 'none';
      second_step.style.display = 'block';
    })
  }

})
