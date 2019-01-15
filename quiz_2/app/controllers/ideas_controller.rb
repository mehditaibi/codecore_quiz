class IdeasController < ApplicationController

    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            redirect_to idea_path(@idea.id)
        else 
            render :new
        end
    end

    def show
        @reviews = @idea.reviews.order(created_at: :desc)
        @review = Review.new
    end

    def index
        @ideas = Idea.all
    end

    def destroy
        @idea.destroy
        redirect_to '/'
    end

    def edit
    end

    def update
        if @idea.update idea_params
            redirect_to ideas_path(@idea.id)
        else
            render :edit           
        end
    end

    private
    def  idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        @idea = Idea.find params[:id]        
    end
    
    def authorize_user!
        
        unless can?(:crud, @idea)
            flash[:danger] = "Access Denied"
            redirect_to idea_path(@idea)
        end
    end

end
