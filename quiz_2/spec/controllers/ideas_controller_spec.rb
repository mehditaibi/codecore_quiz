require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    
    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe '#new' do
        context "with user signed in" do
            
            before do
                session[:user_id] = current_user.id
            end

            it "render the template new" do
                get(:new)
                expect(response).to(render_template(:new))
            end

            it "sets an instance variable with a new idea" do
                get(:new)
                expect(assigns(:idea)).to(be_a_new(Idea))
            end
        end

        context "without user signed in" do
            it "redirects the user to session new" do
                get(:new)

                expect(response).to redirect_to(new_session_path)
            end

            it "sets a danger flash message" do
                get(:new)

                expect(flash[:danger]).to be 
            end
        end
    end 

    describe '#create' do

        context "with user signed in" do
            
            before do
                session[:user_id] = current_user.id
            end

            context "with valid parameters" do
                
                def valid_request
                    post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
                end
                
                it "redirect to the show page of the idea" do
                    valid_request
                    idea = Idea.last
                    expect(response).to(redirect_to(idea_path(idea)))
                end

                it "creates a new idea" do 
                    count_before = Idea.count
                    valid_request
                    count_after = Idea.count
                    
                    expect(count_after).to eq(count_before + 1)
                end
            end

            context "with invalid parameters" do
                def invalid_request 
                    post(:create, params: {idea: FactoryBot.attributes_for(:idea, title: nil)})
                end

                it "render the new template" do
                    invalid_request
                    expect(response).to(render_template(:new))
                end

                it "doesn't create a new idea" do
                    count_before = Idea.count
                    invalid_request
                    count_after = Idea.count
                    
                    expect(count_after).to eq(count_before)
                end

                it "assigns an invalid idea as an instance variable" do
                    invalid_request
                    expect(assigns(:idea)).to be_a(Idea)
                    expect(assigns(:idea).valid?).to be(false)
                end
            end
        end

        context "without user signed in" do
            def valid_request
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
            end
            it "redirects to the new session" do
                valid_request

                expect(response).to redirect_to(new_session_path)
            end
        end
    end
end
