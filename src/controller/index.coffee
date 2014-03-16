App.IndexRoute = App.BaseRoute.extend()

App.IndexController = Ember.Controller.extend(
  lines: Ember.computed(->
    return App.Lines.slice(0, 3)
  ).property("App.Lines")
)
