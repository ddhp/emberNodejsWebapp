# Reset functions
document.write("<div id='foo'><div id='ember-testing'></div></div>")
App.rootElement = "#ember-testing"
Ember.testing = true
App.setupForTesting()
App.injectTestHelpers()
