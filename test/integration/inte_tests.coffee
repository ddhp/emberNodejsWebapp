assert = chai.assert
describe("Index Page", ->
  beforeEach( ->
    App.reset()
    visit("/")
  )

  describe("Header", ->
    it('should be there', ->
      andThen(-> assert.ok(find("header")))
    )
  )

  describe("Navigation", ->
    it('should be there', ->
      andThen(-> assert.ok(find("nav")))
    )
  )

  describe("Footer", ->
    it('should be there', ->
      andThen(-> assert.ok(find("footer")))
    )
  )
)
