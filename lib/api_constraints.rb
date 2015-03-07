class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end
    
  def matches?(req)
    
    
    if req.query_parameters.has_key?("v")
      req.query_parameters['v'].to_s == @version.to_s
    else
      @default
    end
  end
end