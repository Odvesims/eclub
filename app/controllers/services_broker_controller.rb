class ServicesBrokerController < ApplicationController
  def show
    call_service(params)
  end

  def create
    call_service(params)
  end

  private
  
    def call_service(parameters)
      begin
        _SERVICE = (parameters[:service].to_s + "Service").constantize
        if current_user != nil
          parameters[:default_conference] = current_user.default_conference
          parameters[:default_camporee] = current_user.default_camporee
        end
        response = _SERVICE.new(parameters).execute
      rescue Exception => e
        response = { option: parameters[:service].to_s, valid: false, data: {}, message: "#{e.message}" }
      end
      respond_to do |format|
        format.json do
          render json: response.to_json
        end
      end
    end
end