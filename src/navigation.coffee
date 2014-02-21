App.NavigationController = Ember.Controller.extend(
  pages: App.get("pages")
)

App.Router.map(->
  router = this
  App.pages.forEach( (page)->
    page.get("defineRoute").call(router)
  )
)
