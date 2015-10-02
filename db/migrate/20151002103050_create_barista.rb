class CreateBarista < ActiveRecord::Migration
  def change
    create_table :barista, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :store_id
      t.timestamps
    end

    add_index(:barista, :name)
  end
end
