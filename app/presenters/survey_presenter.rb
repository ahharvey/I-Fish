class SurveyPresenter < BasePresenter
  presents :survey

  def fishery
    html = best_in_place survey, :fishery_id, type: :select, collection: Fishery.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-fishery', display_as: :formatted_fishery, inner_class: 'span10'
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-fishery'
      end
    end
  end

  def desa
    html = best_in_place survey, :desa_id, type: :select, collection: Desa.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-desa', display_as: :formatted_desa, inner_class: 'span10'
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-desa'
      end
    end
  end

  def date
    html = best_in_place survey, :date_published, type: :date, activator: '#edit-survey-date', display_as: :formatted_date, inner_class: 'span6'
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-date'
      end
    end
  end

  def start_time
    html = best_in_place survey, :start_time_input, type: :input, activator: '#edit-survey-start-time', nil: '--', inner_class: 'span6', display_as: :formatted_start_time
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-start-time'
      end
    end
  end

  def end_time
    html = best_in_place survey, :end_time_input, type: :input, activator: '#edit-survey-end-time', nil: '--', inner_class: 'span6', display_as: :formatted_end_time
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-end-time'
      end
    end
  end

  def admin
    html = best_in_place survey, :admin_id, type: :select, collection: Admin.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-admin', display_as: :formatted_admin, inner_class: 'span10' 
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-admin'
      end
    end

  end

  def landing_enumerator
    html = best_in_place survey, :landing_enumerator_id, type: :select, collection: Admin.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-landing-enumerator', display_as: :formatted_landing_enumerator, inner_class: 'span10' 
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-landing-enumerator'
      end
    end

  end

  def catch_measurer
    html = best_in_place survey, :catch_measurer_id, type: :select, collection: Admin.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-catch-measurer', display_as: :formatted_catch_measurer, inner_class: 'span10'
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-catch-measurer'
      end
    end
  end

  def catch_scribe
    html = best_in_place survey, :catch_scribe_id, type: :select, collection: Admin.all.map { |u| [u.id, u.name] }, activator: '#edit-survey-catch-scribe', display_as: :formatted_catch_scribe, inner_class: 'span10'
    html += ' '
    html += content_tag :small do
      content_tag :em do
        link_to 'edit', '#', id: 'edit-survey-catch-scribe'
      end
    end
  end
end