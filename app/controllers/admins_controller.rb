class AdminsController < InheritedResources::Base
  load_and_authorize_resource
  actions :index, :show, :edit, :update
  respond_to :html, :xml, :json

  def show
    respond_to do |format|
      @admin = Admin.find(params[:id])
      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
      @date_to = DateTime.now.strftime("%d/%m/%Y")

      @chart = @admin.surveys.count(:group=>"date_trunc('month', date_published)", order: "date_trunc('month', date_published)")

      format.html { render }

      format.json do
        col_headers = []
        month_counts = []
        from = DateTime.parse(params[:date_from])
        to = DateTime.parse(params[:date_to])
        (from.year..to.year).each do |y|
          start_month = (from.year == y) ? from.month : 1
          end_month = (to.year == y) ? to.month : 12

          (start_month..end_month).each do |m|
            col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
            month_counts.push surveys.select{ |s| s.date_published.year == y && s.date_published.month == m}.count
          end
        end
        render json: {:col_headers => col_headers, :month_counts => month_counts }
      end
    end
  end


end