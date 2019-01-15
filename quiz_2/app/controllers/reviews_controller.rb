class ReviewsController < ApplicationController
    before_action :find_review, only: [:destroy]
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:destroy]
    

    def create 

        @review = Review.new review_params
        @idea = Idea.find params[:idea_id]
        @review.idea = @idea
        @review.user = current_user

        if @review.save
            redirect_to idea_path(@idea.id)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render idea_path(@idea)
       end

    end

    def destroy
        @review.destroy 
        redirect_to idea_path(@review.idea)
    end

    private
    def review_params
        params.require(:review).permit(:body)
    end

    def find_review
        @review = Review.find(params[:id])
    end

    def authorize_user!
        unless can?(:crud, @review)
            flash[:danger] = "Access Denied"
            redirect_to idea_path(@review.idea)
        end
    end
end
