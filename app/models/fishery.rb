# == Schema Information
#
# Table name: fisheries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  code         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  protocol_id  :integer
#  draft_id     :integer
#  published_at :datetime
#  trashed_at   :datetime
#

class Fishery < ApplicationRecord

  has_paper_trail
  has_drafts
  include HasBaitRatio

  has_many :documents, as: :documentable

  has_many :surveys, dependent: :destroy
  has_many :landings, through: :surveys
  has_many :catches, through: :landings
  has_many :gears, through: :landings
  has_many :fishes, through: :landings
  has_many :engines, through: :landings
  has_many :logbooks
  has_many :logged_days, through: :logbook
  has_many :provinces, through: :surveys
  has_many :districts, through: :surveys


  has_many :vessels
  has_many :companies, through: :vessels
  has_many :unloadings, through: :vessels
  has_many :unloading_catches, through: :unloadings
  has_many :bait_loadings, through: :vessels

  belongs_to :protocol
  scope :default, -> { order('fisheries.name ASC') }

  has_and_belongs_to_many :target_fishes,
    join_table: "target_fishes",
    foreign_key: :fishery_id,
    association_foreign_key:  :fish_id,
    class_name: "Fish",
    before_add: :validates_target_fishes
  has_and_belongs_to_many :used_gears, class_name: "Gear", before_add: :validates_used_gears
  has_and_belongs_to_many :member_companies,
    join_table: "fisheries_companies",
    foreign_key: :fishery_id,
    association_foreign_key:  :company_id,
    class_name: "Company",
    before_add: :validates_member_companies
  has_and_belongs_to_many :member_offices, class_name: "Office", before_add: :validates_member_offices

  has_and_belongs_to_many :bait_fishes,
    join_table: "bait_fishes",
    foreign_key: :fishery_id,
    association_foreign_key:  :fish_id,
    class_name: "Fish",
    before_add: :validates_bait_fishes


  validates :name,
  	presence: true
  validates :code,
  	presence: true



  def approved_surveys
    self.surveys.where( review_state: 'approved' )
  end

  def approved_survey_ids
    Rails.cache.fetch(["approved_survey_ids", self], expires_in: 5.minutes) do
      self.surveys.where( review_state: 'approved' ).map(&:id)
    end
  end

  def approved_landings
    Landing.where(survey_id: self.approved_survey_ids )
  end

  def approved_landing_ids
    Rails.cache.fetch(["approved_landing_ids", self], expires_in: 5.minutes) do
      Landing.where(survey_id: self.approved_survey_ids ).map(&:id)
    end
  end

  def approved_catches
    Catch.includes(:landing, :survey).where(landing_id: self.approved_landing_ids )
  end

  def category_name
    target_fishes.try(:scientific_name)
  end

  private

  def validates_target_fishes(fish)
    raise ActiveRecord::Rollback if self.target_fishes.include? fish
  end

  def validates_bait_fishes(fish)
    raise ActiveRecord::Rollback if self.bait_fishes.include? fish
  end

  def validates_used_gears(gear)
    raise ActiveRecord::Rollback if self.used_gears.include? gear
  end

  def validates_member_companies(company)
    raise ActiveRecord::Rollback if self.member_companies.include? company
  end

  def validates_member_offices(office)
    raise ActiveRecord::Rollback if self.member_offices.include? office
  end
end
