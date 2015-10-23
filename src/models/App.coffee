# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @playerTurn, @)
    @get('dealerHand').on('hit flip', @dealerTurn, @)
    #listens for a hit or flip
      #checks game logic to see if game ends
      #do next thing

    #listen for stand 
      #flip dealer card

  playerTurn: ->
    console.log('player score = ' + @get('playerHand').score())
    if @get('playerHand').score() > 21 then @end('Player bust :(')

  dealerTurn: ->
    console.log('does this work?')
    if @get('dealerHand').score() > 21 
      @end('Dealer bust!  Good job player!')

    else 
      if @get('dealerHand').score() < 17 or (@get('dealerHand').score() is 17 and @get('dealerHand').soft())
        @get('dealerHand').hit()
      else
        @checkWinner()

  stand: ->
    @get('dealerHand').at(0).flip()
    #disable hit and stand buttons

  checkWinner: ->
    if @get('dealerHand').score() > @get('playerHand').score()
      winner = 'Dealer wins'
    else if @get('dealerHand').score() < @get('playerHand').score()
      winner = 'Player wins!'
    else
      winner = 'Push push'
    @end(winner)

  end: (reason) ->
    @trigger('end', reason)
  