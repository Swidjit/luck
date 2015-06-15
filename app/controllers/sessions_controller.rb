class SessionsController < Devise::SessionsController
  def create
    super

    resource.session_id = sign_in_params[:session_id]
    resource.save
    @user_scores = Score.where(:session_id => resource.session_id)
    @user_scores.each do |o|
      o.user_id = resource.id
      o.session_id = nil
      o.save
    end
  end

  def new
    super
  end

  def destroy
    super
  end
end