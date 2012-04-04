# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  email             :string(255)
#  password_digest   :string(255)
#  admin             :boolean
#  uid               :string(255)
#  confirmation_code :string(255)
#  country           :string(255)
#  state             :string(255)
#  remember_token    :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :country, :state
	has_secure_password
end
