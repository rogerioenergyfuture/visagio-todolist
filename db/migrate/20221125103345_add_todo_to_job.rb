class AddTodoToJob < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :todo
  end
end
