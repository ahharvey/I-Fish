class UserPresenter < BasePresenter
  presents :user

  def avatar
    if user.avatar?
      image_tag user.avatar_url(:thumb), title: user.name, class: 'img-circle', width: "30px", height: "30px"
    else
      content_tag :div,  class: 'img-circle' do
        "#{user.firstname[0].capitalize}#{user.lastname[0].capitalize}"
      end
    end
  end

  

private
  
end