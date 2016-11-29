dbclient  = require './postgres'
parseConn = require('pg-connection-string').parse

module.exports =
  'execute sql': (args, context) ->
    if args.sql
      flow = protractor.promise.controlFlow()
      flow.execute ->
        connectionString = parseConn(args['connection string'] or browser.params.postgresConnectionString)
        dbPromise = dbclient.executeQuery connectionString, args.sql
        dbPromise.then (result) ->
          if expected = args['expected result']
            expect(result).toBe expected, """Expected the following records:
              #{expected}
              but found:
              #{result}"""
          if save = args['save result to']
            context[save] = result
    else
      throw new Error 'Cannot use the "execute sql" keyword without providing "sql" parameter.'
