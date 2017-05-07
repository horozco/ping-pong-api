class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :winner, index: true
      t.references :loser, index: true
      t.integer :winner_score
      t.integer :loser_score

      t.timestamps
    end
  end
end
