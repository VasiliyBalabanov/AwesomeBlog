class UpdateAuthTokens < ActiveRecord::Migration
  def up
    User.all do |curr|
      if curr.auth_token
        begin
         curr[:auth_token] = SecureRandom.urlsafe_base64
        end while User.exists?(:auth_token => curr[:auth_token])
        curr.update_attributes(curr[:auth_token])
      end
    end
  end

  def down
  end
end
