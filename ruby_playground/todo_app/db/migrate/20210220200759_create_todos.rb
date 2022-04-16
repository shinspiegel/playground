class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :is_complete
      t.belongs_to :user

      t.timestamps
    end
  end
end
