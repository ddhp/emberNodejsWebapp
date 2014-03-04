window.App = Ember.Application.create()

# App.pages store all pages controlled by navigation controller
# extend App.page and push it into App.pages
# these will be shown by order of key:sort

App.Page = Ember.Object.extend(
  init: ->
    unless @get("id")
      throw new Error 'You must specify an id'
    pages = App.get("pages")
    pages.push(this)
    pages.sort((a, b)->
      return a.sort-b.sort
    )

  defineRoute: Ember.computed ->
    id = @get('id').toString()
    return ->
      @route(id, {path: id})
  .property()

  screenName: Ember.computed(->
    return Ember.String.capitalize(@get('id').toString())
  ).property()

  sort: Infinity
)

App.pages = []
# Example for creating a page
# [].push.call(App.pages, App.Page.create(
#   id: "route-name"
#   screenName: "name shown"
#   sort: 1
#   )
# )
