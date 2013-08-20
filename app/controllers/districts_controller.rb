class DistrictsController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
    @district = District.includes(:surveys, :landings).find(params[:id])

    if params.has_key?(:district)
      @start_date = Date.new(params[:district][:year].to_i).beginning_of_year
      @end_date = Date.new(params[:district][:year].to_i).end_of_year
      @test_date = params[:district][:year]
      @test_year = params[:district][:year]
      @year = params[:district][:year]
    else
      @test_date = "no date"
      @test_year = "no year"
      @year = Date.today.year
    #else
      @start_date = Date.today.beginning_of_year
      @end_date = Date.today.end_of_year
    end

    @quarters = []
    
    @date = Date.parse("1.1.#{@year}")  unless @date
    4.times do
      @quarters << [@date.beginning_of_quarter, @date.end_of_quarter]
      @date = @date.end_of_quarter+1.day
    end

    @landings = @district.landings.joins(:survey).where('surveys.date_published between ? AND ?', @start_date, @end_date )

    respond_to do |format|
      format.html { render }
      format.xml { render xml: @district.to_xml(include: { :surveys => {include: :landings}} ) }
      format.json { render json: @district.to_json(include: { :surveys => {include: :landings}} ) }
      format.csv { render text: @district.to_csv }
      format.js
      format.xls
      format.pdf {
        render :pdf => "District_#{@district.name}_#{DateTime.now.strftime('%Y#m')}", 
        :header => { 
          :font_size => '8', 
          :right => "District Report | I-Fish"
        }, 
        :footer => {
          :font_size => '8', 
          :right => '[page] of [toPage]' 
        }
      }
    end
  end
end
