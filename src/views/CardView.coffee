class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> 
    @render()
    @listenTo(@model, 'flip', @render)

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.html '<img src="img/card-back.png">' unless @model.get 'revealed'







