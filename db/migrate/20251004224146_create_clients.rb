class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact_email
      t.string :contact_phone
      t.integer :sla_response_time
      t.date :contract_start
      t.date :contract_end

      t.timestamps
    end
  end
end
