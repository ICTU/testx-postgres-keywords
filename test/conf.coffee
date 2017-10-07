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
    require 'testx'
    testx.keywords.add require('../src')
    beforeEach -> browser.ignoreSynchronization = true
