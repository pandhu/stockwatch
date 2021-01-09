class CreateTableIssuerIndexes < ActiveRecord::Migration[5.2]
  def change
    create_table(:issuer_indexes, id: :int, unsigned: true, options: 'DEFAULT CHARSET=utf8') do |t|
      t.integer    :issuer_id
      t.integer    :index_id
      t.timestamps
    end
  end
end
