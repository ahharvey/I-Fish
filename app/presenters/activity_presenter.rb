class ActivityPresenter < SimpleDelegator
	
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		content_tag_for :li, @activity, class: cycle('odd', 'even') == 'even' ? 'timeline-inverted' : '' do
      
      render_timeline_badge + 
      render_timeline_panel

    end
  end
#        link_to activity.ownable, title: activity.ownable.name do
#          if activity.ownable.avatar?
#            image_tag activity.ownable.avatar_url(:thumb), class: "media-object img-circle", size: '40x40', alt: activity.ownable.name
#          else
#            content_tag :div, class: "media-object img-circle avatar" do
#              "#{activity.ownable.firstname[0].capitalize}#{activity.ownable.lastname[0].capitalize}"
#            end
#          end
#        end
#      end
#      contents += content_tag :div, class: "media-body" do
#        html = content_tag :b, class: "media-heading" do 
#          link_to activity.ownable.name, activity.ownable
#        end 
#        html += render_partial
#      end
#    end 
#	end#

#	<li>
#          <div class="timeline-badge primary">
#          	<a><i class="glyphicon glyphicon-record" rel="tooltip" title="11 hours ago via Twitter" id=""></i></a></div>
#          <div class="timeline-panel">
#            <div class="timeline-heading">
#              <img class="img-responsive" src="http://lorempixel.com/1600/500/sports/2" />
#              
#            </div>
#            <div class="timeline-body">
#              <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
#              
#            </div>
#            
#            <div class="timeline-footer">
#                <a><i class="glyphicon glyphicon-thumbs-up"></i></a>
#                <a><i class="glyphicon glyphicon-share"></i></a>
#                <a class="pull-right">Continuar Lendo</a>
#            </div>
#          </div>
#        </li>

	private 

	def render_timeline_badge 
		content_tag :div, class: 'timeline-badge primary' do 
    	content_tag :a do
    		#content_tag :i, '', class: 'glyphicon glyphicon-record', rel: 'tooltip', title: "#{time_ago_in_words( activity.created_at ).capitalize} ago."
    		content_tag :span, class: "fa-stack", rel: 'tooltip', title: "#{time_ago_in_words( activity.created_at ).capitalize} ago." do 
    			render_badge_icon
    		end
    	end
    end
	end

	def render_badge_icon
		
		format_for_action

		background = content_tag :i, '', class: "fa fa-circle fa-stack-2x #{@bg_color}"
    foreground = content_tag :i, '', class: "fa fa-stack-1x fa-inverse #{@icon}"
    
    background + foreground
	end

	def format_for_action
		if @activity.action == 'create'
			@bg_color 	= 'text-primary'
			@icon 			= 'fa-plus'
		elsif @activity.action == 'destroy'
			@bg_color 	= 'text-muted'
			@icon 			= 'fa-trash-o'
		elsif @activity.action == 'update'
			@bg_color 	= 'text-primary'
			@icon 			= 'fa-pencil'
		elsif @activity.action == 'approve'
			@bg_color 	= 'text-success'
			@icon 			= 'fa-check'
		elsif @activity.action == 'reject'
			@bg_color 	= 'text-danger'
			@icon 			= 'fa-ban'
		elsif @activity.action == 'pend'
			@bg_color 	= 'text-warning'
			@icon 			= 'fa-exclamation'
		end
	end

	def render_timeline_panel
		content_tag :div, class: 'timeline-panel' do

			render_timeline_header + 
			render_timeline_body + 
			render_timeline_footer
    	
    end
	end

	def render_timeline_header 
		content_tag :div, class: 'timeline-heading' do

    end
	end

	def render_timeline_body 
		content_tag :div, class: 'timeline-body' do
  		content_tag :div, class: 'row' do
    		body_inner = content_tag :div, class: 'col-xs-2' do
      		render_avatar
      	end
      	body_inner += content_tag :div, class: 'col-xs-10' do
      		render_content
	      end
	    end
  	end
	end

	def render_timeline_footer
		content_tag :div, class: 'timeline-footer' do
  		content_tag :p, class: 'text-right' do
  			link_to @activity.trackable, title: t(:open) do
  				content_tag :i, '', class: 'fa fa-arrow-circle-o-right fa-lg'
  			end
  		end
  	end
	end

	def render_partial
		locals = { activity: @activity, presenter: self }
		locals[@activity.trackable_type.underscore.to_sym] = @activity.trackable
		render partial_path, locals
	end

	def render_avatar
		link_to @activity.ownable, title: @activity.ownable.name do
      if @activity.ownable.avatar?
        image_tag @activity.ownable.avatar_url(:thumb), class: "media-object img-circle", size: '40x40', alt: @activity.ownable.name
      else
        content_tag :div, class: "media-object img-circle avatar" do
          "#{@activity.ownable.firstname[0].capitalize}#{@activity.ownable.lastname[0].capitalize}"
        end
      end
    end
	end

	def render_content
		html = content_tag :b, class: "media-heading" do 
      link_to activity.ownable.name.capitalize, activity.ownable
    end 
    html += render_partial
	end


	def partial_path
		partial_paths.detect do |path|
			lookup_context.template_exists? path, nil, true
		end || raise("No partial found for activity in #{partial_paths}")
	end

	def partial_paths
		[
			"activities/#{@activity.trackable_type.underscore}/#{@activity.action}",
			"activities/#{@activity.trackable_type.underscore}",
			"activities/activity"
		]
	end

end
