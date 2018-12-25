class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.where(id: params[:user_id]).first || nil
    @events = filter_events(params)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  def new
    @event = Event.new
    get_users
  end

  def edit
    get_users
  end

  def create
    @event = current_user.owned_events.new(event_params)
    params[:event][:users].each do |user_id|
      unless user_id.empty?
        @event.event_users.build(user_id: user_id)
      end
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:event][:users].each do |user_id|
      # if user_id && !@event.users.pluck(:id).include?(user_id.to_i)
      unless user_id.empty?
        @event.event_users.where(user_id: user_id).first_or_initialize
      end
    end
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        get_users
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def date_wise_event
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date)
    end

    def get_users
      @users = User.where.not(id: current_user.id)
      @event_user = @event.event_users.build
    end

    def filter_events(params)
      if params[:date]
        @events = @user.owned_events.where('DATE(start_date) = ?', params[:date].to_date)
      else
        @events = Event.all
      end
    end
end
