class ActivityPresenter < SimpleDelegator
	
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		content_tag(:div, class: "row") do
			div_for(activity, class: "") do
				content_tag(:div, class: "media") do
					html = link_to(activity.ownable, class: "pull-left") do
						image_tag(activity.ownable.avatar_url(:thumb), width: "50", height: "50", class: "media-object") if activity.ownable.avatar?
					end
					html += content_tag(:div, class: "media-body") do
						link_to(activity.ownable.name, activity.ownable) + " " + render_partial 
					end
				end
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