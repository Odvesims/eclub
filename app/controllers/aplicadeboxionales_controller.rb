class AplicadeboxionalesController < ApplicationController
	def index
		xuser = current_user
		if xuser != nil
			@signedIn = true
			if signed_granted?(xuser.id, 'datadeboxionales', 'I')
				@aplicadeboxionales = Aplicadeboxionale.where("id > 1").paginate(page: params[:page], :per_page => 30)
				respond_to do |format|
					format.html # index.html.erb
					format.json { render json: @deboxionals }
				end
			end
		else
			@signedIn = false
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @deboxionals }
			end
		end
	end

    #GET /userdefaults/1
    #GET /userdefaults/1.json
	def show
		@user= User.find(params[:id])	
		@usersroles = Usersrol.all
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @user}
		end
	end
  
	def new
		@deboxional= Aplicadeboxionale.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @deboxional}
		end
	end

	def edit
		xuser = current_user
		if xuser != nil
			@signedIn = true
			@deboxional= Aplicadeboxionale.find(params[:id])
		else
			@signedIn = false
			@deboxional= Aplicadeboxionale.find(1)
			respond_to do |format|
				format.html { redirect_to :action => :show, :id=>@deboxional.id  }
				format.json { render json: @deboxional, status: :created, location: @deboxional }
			end
		end
	end
  
	def create
		@deboxional= Aplicadeboxionale.new(params[:aplicadeboxionale])
		respond_to do |format|
			if @deboxional.save
				format.html { redirect_to :action => :show, :id=>@deboxional.id  }
				format.json { render json: @deboxional, status: :created, location: @deboxional }
			else
				format.html { render action: "new" }
				format.json { render json: @deboxional.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@deboxional= Aplicadeboxionale.find(params[:id])
		respond_to do |format|
			if @deboxional.update_attributes(params[:aplicadeboxionale])
				format.html { redirect_to :action => :edit, :id=>@deboxional.id }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @deboxional.errors, status: :unprocessable_entity }
			end
		end
	end
 
=begin 
	def destroy  
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end
=end

end
