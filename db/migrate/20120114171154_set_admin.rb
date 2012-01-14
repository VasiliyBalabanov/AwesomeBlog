class SetAdmin < ActiveRecord::Migration
  def up
    execute "UPDATE users SET is_admin = 1 WHERE id = 1"
  end

  def down
  end
end
