class AdminPresenter < BasePresenter
  presents :admin

  def avatar
    if admin.avatar?
      image_tag admin.avatar_url(:thumb), title: admin.name, class: 'img-circle'
    else
      content_tag :div,  class: 'img-circle avatar', style: 'width:30px;height:30px;' do
        "#{admin.firstname[0].capitalize}#{admin.lastname[0].capitalize}"
      end
    end
  end

  

private
  
end