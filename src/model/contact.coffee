keys = ["name", "company", "phone", "message", "email"]
contactModel = Ember.Object.extend()
App.Contact = contactModel.reopenClass(
  submit: (contact)->
    data = {}
    for k in keys
      data[k] = contact.get(k)
    return $.post("contact.php", data)
    
)
App.ContactInfo = [{
  key: "Address"
  value: "6F, No. 75, Sec. 3, Chung King North Road, Taipei 103, Taiwan"
  icon: "glyphicon-home"
},{
  key: "Phone"
  value: "886-2-2597-1299"
  icon: "glyphicon-earphone"
},{
  key: "Fax"
  value:"886-2-2597-1300"
  icon: "glyphicon-print"
},{
  key: "E-mail"
  value:"ocn@ms12.hinet.net"
  icon: "glyphicon-envelope"
}]
