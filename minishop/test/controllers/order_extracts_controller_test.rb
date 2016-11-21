require "test_helper"

describe OrderExtractsController do
  include ActiveJob::TestHelper
  include SessionHelpers

  before do
    login_as(users(:lumbergh))
  end
  
  describe "POST create" do
    it "redirects to the previous page" do
      post order_extracts_url, env: { 'HTTP_REFERER' => orders_url }
      assert_redirected_to orders_url
      expect(flash[:notice]).must_equal 'Your extract is now being generated and sent.'
    end

    it "enqueues one job to process the import" do
      assert_enqueued_with(job: OrderExtractJob, args: []) do
        post order_extracts_url, env: { 'HTTP_REFERER' => orders_url }
      end
    end
  end
end
