App.Page.create(
  id: "posts"
  defineRoute: ->
    @resource("posts", ->
      @resource("post", {path: ":post_id"}, ->
        @route("edit")
      )
    )
)


App.PostsIndexRoute = Ember.Route.extend(
  model: ->
    $.getJSON("cms/api/v1/posts")
)

App.PostRoute = Ember.Route.extend(
  model: (params)->
    $.getJSON("cms/api/v1/posts/#{params.post_id}")
)

App.PostController = Ember.ObjectController.extend(
  isEditing: false

  actions:
    activateEdit: ->
      @toggleProperty("isEditing")
      return false
)
