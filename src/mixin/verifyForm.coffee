# Every form which needs verfication extend this mixin
# The controller MUST have a "formInputs" attribute lists all input info
App.VerifyFormMixin = Ember.Mixin.create(
  isReady: false
  isOneInputLeft: false

  reset: ->
    @setProperties(
      isReady: false
      isOneInputLeft: false
    )

  actions:
    checkNow: (isValid, key)->
      # set isValid to the one provided with correspond key
      for input in @get("formInputs")
        input.isValid = isValid if input.key is key

      # check if all inputs are valid
      notReady = Array.prototype.find.call(@get("formInputs"), (input)->
        input.isValid is false and input.isNecessary is true
      )

      @set("isReady", !notReady)
      @set("isOneInputLeft", false)

    keyUp: ->
      # look through "formInput" recursively
      # check how many falsy isValid
      # set "isOneInputLeft" to true when there is only one
      i = 0
      for input in @get("formInputs")
        i++ if input.isValid is false and input.isNecessary is true
      @set("isOneInputLeft", true) if i is 1
)
