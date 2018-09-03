exports.config =
  directConnect: true
  specs: ['spec*']

  capabilities:
    browserName: 'chrome'
    shardTestFiles: false
    maxInstances: 5
    chromeOptions:
      args: ["--no-sandbox", "--headless", "--disable-gpu", "--window-size=1024,800"]


  framework: 'jasmine'
  jasmineNodeOpts:
    silent: true
    defaultTimeoutInterval: 300000
    includeStackTrace: false

  rootElement: 'html'

  params:
    postgresConnectionString: 'postgres://postgres:secret@127.0.0.1:5432/postgres'
    testx:
      logScript: false
      actionTimeout: 4000

  onPrepare: ->
    require '@ictu/testx'
    testx.keywords.add require('../src')
    beforeEach -> browser.ignoreSynchronization = true
