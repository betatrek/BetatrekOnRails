# == Schema Information
#
# Table name: assets
#
#  id             :integer         not null, primary key
#  ticker         :string(255)
#  evaluation     :float
#  volume         :integer
#  market_cap     :integer
#  beta           :float
#  date           :date
#  open           :float
#  high           :float
#  low            :float
#  close          :float
#  adjusted_close :float
#

class Asset < ActiveRecord::Base
	default_value_for :date do
    	Date.today
  	end
end
