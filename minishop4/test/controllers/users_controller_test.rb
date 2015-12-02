require "test_helper"

describe UsersController do
  before do
    login_as(users(:lumbergh))
  end

  let(:user) { users :milton }

  describe "GET index" do
    it "responds with :success" do
      get :index
      assigns(:users).wont_be_empty
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get :show, id: user.id
      assigns(:user).must_equal user
      must_respond_with :success
    end
  end

  describe "GET new" do
    it "responds with :success" do
      get :new
      assigns(:user).must_be_instance_of User
      assigns(:user).must_be :new_record?
      must_respond_with :success
      must_render_template partial: "_form"
    end
  end

  describe "GET edit" do
    it "responds with :success" do
      get :edit, id: user.id
      assigns(:user).must_be_instance_of User
      assigns(:user).must_be :persisted?
      must_respond_with :success
      must_render_template partial: "_form"
    end
  end

    describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {name: "pgibbons", password: "secret",
                       password_confirmation: "secret"} }

      it "saves the record and redirects to the detail page" do
        lambda {
          post :create, user: options
        }.must_change "User.count"
        assigns(:user).must_be_instance_of User
        assigns(:user).must_be :persisted?
        must_redirect_to assigns(:user)
        flash[:notice].must_equal "User #{ assigns(:user).name } was successfully created."
      end
    end

    describe "with invalid parameters" do
      let(:options) { {name: "pgibbons"} }

      it "does not save the record and re-displays the :new template" do
        lambda {
          post :create, user: options
        }.wont_change "User.count"
        assigns(:user).must_be_instance_of User
        assigns(:user).must_be :new_record?
        must_respond_with :success
        must_render_template :new
      end
    end
  end

  describe "PATCH update" do
    describe "with valid parameters" do
      let(:options)  { {name: "pgibbons"} }

      it "updates the record and redirects to the detail page" do
        put :update, id: user.id, user: options
        assigns(:user).id.must_equal user.id
        assigns(:user).name.wont_equal user.name
        must_redirect_to assigns(:user)
        flash[:notice].must_equal "User #{ assigns(:user).name } was successfully updated."
      end
    end

    describe "with invalid parameters" do
      let(:options)  { {name: "lumbergh"} }

      it "does not update the record and re-displays the :edit template" do
        put :update, id: user.id, user: options
        assigns(:user).errors.wont_be_empty
        must_respond_with :success
        must_render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the record and redirects to the index" do
      lambda { delete :destroy, id: user.id }.must_change "User.count", -1
      must_redirect_to users_url
      flash[:notice].must_equal "User #{ assigns(:user).name } was successfully destroyed."
    end
  end
end
