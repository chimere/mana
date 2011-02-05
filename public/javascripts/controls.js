$(document).ready(function() {
  bind_control('.uncover-button',function(box) { box.uncoverAll(); });
  bind_control('.shuffle-button',function(box) { box.shuffle(); });
  bind_control('.close-button',function(box) { box.pack_unpack(this); });


  $('.browse-button').click(function() { 
    // TODO: can be done smarter - check again when online
      $(this).parent().next().object().pack_unpack();
   });

  $('#battlefield').click(function(event) {
      $('#hand').object().toggleShow(event);
      event.stopPropagation();
  });
});


  // $('#battlefield').rightClick(function(event,ui) {
  //   console.info(event);
  //   var token = Card.createToken( event.offsetX, event.offsetY);
  //   token.element.appendTo('#battlefield');
  //   event.preventDefault();
  // });

$(document).keydown(function(e) {
    if (e.keyCode == 17) {
      controlKeyDown = true;
    }
});

$(document).keyup(function(e) {
    if (e.keyCode == 17) {
      controlKeyDown = false;
    }
});


function bind_control(name, action) {
 $(name).click(function(event) {
    action($(this).closest('.box').object());
    event.preventDefault();
    event.stopPropagation();
  });
}