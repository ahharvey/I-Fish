# == Schema Information
#
# Table name: fishes
#
#  id              :integer          not null, primary key
#  order           :string(255)
#  family          :string(255)
#  scientific_name :string(255)
#  fishbase_name   :string(255)
#  english_name    :string(255)
#  indonesia_name  :string(255)
#  code            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  a               :integer
#  b               :integer
#  mat             :integer
#  max             :integer
#  opt             :integer
#  threatened      :boolean          default(FALSE)
#

class Fish < ActiveRecord::Base
  
  has_paper_trail

  # default_scope order('fishes.order ASC, family ASC, scientific_name ASC')
  default_scope -> { order('fishes.order ASC, family ASC, scientific_name ASC') }
  
  self.table_name = "fishes"

  attr_accessor :fishery_id

  has_many :catches, dependent: :destroy
  has_many :bait_landings
  has_many :secondary_bait_landings, class_name: 'BaitLanding', foreign_key: 'secondary_fish_id'
  has_many :logged_days
  has_many :landings
  has_many :provinces, through: :landings
  has_many :districts, through: :landings
  has_many :fisheries, through: :landings
  has_many :unloading_catches
  has_many :unloadings, through: :unloading_catches

  has_and_belongs_to_many :target_fisheries, 
    class_name: "Fishery",
    join_table: 'target_fishes', 
    uniq: true
  has_and_belongs_to_many :bait_fisheries, 
    class_name: "Fishery",
    join_table: 'bait_fishes', 
    uniq: true


  validates :code,
  	presence: true
  validates :order,
  	presence: true
  validates :family,
  	presence: true
  validates :scientific_name,
  	presence: true
  validates :english_name,
  	presence: true

    scope :default, -> { order('fishes.code ASC') }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      data = row.to_hash
      unless data['code'].nil?
        unless Fish.where(code: data['code']).any?
          Fish.create(
            code: data['code'],
            order: data['order'],
            family: data['family'],
            scientific_name: data['scientific_name'],
            english_name: data['english_name'],
            indonesia_name: data['indonesian_name']
            )
        end
      end
    end
  end
end
