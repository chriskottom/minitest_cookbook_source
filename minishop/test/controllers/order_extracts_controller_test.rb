require "test_helper"

describe OrderExtractsController do
  include ActiveJob::TestHelper

  before do
    login_as(users(:lumbergh))
    request.env["HTTP_REFERER"] = orders_url
  end
  
  describe "POST create" do
    it "redirects to the previous page" do
      post :create
      assert_redirected_to :back
      expect(flash[:notice]).must_equal 'Your extract is now being generated and sent.'
    end

    it "enqueues one job to process the import" do
      assert_enqueued_with(job: OrderExtractJob, args: []) do
        post :create
      end
    end
  end
end
