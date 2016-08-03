testx-postgres-keywords
=====

A library that extends testx with keywords for testing [Postgres](https://www.postgresql.org/) databases.

## How does it work
From the directory of the art code install the package as follows:
```sh
npm install testx-postgres-keywords --save
```

After installing the package you add these keywords to testx by adding the following line to your protractor config file:

```coffee
testx.addKeywords(require 'testx-postgres-keywords')
```

## Keywords

| Keyword                | Argument name | Argument value  | Description | Supports repeating arguments |
| ---------------------- | ------------- | --------------- |------------ | ---------------------------- |
| execute sql            |               |                 | Connect to the database, execute the SQL query/statement and optionally check the expected result and/or save it in the test context. |  |
|                        | connection string | Connection string in the format of *postgres://user:password@host:port/database*.| Optional. If not set, the **postgresConnectionString** command line (or config file) parameter will be used.| No |
|                        | sql             | SQL query/statement to execute. | Required. | No |
|                        | expected result | Expected result of the query. | Optional. It will be compared to the result of the query. The keyword will fail if they are different. Rows (records) in the result are separated by newline character, values in a row are separated by a semicolon (;). | No |
|                        | save result to  | *varname* | Optional. The name of a context variable, that will be used to save the result of the query. | No |
