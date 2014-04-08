contextURL = require("./config").contextURL

module.exports.defineRoutes = (app)->
  console.log "define route from post controller"
  app.get("#{contextURL}/posts", (req, res, next)->
    console.log "requesting #{contextURL}/posts"
    return res.send(200, [{
      id: "1"
      author: "ddhp"
      title: "Test title"
      article: "test"
      create_time: Date.now()
      update_time: Date.now()
    }])
  )

  app.get("#{contextURL}/posts/:id", (req, res, next)->
    console.log "requesting #{contextURL}/posts/id=#{req.params.id}"
    res.send(200, {
      id: "1"
      author: "ddhp"
      title: "Test title"
      article: "test"
      create_time: Date.now()
      update_time: Date.now()
      }
    )
  )

  app.post("#{contextURL}/posts", (req, res, next)->
    console.log "requesting to post #{contextURL}/posts"
  )
