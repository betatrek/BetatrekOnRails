# == Schema Information
#
# Table name: rsvps
#
#  id                :integer         not null, primary key
#  email             :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  uid               :string(255)
#  confirmed         :boolean         default(FALSE)
#  confirmation_code :string(255)
#

class Rsvp < ActiveRecord::Base
	attr_accessible :email

	# Assigns a unique ID and confirmation code to a new Rsvp
	before_save :create_uid
	before_save :create_confirmation_code

	VALID_EMAIL_REGEX = 
		/\A((\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|\."(\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|[(),:;<>@\\\[]|\]|\\\( |"|\\\))*"\.|\.)+(?<!\.)|"(\w|\d|[!#\$%&'*+\-\/=?^`{}|~]|[(),:;<>@\\\[]|\]|\\\( |"|\\\))*\")@[a-z0-9\-]{1,63}(?<!-)(\.[a-z0-9\-]{1,63}(?<!-))+\z/i
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	# Uses the UID as the URI for Rsvps
	def to_param
		uid
	end

	# Query if the Rsvp has been confirmed
	def confirmed?
		confirmed
	end

	# Checks the confirmation code sent against the stored code and update the Rsvp as
	# being confirmed if they match
	def confirm_email confirmation_code
		if (not confirmation_code.nil?) && confirmation_code == self.confirmation_code
			self.confirmed = true
			self.confirmation_code = nil
			save
		end
	end

	private

		# Creates a secure random UID for the RSVP if it doesn't already have one
		def create_uid
			self.uid ||= SecureRandom.urlsafe_base64
		end

		# Creates a random confirmation code for the RSVP unless it is already confirmed
		def create_confirmation_code
			self.confirmation_code = Digest::SHA1.hexdigest("salt #{Time.now.to_f}") unless confirmed?
		end
end
