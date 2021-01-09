class ChangeIndexesToIndices < ActiveRecord::Migration[5.2]
  def change
    rename_table :indexes, :indices
    rename_table :issuer_indexes, :issuer_indices
  end
end
