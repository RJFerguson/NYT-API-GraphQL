# README 

A Simple implementation of of a Ruby on Rails API using API the default API middleware. 

Key take away’s for a person new to GraphQL and API’s in general:
```ruby
 # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
 gem 'rack-cors'

gem 'graphql', '1.6.3'
gem 'graphiql-rails', '1.4.2'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
``` 
```ruby
config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :patch]
      end
    end
```

Creating your GraphQL controller


```ruby
 class GraphqlController < ApplicationController

 def query
    result = Schema.execute(params[:query], variables: params[:variables])
    render json: result
  end
end
```
Building out your schema to allow for usage at the graphql endpoint 

```ruby
#1

ArticleType = GraphQL::ObjectType.define do 
  name 'Article'
  description 'Something to read'

  field :id, !types.ID 
  field :webUrl, !types.String, property: :web_url
  field :leadParagraph, !types.String, property: :lead_paragraph
  field :headline, !types.String, "The article headline"
  field :pubDate, !types.String, property: :pub_date
  field :wordCount, !types.Int, property: :word_count
end 

#2

QueryType = GraphQL::ObjectType.define do 
  name 'Query'
  description 'The root of all queries'

  field :allArticles do
    type types[ArticleType]
    description 'All the articles in the DB'
    resolve -> (obj, args, ctx) {Article.all}
  end 


  field :article do 
    type ArticleType
    description 'The article associated with the given ID'
    argument :id, !types.ID 
    resolve -> (obj, args, ctx) {Article.find(args[:id])}
  end 
end 

#3

Schema = GraphQL::Schema.define do
  query QueryType
end
```

what the scraping looks like. 


```ruby
require "net/http"
require "uri"
require "json"
uri = URI.parse("http://api.nytimes.com/svc/archive/v1/YR/MNTH.json?api-key=YOUR_API_KEY")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
response.code             # => 301
check = JSON.parse(response.body)
check["response"]["docs"].each do |data|
  Article.create(web_url: data["web_url"], lead_paragraph: data["lead_paragraph"], headline: data["headline"]["main"], pub_date: data["pub_date"], word_count: data["word_count"] )
End
```
