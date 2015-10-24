# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @playerTurn, @)
    @get('dealerHand').on('hit flip', @dealerTurn, @)
    
  playerTurn: ->
    if @get('playerHand').score() > 21 
      @end('Player bust :(')

  dealerTurn: ->
    if @get('dealerHand').score() > 21 
      @end('Dealer bust!  Good job player!')
    else 
      if @get('dealerHand').score() < 17 or (@get('dealerHand').score() is 17 and @get('dealerHand').soft())
        @get('dealerHand').hit()
      else
        @checkWinner()

  stand: ->
    context = @
    #setTimeout(context.get('dealerHand').at(0).flip.bind(context), 1000)

  checkWinner: ->
    if @get('dealerHand').score() > @get('playerHand').score()
      winner = 'Dealer wins'
    else if @get('dealerHand').score() < @get('playerHand').score()
      winner = 'Player wins!'
    else
      winner = 'Push push'
    @end(winner)

  end: (reason) ->
    @get('dealerHand').off('flip')
    if not @get('dealerHand').at(0).get('revealed') then @get('dealerHand').at(0).flip() 
    @trigger('end', reason)
  