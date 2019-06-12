class CreateIndexes < ActiveRecord::Migration[5.2]
  def change
    create_table(:indexes, id: :int, unsigned: true, options: 'DEFAULT CHARSET=utf8') do |t|
      t.string    :code
      t.string    :name
      t.timestamps
    end
  end
end
