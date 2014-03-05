assert = chai.assert
describe("Testing application setup functions", ->
  describe("App.Page class", ->
    it('should throw error when creating page without id', ->
      assert.throws((-> App.Page.create()), Error)
    )
  )

  describe("ScreenName of instace of App.Page", ->
    it('should be capitalized id by default', ->
      page1 = App.Page.create({id: "page1", sort: 2})
      assert.equal(page1.get("screenName"), "Page1")
    )
  )
  
  describe("App.pages", ->
    it('should be ordered by key: sort ascently', ->
      pages = App.get("pages")
      pages.length =  0
      page1 = App.Page.create({id: "page1", sort: 2})
      page2 = App.Page.create({id: "page2", sort: 1})
      assert.equal(pages[0], page2)
    )
  )
)
