class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :web_url
      t.string :snippet
      t.string :lead_paragraph
      t.string :abstract
      t.string :print_page
      t.string :source
      t.string :headline
      t.jsonb :keywords #, array: true, default: []
      t.date :pub_date
      t.string :document_type
      t.string :section_name
      t.string :subsection_name
      t.string :nyt_id
      t.string 
      t.integer :word_count
      t.string :slideshow_credits

      t.timestamps
    end
  end
end
