class UsersController < ApplicationController
	def index
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'I')
			@users= User.all.order('name ASC')
			@usersroles = Usersrol.all
			@roles = Rol.all
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @users }
			end
		end	
	end

  # GET /userdefaults/1
  # GET /userdefaults/1.json
	def show
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'I')
			@user= User.find(params[:id])	
			@usersroles = Usersrol.all
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @user}
			end
		end
	end
  
	def new
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'N')
			@user= User.new
			@usersroles = Usersrol.all
			@roles = Rol.all
			respond_to do |format|
				format.html # new.html.erb
				format.json { render json: @user}
			end
		end	
	end

	def edit
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'E')
			@user= User.find(params[:id])
			@roles = Rol.all
			if @user.usersrol.count == 0
				@user.usersrol.new
			end
			@roles = Rol.all
			if params[:donde] == 'next'
				@user= User.find(params[:id])
				@user= @user.next(@user.id)
			else if params[:donde] == 'prev'
				@user= User.find(params[:id])
				@user= @user.prev(@user.id)
				end
			end
		end	
	end
  
	def create
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'N')
			@user= User.new(params[:user].to_enum.to_h)
			@usersroles = Usersrol.all
			@roles = Rol.all		
			respond_to do |format|
				if @user.save
					format.html { redirect_to :action => :edit, :id=>@user.id }
					format.json { render json: @user, status: :created, location: @user }
				else
					format.html { render action: "new" }
					format.json { render json: @user.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	def update
		xuser = current_user
		if signed_granted?(xuser.id, 'users', 'N')
			@user= User.find(params[:id])	
		
			@roles = Rol.all
			respond_to do |format|
				@user.update(params[:user].to_enum.to_h)
				if @user.save
					#UserMailer.welcome_email(@user).deliver
					format.html { redirect_to edit_user_path, notice: 'User was successfully updated.' }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @user.errors, status: :unprocessable_entity }
				end
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