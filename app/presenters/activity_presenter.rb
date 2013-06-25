class ActivityPresenter < SimpleDelegator
	
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		div_for activity, class: "media feed-item" do
      contents = link_to activity.ownable, class: "pull-left", title: activity.ownable.name do
        image_tag activity.ownable.avatar_url(:thumb), class: "media-object", size: '50x50', alt: activity.ownable.name 
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