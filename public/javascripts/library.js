Library = function() {
  this.element = $('#library')
}


Library.prototype.update = function(cards) {
  var lib = this.element;

  $(cards).each(function(i,params) {
    card = new Card(params);
    card.turnOverLocally(true);
    card.element.css('position', 'absolute')
    $('#library').object().dropLocally(card);
  });
}

Library.prototype.shuffle = function() {
  var lib = this.element;
}




Library.prototype.drawCard = function() {
  hand = Utils.getObjectFromDom($('#hand'));

  if (this.cards.length > 0) {
    hand.showHand();

    params = this.cards.pop()
    card = new Card(params);

    hand.addCard(card);
  } else {
    // TODO: make it better
    game.message('No more cards in the library.');
  }
}
