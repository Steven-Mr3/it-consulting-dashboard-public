class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :priority
      t.integer :category
      t.references :client, null: false, foreign_key: true
      t.integer :assigned_to_id
      t.integer :created_by_id
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
