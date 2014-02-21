window.App = Ember.Application.create()

# App.pages store all pages controlled by navigation controller
# extend App.page and push it into App.pages
# these will be shown by order of your push

App.Page = Ember.Object.extend(
  # id will be treat as route name and default route url
  id: Ember.computed(->
    throw new Error 'You must specify an id'
  ).property()

  defineRoute: Ember.computed ->
    id = @get('id').toString()
    return ->
      @route(id, {path: id})
  .property()

  screenName: Ember.computed(->
    return Ember.String.capitalize(@get('id').toString())
  ).property()
)

App.pages = []
# Example for creating a page
# [].push.call(App.pages, App.Page.create(
#   id: "route-name"
#   screenName: "name shown"
#   )
# )
