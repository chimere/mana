card_attrs = { name: 'Forest', image: 'http://a.jpg', id: 42, user_id: 43, order: 1 }


module 'Card tests'
  setup: ->
    @card = new Card(card_attrs)
    Backbone.sync = ->

test 'throws exception on missing user ID', ->
  raises ->
    new Card({ id: 42, name: 'Forest', image: 'http://a.jpg' })

test 'throws exception on null ID', ->
  raises ->
    new Card({ name: 'Forest', image: 'http://a.jpg', user_id: 43 })

test 'Attributes are assigned in constructor', ->
  equals @card.name(), 'Forest'
  equals @card.image(), 'http://a.jpg'

test 'is not tapped by default', ->
  equals @card.tapped(), false

test 'has non-null ID', ->
  ok _.isNumber(@card.id)

test 'can be tapped', ->
  ok  @card.toggle_tapped().tapped()


module 'CardView tests'
  setup: ->
    Backbone.sync = ->
    @card = new Card(card_attrs)
    @view = new CardView({ model: @card })

test 'creates correct element', ->
  equals $(@view.el).find('img').attr('src'), 'http://a.jpg'
  equals $(@view.el).attr('id'), 'card-42'
  ok $(@view.el).hasClass('card')

test 'tapping a card changes its view', ->
  @card.toggle_tapped(true)
  ok $(@view.el).hasClass('tapped')

test 'covering should show back side of the card', ->
  @card.toggle_covered(false)
  @card.toggle_covered(true)
  equals $(@view.el).find('img').attr('src'), '/images/back.jpg'

