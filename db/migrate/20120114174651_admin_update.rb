class AdminUpdate < ActiveRecord::Migration
  def up
        execute "UPDATE users SET is_admin = 0 WHERE id > 1"
  end

  def down
  end
end
