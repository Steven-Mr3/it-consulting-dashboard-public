class CreateAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :alerts do |t|
      t.string :alert_type
      t.text :message
      t.integer :severity
      t.boolean :resolved
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
