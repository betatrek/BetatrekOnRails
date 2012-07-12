# == Schema Information
#
# Table name: assets
#
#  id         :integer         not null, primary key
#  ticker     :string(255)
#  evaluation :float
#  volume     :integer
#  market_cap :integer
#  beta       :float
#  date       :date
#

class Asset < ActiveRecord::Base
	default_value_for :day do
    	Date.today
  	end
end
