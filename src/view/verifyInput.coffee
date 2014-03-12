App.VerifyInputDivView = Ember.View.extend(
  templateName: "verifyInput"
  isValid: false
  isInvalid: false
  classNameBindings: [
    ":form-group"
    ":has-feedback"
    "isValid:has-success"
    "isInvalid:has-error"
  ]
  rows: "5"

  placeholder: Ember.computed(->
    return "Enter #{@get("key")}"
  ).property("key")

  typeObserver: (->
    k = Ember.String.capitalize(@get("inputType"))
    @set("is#{k}", true)
  ).observes("inputType").on("init")

  change: ->
    return unless @get("isNecessary")
    if @get("value")
      @set("isValid", true)
      @set("isInvalid", false)
    else
      @set("isInvalid", true)
      @set("isValid", false)
)

Ember.Handlebars.helper("capitalize", (value)->
  return Ember.String.capitalize(value)
)
