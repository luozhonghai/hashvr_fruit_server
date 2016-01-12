class ChangeUserDefaultScore < ActiveRecord::Migration
  def change
    change_column :users, :classic_score, :integer, :default => 0
  end
end
