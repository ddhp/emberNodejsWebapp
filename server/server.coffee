path = require("path")
express = require("express")
app = express()
server = require("http").createServer(app)
# io = require("socket.io").listen(server)
config = require("./config")

# Listen to port
server.listen(config.port)
# http.createServer(app).listen(4447)
console.log "listening on port #{config.port}"

# Simple logger
app.use (req, res, next)->
  console.log "%s %s", req.method, req.url
  next()

# Enable server to provide static data
baseDir = path.normalize(__dirname + "/..")
console.log "baseDir: "+ baseDir
app.use(express.static(baseDir))
# 
# # watch js and css files
# io.of("/livereload").on("connection", (socket)->
#   socket.emit("connected", {msg: "socket.io: Livereload connection detected"})
# )
# 
# watch = require "node-watch"
# filterWatch = (pattern, fn)->
#   return (filename)->
#     if pattern.test(filename)
#       return if /^server/i.test(filename)
#       fn(filename)
# 
# watch("./", filterWatch(/\.js$|\.css$|\.html$/, (filename)->
#   console.log "#{filename} has changed, trigger livereload"
#   io.of("/livereload").emit("reload", {msg: "socket.io: #{filename} has changed, reload page."})
# ))
# 
# compress response
# app.use(express.compress())

# parse request body
# app.use(express.json())
# app.use(express.urlencoded())

# authentication
# passport = require("passport")
# app.use express.cookieParser()
# app.use express.session({secret: 'torojesse'})
# app.use passport.initialize()
# app.use passport.session()

# define routes

