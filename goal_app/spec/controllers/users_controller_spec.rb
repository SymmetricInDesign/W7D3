require "rails_helper"

RSpec.describe UsersController, type: :controller do

    describe "GET#new" do
        it "should render the new user form" do 
            get :new
            expect(response).to render_template("new")
            expect(response).to have_http_status(200)
        end
    end

    describe "GET#show" do
        it "should render the user with the given id" do
            get :show

            expect(response).to render_template("show") # view will render user's page
            expect(response).to have_http_status(200)
        end
    end

    describe "POST#create" do
        let(:valid_params) {{ user: { email: "raph@raph.com", password: "atleast6"}}}
        let(:invalid_params) {{ user: { email: "roph@roph.com", password: "not6"}}}

        context "with valid params" do
            

            it "should save a new user to the database" do
                post :create, params: valid_params
                expect(User.last.email).to eq(valid_params[:user][:email])
            end

            it "redirects to user_url" do
                post :create, params: valid_params
                expect(response).to have_http_status(302)
                expect(response).to redirect_to(user_url(User.last.id))
            end
        end

        context "with invalid params" do

            it "should not save a user to the database" do
                post :create, params: invalid_params
                expect(User.last.email).not_to eq(invalid_params[:user][:email])
            end

            it "should redirect to the new_user_url" do
                post :create, params: invalid_params
                expect(response).to have_http_status(422)
                expect(response).to redirect_to(new_user_url)
            end
        end
    end

    describe "DELETE#destroy" do
        let!(:test_user) { FactoryBot.create(:user) }
        before :each do
            delete :destroy, params: { id: test_user.id }
        end

        it "destroys the user" do
            expect(User.exists?(test_user.id)).to be false
        end

        it "redirects to new_user_url" do
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_user_url)
        end

    end
end