require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

def xml_contains_tag_with_value(xml, xpath_to_tag, expected_value)
  contains = false
  paypal_request = Nokogiri::XML.parse(xml)
  paypal_request.xpath(xpath_to_tag).each do |tag|
    contains = true if tag.content == expected_value
  end
  contains
end

describe ActiveMerchant::Billing::PaypalAdaptivePaymentGateway do
  describe "build_adaptive_payment_details_request" do
    before do
        @gateway = ActiveMerchant::Billing::PaypalAdaptivePaymentGateway.new(:login => 'xxx', :password => 'xxx')
        @options = {:receiver_list => []}
    end

    it "should set reverseAllParallelPayementsOnError option to false by default" do
      @gateway.expects(:commit).with() do |action, xml|
        xml_contains_tag_with_value(xml, '//PayRequest/reverseAllParallelPaymentsOnError', 'false')
      end
      @gateway.pay(@options)
    end

    it "should respect the reverseAllParallelPaymentsOnError option to true" do
      @gateway.expects(:commit).with() do |action, xml|
        xml_contains_tag_with_value(xml, '//PayRequest/reverseAllParallelPaymentsOnError', 'true')
      end
      @options.merge!(:reverse_all_parallel_payments_on_error => true)
      @gateway.pay(@options)
    end

    it "should respect the reverseAllParallelPaymentsOnError option to false" do
      @gateway.expects(:commit).with() do |action, xml|
        xml_contains_tag_with_value(xml, '//PayRequest/reverseAllParallelPaymentsOnError', 'false')
      end
      @options.merge!(:reverse_all_parallel_payments_on_error => false)
      @gateway.pay(@options)
    end

  end
end