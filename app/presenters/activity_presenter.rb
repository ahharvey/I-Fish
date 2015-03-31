class ActivityPresenter < SimpleDelegator
	
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		div_for activity, class: "media feed-item" do
      contents = content_tag :div, class: "media-left" do 
        link_to activity.ownable, title: activity.ownable.name do
          if activity.ownable.avatar?
            image_tag activity.ownable.avatar_url(:thumb), class: "media-object img-circle", size: '40x40', alt: activity.ownable.name
          else
            content_tag :div, class: "media-object img-circle avatar" do
              "#{activity.ownable.firstname[0].capitalize}#{activity.ownable.lastname[0].capitalize}"
            end
          end
        end
      end
      contents += content_tag :div, class: "media-body" do
        html = content_tag :b, class: "media-heading" do 
          link_to activity.ownable.name, activity.ownable
        end 
        html += render_partial
      end
    end 
	end

	def render_partial
		locals = { activity: activity, presenter: self }
		locals[activity.trackable_type.underscore.to_sym] = activity.trackable
		render partial_path, locals
	end


	def partial_path
		partial_paths.detect do |path|
			lookup_context.template_exists? path, nil, true
		end || raise("No partial found for activity in #{partial_paths}")
	end

	def partial_paths
		[
			"activities/#{activity.trackable_type.underscore}/#{activity.action}",
			"activities/#{activity.trackable_type.underscore}",
			"activities/activity"
		]
	end

end
