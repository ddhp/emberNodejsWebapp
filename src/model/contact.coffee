keys = ["name", "company", "phone", "message"]
contactModel = Ember.Object.extend()
App.Contact = contactModel.reopenClass(
  submit: (contact)->
    data = {}
    for k in keys
      data[k] = contact.get(k)
    posting = $.post("contact.php", data)
    posting.done((res)->
      console.log "Message successfully sent"
    )
    posting.fail((err)->
       console.log "Failed to sent message"
    )
)
