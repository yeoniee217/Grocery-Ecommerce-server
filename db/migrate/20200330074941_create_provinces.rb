class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbrev
      t.decimal :GST_rate
      t.decimal :PST_rate
      t.decimal :HST_rate

      t.timestamps
    end
  end
end
