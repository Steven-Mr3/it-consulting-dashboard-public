class CreateKbArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :kb_articles do |t|
      t.string :title
      t.text :content
      t.string :category
      t.integer :views_count
      t.integer :helpful_count
      t.integer :unhelpful_count

      t.timestamps
    end
  end
end
