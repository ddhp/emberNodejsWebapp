App.Page.create(
  id: "contact"
  sort: 4
  screenName: "Contact Us"
  defineRoute: ->
    @route("contact")
)

App.ContactRoute = Ember.Route.extend(
  model: ->
    return Ember.Object.create()

  activate: ->
    # load google map api and set callback to window.mapInitializer
    apiDiv = document.getElementById("map_script")
    if apiDiv.child
      apiDiv.removeChild("script")
    script = document.createElement("script")
    script.type = "text/javascript"
    script.src = "http://maps.googleapis.com/maps/api/js?key=#{App.config.gmapKey}&sensor=false&callback=mapInitializer"
    apiDiv.appendChild(script)
)

App.ContactController = Ember.ObjectController.extend(App.VerifyFormMixin,
  contactInfo: App.ContactInfo # info of ocean
  formInputs: [{
    key: "name"
    isNecessary: true
    isValid: false
  },{
    key: "company"
    isNecessary: true
    isValid: false
  },{
    key: "email"
    isNecessary: true
    isValid: false
  },{
    key: "phone"
    isNecessary: false
    isValid: false
  },{
    key: "message"
    isNecessary: true
    isValid: false
  }]
  submitText: "Submit"
  isSuccess: false
  isError: false

  reset: ->
    @setProperties(
      isSuccess: false
      isError: false
      name: ""
      company: ""
      email: ""
      phone: ""
      message: ""
    )

  actions: {
    submit: ->
      return if @get("isSubmitting")
      @setProperties(
        isSubmitting: true
        submitText: "Submitting..."
      )
      saving = App.Contact.submit(@get("model"))
      saving.always(=>
        @setProperties(
          isSubmitting: false
          submitText: "Submit"
        )
      )
      saving.done((res)=>
        console.log "Message successfully sent"
        @set("isSuccess", true)
        Ember.run.later(this, @reset, 5000)
      )
      saving.fail((err)=>
        console.log "Failed to sent message"
        @set("isError", true)
        Ember.run.later(this, ->
          @set("isError", false)
        , 5000)
      )
  }
)

window.mapInitializer = ->
  
  latlng = new google.maps.LatLng(25.065215, 121.513031)
  mapOptions = {
    zoom: 17,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions)
  markerOptions = {
    map: map
    position: latlng
    title: "Ocean Associate"
    labelContent: "A",
    labelAnchor: new google.maps.Point(3, 30),
    labelClass: "labels", # the CSS class for the label
    labelInBackground: false
  }
  marker = new google.maps.Marker(markerOptions)
