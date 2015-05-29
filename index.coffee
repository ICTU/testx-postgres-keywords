dbclient  = require './postgres'

module.exports =
  'check records in db': (args) ->
    dbPromise = dbclient.retrieveRecords(args["database url"], args.query)
    dbPromise.then (result) ->
      since("Expected the following records:\n#{args.expected} \nbut found:\n#{result}")
      .expect(result).toBe(args.expected)
    .catch (error) ->
      since(error)
      .expect(error).toBeUndefined()
  'execute sql query': (args) ->
    dbPromise = dbclient.executeQuery(args["database url"], args.query)
    dbPromise.then (result) ->
      console.log 'Successfully executed query'
    .catch (error) ->
      since(error)
      .expect(error).toBeUndefined()
