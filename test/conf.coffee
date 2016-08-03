testx = require 'testx'

exports.config =
  directConnect: true
  specs: ['spec*']

  capabilities:
    browserName: 'chrome'
    shardTestFiles: false
    maxInstances: 5


  framework: 'jasmine'
  jasmineNodeOpts:
    silent: true
    defaultTimeoutInterval: 300000
    includeStackTrace: false

  rootElement: 'html'

  params:
    postgresConnectionString: 'postgres://postgres:secret@localhost:5432/postgres'
    testx:
      logScript: false
      actionTimeout: 4000

  onPrepare: ->
    testx.keywords.add require('../')
    beforeEach -> browser.ignoreSynchronization = true
