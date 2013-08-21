collection @logbooks, :object_root => false

attributes :id, :date

child :approver => :approved_by do
  attributes :id, :name
  glue :office do
    attributes :name => :office
  end
end

child :user => :fisherman do
  attributes :id, :name
end

glue :fishery do
  attributes :name => :fishery
end

