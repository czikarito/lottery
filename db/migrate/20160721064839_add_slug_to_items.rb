class AddSlugToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :slug, :string, unique: true
  end
end
