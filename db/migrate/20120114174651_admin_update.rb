class AdminUpdate < ActiveRecord::Migration
  def up
        execute "UPDATE Users SET is_admin = 0 WHERE id > 1"
  end

  def down
  end
end
