pg        = require 'pg'        # Library for connection to postgres database
q         = require 'q'

# Retrieve records from database
exports.retrieveRecords = (connectionString, sql) ->
  deferred = q.defer()

  # Create client and connect
  client = new (pg.Client)(connectionString)
  client.connect (err) ->
    if err
      deferred.reject "Could not connect to database because:\n#{err}"

  # Execute query
  query = client.query sql
  query.on 'row', (row, result) ->
    result.addRow row

  query.on 'end', (result) ->
    fieldCount = result.fields.length
    rowCount = result.rows.length
    csvRecords = ''
    for row, rowIndex in result.rows
      fieldIndex = 0
      for field of row
        fieldIndex++
        delimiter = if fieldIndex < fieldCount then ';' else ''
        csvRecords = csvRecords + row[field] + delimiter
      newLine = if (rowIndex + 1) < rowCount then '\n' else ''
      csvRecords = csvRecords + newLine
    client.end()
    deferred.resolve csvRecords

  query.on 'error', (err) ->
    deferred.reject "Could not retrieve records because:\n#{err}"

  deferred.promise

exports.executeQuery = (connectionString, sql) ->
  deferred = q.defer()

  # Create client and connect
  client = new (pg.Client)(connectionString)
  client.connect (err) ->
    if err
      deferred.reject "Could not connect to database because:\n#{err}"

  console.log 'Executing query: ' + sql
  query = client.query sql

  query.on 'end', (result) ->
    client.end()
    deferred.resolve 'Query executed successfully'

  query.on 'error', (err) ->
    client.end()
    deferred.reject "Could not execute query because:\n#{err}"

  deferred.promise
