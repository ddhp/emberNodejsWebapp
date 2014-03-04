test("Index page intergration test", ->
  App.reset()
  visit("/").then(->
    ok(find("header"), "header should be rendered")
    ok(find("nav"), "nav should be rendered")
    ok(find("footer"), "footer should be rendered")
  )
)
