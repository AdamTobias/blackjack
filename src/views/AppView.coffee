class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class ="new-game-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="results"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.stand()
    'click .new-game-button': -> 
      @model.initialize()
      @initialize()

  initialize: ->
    @listenTo(@model, 'end', @renderResults)
    @render()
    console.log(@model.get('playerHand').score())
    console.log(@model.get('dealerHand').trueScore())
    if @model.get('playerHand').score() is 21 and @model.get('dealerHand').trueScore() is 21
      @model.end('Two blackjacks!  Push push!')
    else if @model.get('playerHand').score() is 21  
      @model.end('Blackjack!')  
    else if @model.get('dealerHand').trueScore() is 21
      @model.end('Dealer blackjack :( Player loses')

  renderResults: (reason) ->
    @$('.hit-button, .stand-button').attr('disabled', 'true')
    @$('.new-game-button').css({'display': 'inline'})
    @$('.results').html new ResultsView({reason: reason}).el

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

