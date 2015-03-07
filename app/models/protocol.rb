class Protocol < ActiveRecord::Base
  has_many :documents, as: :documentable
  has_many :fisheries
  has_paper_trail
end
