class UserId < ActiveRecord::Migration
  def change
    add_reference :songs, :user
  end
end
