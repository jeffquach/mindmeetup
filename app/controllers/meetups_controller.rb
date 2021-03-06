class MeetupsController < ApplicationController
	before_filter :require_login
	before_action :find_meetup, only: [:edit,:update,:destroy]
	respond_to :html, :js

	def new
		@meetup = current_user.meetups.build
		@second_user_id = params[:second_user_id]
		Rails.logger.info "The second users id is: #{@second_user_id}"
	end

	def create
		@meetup = current_user.meetups.build(meetup_params)

		@meetup.user = current_user
		if @meetup.save
			flash[:success] = "You successfully created an event!"
			@meetup.invitees.create(user_id: current_user.id,response: "yes")
			@meetup.invitees.create(user_id: params[:second_user_id], response: "no_reply")
			redirect_to @meetup
		else
			render :new
		end
	end

	def index
		# @meetups = current_user.meetups
		@meetups = Meetup.where('user_id = ? AND end_time > ?', current_user.id, Time.now).order('created_at DESC')
	end



	def edit
	end

	def update
		if @meetup.update_attributes(meetup_params)
			flash[:info] = "You have successfully updated your meetup"
			redirect_to meetup_path(@meetup)
		else
			render :edit
		end
	end


	def show
		@meetup = Meetup.find(params[:id])
		@comments = @meetup.comments
		@comment = Comment.new
		respond_with @comment
	end

	def destroy
		if @meetup.destroy
			flash[:danger] = "You deleted your meetup!"
			redirect_to meetups_path
		end
	end

	private
	def meetup_params
		params.require(:meetup).permit(:title,:studying,:description,:start_time,:end_time,:number_of_people)
	end

	def find_meetup
		@meetup = Meetup.find(params[:id])
	end
	
end