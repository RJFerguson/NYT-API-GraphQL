require "net/http"
require "uri"
require "json"
require 'csv'
DOC = 'file.csv'
uri = URI.parse("http://api.nytimes.com/svc/archive/v1/2017/5.json?api-key=0591740beb04400887ae52ed3bf76f64")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
response.code             # => 301
check = JSON.parse(response.body)
check["response"]["docs"].each do |data|
  Article.create( slideshow_credits: data["slideshow_credits"], nyt_id: data["_id"], subsection_name: data["subsection_name"], section_name: data["section_name"], document_type: data["document_type"], keywords: data["keywords"], source: data["source"], print_page: data["print_page"], abstract: data["abstract"], snippet: data["snippet"], web_url: data["web_url"], lead_paragraph: data["lead_paragraph"], headline: data["headline"]["main"], pub_date: data["pub_date"], word_count: data["word_count"] )
end


# keyword: data["keywords"][0]["value"],