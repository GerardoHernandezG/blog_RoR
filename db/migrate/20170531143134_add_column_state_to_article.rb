class AddColumnStateToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :aasm_state, :string, default: "in_draft"
  end
end
