class UpdatePasswordInUsers < ActiveRecord::Migration
  def up
    rename_column(:users, :password_hash, :password_digest)
    remove_column(:users, :password_salt)
  end

  def down
  end
end
