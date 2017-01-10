dbclient  = require './postgres'
parseConn = require('pg-connection-string').parse
_ = require 'lodash'

printable = (obj, delimiter = ', ') ->
    ("#{k}: #{v}" for k, v of obj).join delimiter

assertFailedMsg = (msg, ctx) ->
  "#{msg} in #{printable _.pick(ctx._meta, 'file', 'sheet', 'Row')}"

module.exports =
  'execute sql': (args, context) ->
    if args.sql
      flow = protractor.promise.controlFlow()
      flow.execute ->
        connectionString = parseConn(args['connection string'] or browser.params.postgresConnectionString)
        dbPromise = dbclient.executeQuery connectionString, args.sql
        dbPromise.then (result) ->
          if expected = args['expected result']
            failMsg = assertFailedMsg "Expected the following records: #{expected} but found: #{result}", context
            expect(result).toBe expected, failMsg
          if save = args['save result to']
            context[save] = result
        .catch (err) ->
          failMsg = assertFailedMsg err, context
          throw new Error failMsg
    else
      throw new Error 'Cannot use the "execute sql" keyword without providing "sql" parameter.'
