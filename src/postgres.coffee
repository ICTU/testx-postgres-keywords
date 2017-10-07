pg = require 'pg'

exports.executeQuery = (connectionString, sql) ->
  new Promise (resolve, reject) ->
    # Create client and connect
    client = new pg.Client(connectionString)
    client.connect (err) ->
      if err
        console.error "Could not connect to the database because:\n#{err}"
        reject "Could not connect to the database because:\n#{err}"

    # Execute query
    query = client.query sql
    query.on 'row', (row, result) ->
      result.addRow row

    query.on 'end', (result) ->
      rows = result.rows.map (row) ->
        fields = {}
        fields[k] = v for k, v of row
        fields
      client.end()
      resolve rows
    query.on 'error', (err) ->
      client.end()
      reject "Could not execute query because:\n#{err}"
