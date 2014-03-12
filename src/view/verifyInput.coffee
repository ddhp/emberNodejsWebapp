App.VerifyInputView = Ember.View.extend(
  templateName: "verifyInput"
  isValid: false
  isInvalid: false
  classNameBindings: [
    ":form-group"
    "isEmpty::has-feedback"
    "isValid:has-success"
    "isInvalid:has-error"
  ]
  rows: "5"

  placeholder: Ember.computed(->
    return "Enter #{@get("key")}"
  ).property("key")

  # observe the type of input and set is{#type} boolean value
  # for the usage of view hbs
  typeObserver: (->
    k = Ember.String.capitalize(@get("inputType"))
    @set("is#{k}", true)
  ).observes("inputType").on("init")

  isOneInputLeft: Ember.computed(->
    return @get("controller.isOneInputLeft")
  ).property("controller.isOneInputLeft")

  keyUp: ->
    @get("controller").send("keyUp")
    # verify input on "keyup" is triggered only when the input is invalid
    @verifyFn() if @get("isInvalid") or @get("isOneInputLeft")

  change: -> @verifyFn()

  verifyFn: ->
    switch @get("verifyType")
      when "length" then @v_length()
      when "email" then @v_email()
      when "phone" then @v_phone()
      else @setValidation(!!@get("value"))
    @get("controller").send("checkNow", @get("isValid"), @get("key"))

  setValidation: (isValid)->
    @set("isValid", isValid)
    @set("isInvalid", !isValid)

  checkEmpty: ->
    value = @get("value")
    if !!value
      @set("isEmpty", false)
      return value
    @set("isEmpty", true)
    @set("isValid", false)
    @set("isInvalid", false)
    return undefined

  # possible verify types: phone, email, password, length
  v_length: ->
    text = @checkEmpty()
    return if !text
    # text = @get("value")
    if text.length > 2
      @setValidation(true)
    else
      @setValidation(false)

  v_email: ->
    text = @checkEmpty()
    return if !text
    reg = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
    if reg.test(text)
      @setValidation(true)
    else
      @setValidation(false)

  v_phone: ->
    text = @checkEmpty()
    return if !text
    reg = new RegExp("\\d{5,12}")
    if reg.test(text)
      @setValidation(true)
    else
      @setValidation(false)
)

Ember.Handlebars.helper("capitalize", (value)->
  return Ember.String.capitalize(value)
)
