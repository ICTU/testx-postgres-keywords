runner = require 'testx'

describe 'Postgres keyword', ->
  it '"execute sql" should work', ->
    runner.runExcelSheet 'test/test.xlsx', 'Sheet1'
