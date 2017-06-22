
ArticleType = GraphQL::ObjectType.define do 
  name 'Article'
  description 'Something to read'

  field :id, !types.ID 
  field :webUrl, !types.String, property: :web_url
  field :leadParagraph, !types.String, property: :lead_paragraph
  field :headline, !types.String, "The article headline"
  field :pubDate, !types.String, property: :pub_date
  field :wordCount, !types.Int, property: :word_count
  field :snippet, !types.String
  field :abstract, !types.String 
  field :printPage, !types.String, property: :print_page
  field :source, !types.String
  field :documentType, !types.String, property: :document_type
  field :sectionName, !types.String, property: :section_name
  field :subsectionName, !types.String, property: :subsection_name
  field :nytID, !types.String, property: :nyt_id 
  field :slideshowCredits, !types.String, property: :slideshow_credits
  field :keywords, !types.String
end 



# QueryType = GraphQL::ObjectType.define do
#   name 'Query'
#   field :hello do
#     type types.String
#     resolve -> (obj, args, ctx) { 'Hello GraphQL' }
#   end
# end

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

Schema = GraphQL::Schema.define do
  query QueryType
end




