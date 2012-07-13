class User < ActiveRecord::Base
  attr_accessible :uid, :first_name, :last_name
end
