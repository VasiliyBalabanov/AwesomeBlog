class SetAdmin < ActiveRecord::Migration
  def up
    execute "UPDATE Users SET is_admin = 1 WHERE id = 1"
  end

  def down
  end
end
