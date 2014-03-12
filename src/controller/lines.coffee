App.Page.create(
  id: "lines"
  sort: 2
  screenName: "Product Lines"
  defineRoute: ->
    @resource("lines", {path: "product-lines"}, ->
      @resource("machine", {path: ":line_id/:machine_id"})
    )
)

App.LinesRoute = Ember.Route.extend(
  model: ->
    return App.Lines
  redirect: (model, transition)->
    # if transition made without {machine} passed(means only entering lines route)
    # then trasition with default parameters(first line and machine)
    unless transition.params.machine
      @transitionTo("machine", App.Lines[0].id, App.Machines[0].id)
)

App.LinesController = Ember.Object.extend()

App.LineRoute = Ember.Route.extend(
  model: (params)-> console.log "App.LineRoute model hook"
)
