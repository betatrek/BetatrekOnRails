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
#  status            :string(255)
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :country, :state
	has_secure_password

	before_save :create_remember_token
	before_save :create_uid
	before_save :create_confirmation_code

	validates :name, length: { maximum: 50 }
	VALID_EMAIL_REGEX = 
		/\A((\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|\."(\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|[(),:;<>@\\\[]|\]|\\\( |"|\\\))*"\.|\.)+(?<!\.)|"(\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|[(),:;<>@\\\[]|\]|\\\( |"|\\\))*\")@[a-z0-9\-]{1,63}(?<!-)(\.[a-z0-9\-]{1,63}(?<!-))+\z/i 
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	scope :admin, where(admin: true)

	state_machine :status, initial: :confirmation_email_not_sent do
		event :confirm do
			transition :unconfirmed => :confirmed
		end
	end

	# Uses the UID as the URI for users
	def to_param
		uid
	end

	# Checks the confirmation code sent against the stored code and update the user as
	# being confirmed if they match
	def confirm_email confirmation_code
		if (not confirmation_code.nil?) && confirmation_code == self.confirmation_code
			confirm
			self.confirmation_code = nil
			save
		end
	end

	private

		# Creates a secure random remember token for the user if it doesn't already have one
		def create_remember_token
			self.remember_token ||= SecureRandom.urlsafe_base64
		end

		# Creates a secure random UID for the user if it doesn't already have one
		def create_uid
			self.uid ||= SecureRandom.urlsafe_base64
		end

		# Creates a random confirmation code for the user unless it is already confirmed
		def create_confirmation_code
			self.confirmation_code ||= Digest::SHA1.hexdigest("salt #{Time.now.to_f}") unless confirmed?
		end
end
