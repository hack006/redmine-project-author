class AddProjectAuthorColumn < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :author_id
    end

    add_index :projects, :author_id
  end
end
