# Route is included in lines.coffee

App.MachineRoute = App.BaseRoute.extend(
  model: (params)->
    App.Machines.find((machine)->
      return machine if machine.id is params.machine_id
    )
)

App.MachineController = Ember.ObjectController.extend(
  modelChange: (->
    window.scrollTo(0, 0)
  ).observes("model")
)
