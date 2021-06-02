class UsersController < ApplicationController
    
    
    def new

    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def create
        @user = User.new(user_params(params))
        if @user && @user.save
            redirect_to user_url(@user)
        else
            redirect_to new_user_url, status: 422
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user
            @user.destroy
        end
        redirect_to new_user_url
    end


    def user_params(params)
        params.require(:user).permit(:email, :password)
    end








end