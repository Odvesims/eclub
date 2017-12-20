class SorteosnumbersController < ApplicationController
	
	def index
	end
	
	def show
        consorcio = params[:cons]
        if consorcio == nil || consorcio == ''
            results = @numganadores = Hnumganaresult.where("consorcio_id = #{1} AND fecha BETWEEN '#{Time.zone.now.to_date}' AND '#{Time.zone.now.to_date}' and loteria_id = 13").all(:limit=>10, :order=> "fecha, loteria_id")
        end
        @results = results
        respond_to do |format|
            format.html 
            return
        end
    end

  
	def new
	end

	def edit
	end

	def update
	end

end