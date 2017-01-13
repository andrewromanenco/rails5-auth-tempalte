class User < ApplicationRecord
  has_many :o_auths

  def self.find_or_create_by_oauth(oauth_service)
    user = User.joins(:o_auths).where(o_auths: {remote_id: oauth_service.user_id}).first
    return user if user
    user = User.create(full_name: oauth_service.full_name)
    user.o_auths.create(remote_id: oauth_service.user_id)
    user.save
    user
  end
end
