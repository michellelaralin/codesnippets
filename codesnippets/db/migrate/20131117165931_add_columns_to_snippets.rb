class AddColumnsToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :code, :string
    add_column :snippets, :user_id, :integer
  end
end
