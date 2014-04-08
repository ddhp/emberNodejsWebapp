_ = require("lodash")

postService = {}

postService.findAll = ->
  # get all items from database

postService.findOne = (id)->
  # get specific item from db

postService.findIds = (ids)->
  # get specific items from db with ids

postService.find = (param)->
  if param
    if _.isArray(param)
      @findIds(param)
    else
      @findOne(param)
  else
    @findAll()

module.exports = postService



