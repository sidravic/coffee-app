class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_index(:categories, :name)
  end
end
