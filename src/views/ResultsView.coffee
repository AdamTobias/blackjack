class window.ResultsView extends Backbone.View
  tagName: 'h1'

  #template: _.template '<%= reason %>'

  initialize: (reason) -> @render(reason)

  render: (reason) ->
    @$el.html reason.reason
    
