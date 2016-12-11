# == Schema Information
#
# Table name: company_positions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  company_id :integer
#  status     :string
#

class CompanyPosition < ApplicationRecord
	belongs_to :company
	belongs_to :user
end
