pg = require 'pg'
q  = require 'q'

exports.executeQuery = (connectionString, sql) ->
  deferred = q.defer()

  # Create client and connect
  client = new pg.Client(connectionString)
  client.connect (err) ->
    if err
      console.error "Could not connect to the database because:\n#{err}"
      deferred.reject "Could not connect to the database because:\n#{err}"

  # Execute query
  query = client.query sql
  query.on 'row', (row, result) ->
    result.addRow row

  query.on 'end', (result) ->
    rows = result.rows.map (row) ->
      (v for k, v of row).join ';'
    csvRecords = rows.join '\n'
    deferred.resolve csvRecords
    client.end()
  query.on 'error', (err) ->
    deferred.reject "Could not execute query because:\n#{err}"

  deferred.promise
