testx-postgres-keywords
=====

A library that extends testx with keywords for testing postgres databases. This library is packaged as a npm package and published to npm.isd.ictu

## How does it work
From the directory of the art code install the package as follows:
```sh
npm install testx-soap-keywords --save --registry=http://npm.isd.ictu
```

You can also add the following dependency to your package.json file:
```json
"testx-soap-keywords": "http://npm.isd.ictu/testx-soap-keywords/-/testx-postgres-keywords-0.1.0.tgz"
```

After installing the package you add these keywords to testx by adding the following line to your protractor config file:

```coffee
testx.addKeywords(require 'testx-postges-keywords')
```

## Keywords

| Keyword                | Argument name | Argument value  | Description | Supports repeating arguments |
| ---------------------- | ------------- | --------------- |------------ | ---------------------------- |
| check records in db        |               |                 | Connect to the database, execute the query and assert the results |  |
|                        | database url      | postgres://user:password@host:port/database || No |
|                        | query             | sql query to execute || No |
|                        | expected          | expected rows (delimited by ';') || No |
| execute sql query      |               |                 | Connect to the database, execute the query |  |
|                        | database url      | postgres://user:password@host:port/database || No |
|                        | query             | sql query to execute || No |
