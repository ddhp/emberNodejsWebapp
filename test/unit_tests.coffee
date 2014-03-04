test("Testing App.Page", ->
  throws(->
    App.Page.create()
  , Error, "Should throw error when creating page without id"
  )

  pages = App.get("pages")
  pages.length = 0
  page1 = App.Page.create({id: "page1", sort: 2})
  equal(page1.get("screenName"), "Page1", "Screen name should be capitalized id by default")
  page2 = App.Page.create({id: "page2", sort: 1})
  equal(pages[0], page2, "App.pages should be ordered by key:sort ascently")
)
