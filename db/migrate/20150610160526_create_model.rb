class CreateModel < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name
      t.boolean :is_complete
    end
  end
end
