class Gear < ActiveRecord::Base
  attr_accessible :alpha_code, :cat_eng, :cat_ind, :fao_code, :name, :num_code, :sub_cat_eng, :sub_cat_ind, :type_eng, :type_ind

  has_many :landings, dependent: :destroy
end
