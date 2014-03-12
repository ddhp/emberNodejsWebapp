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
    script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyB2dwuEYrEYwdJPr5gr4jOrMfMn2oUHXh4&sensor=false&callback=mapInitializer"
    apiDiv.appendChild(script)
)

App.ContactController = Ember.ObjectController.extend(
  actions: {
    submit: ->
      App.Contact.submit(@get("model"))
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
