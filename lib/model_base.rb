module ModelBase
  def owned_by?(user)
  	if self.class.method_defined? :user
  	  self.user && self.user.id == user.id
  	end
  	false
  end
end