# README

This is a sample rails 6 API application that features a few unusual use cases:

- Connecting to an preexisting database and adapting to the existing models
- Tapping into arel for case-insensitive querying without custom SQL
- Caching of query results on the cache store
- Simple token authorization

# Requirements

- Postgresql
- Ruby 2.7

# Installing

- clone this repo
- `bundle install`
- `rails data:hydrate` optionally with the number of records to add: `rails data:hydrate number=5000`
- `rails data:create_whitelisted_client` optionally with a describer for your whitelisted client `rails data:create_whitelisted_client name="Authorized frontend"`

# Running

- `rails s`

# Examples

Get all coaches in Seattle, United States
```
curl --request GET \
  --url 'http://localhost:3000/api/v1/coach_directory?country=United%20States&city=Seattle' \
  --header 'Accept: application/json,*/*'
  --header 'Authorization: Token 7c8avdMvv0IaQ03zTkNd0Oa' \
```

Get all coaches in Germany
```
curl --request GET \
  --url 'http://localhost:3000/api/v1/coach_directory?country=Germany' \
  --header 'Accept: application/json,*/*'
  --header 'Authorization: Token 7c8avdMvv0IaQ03zTkNd0Oa' \
```

Get all coaches in the 90210 zip (postal code)
```
curl --request GET \
  --url 'http://localhost:3000/api/v1/coach_directory?postal_code=90210' \
  --header 'Accept: application/json,*/*'
  --header 'Authorization: Token 7c8avdMvv0IaQ03zTkNd0Oa' \
```

Get all coaches where their name starts with 'Joa'
```
curl --request GET \
  --url 'http://localhost:3000/api/v1/coach_directory?name_starts_with=Joa' \
  --header 'Accept: application/json,*/*'
  --header 'Authorization: Token 7c8avdMvv0IaQ03zTkNd0Oa' \
```

# License

coaches directory - an example Rails 6 API app
Copyright © 2020 Miguel Verissimo

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

