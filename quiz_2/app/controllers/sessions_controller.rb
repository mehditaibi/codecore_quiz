class SessionsController < ApplicationController

    def new
        
    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate(params[:password])
            
            session[:user_id] = user.id
            flash[:primary] = "Logged in"
            redirect_to root_path
            

        else
            flash[:primary] = "Email or password is incorrect"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:primary] = "Logged out"
        redirect_to root_path
    end
end
