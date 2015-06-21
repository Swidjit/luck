class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if resource.save
      @user_scores = Score.where(:session_id => params[:user][:session_id])
      @user_scores.each do |o|
        o.user_id = resource.id
        o.session_id = nil
        o.save
      end
    end

  end

  def new
    super
  end

  def destroy
    super
  end
end