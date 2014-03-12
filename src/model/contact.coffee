keys = ["name", "company", "phone", "message"]
contactModel = Ember.Object.extend()
App.Contact = contactModel.reopenClass(
  submit: (contact)->
    data = {}
    for k in keys
      data[k] = contact.get(k)
    return $.post("contact.php", data)
    
)
