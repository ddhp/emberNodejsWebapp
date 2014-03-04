module("Index Page", {
  setup: ->
    App.reset()
})

test("Index page intergration test", ->
  visit("/")
  andThen(->
    ok(find("header"), "header should be rendered")
    ok(find("nav"), "nav should be rendered")
    ok(find("footer"), "footer should be rendered")
  )
)
