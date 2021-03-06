module OrangeBase

  def set_route
    @route = routes(:route_one_one)
    @route.update! end: @route.start + 5.hours
    @route.planning.update! date: 10.days.from_now
    @vehicle = @route.vehicle_usage.vehicle
    @vehicle.update! orange_id: "325000749"
  end

  def add_orange_credentials customer
    customer.enable_orange = true
    customer.orange_user = "orange_user"
    customer.orange_password = "orange_password"
    customer.save!
    customer
  end

  def with_stubs names, &block
    begin
      stubs = []
      names.each do |name|
        case name
          when :auth
            expected_response = File.read(Rails.root.join("test/web_mocks/orange/blank.xml")).strip
            api_url = URI.parse Mapotempo::Application.config.devices.orange.api_url
            url = "%s://%s:%s@%s%s" % [ api_url.scheme, @customer.orange_user, @customer.orange_password, api_url.host, "/pnd/index.php" ]
            stubs << stub_request(:get, url).with(query: hash_including({ })).to_return(status: 200, body: expected_response)
          when :send
            expected_response = File.read(Rails.root.join("test/web_mocks/orange/blank.xml")).strip
            api_url = URI.parse Mapotempo::Application.config.devices.orange.api_url
            url = "%s://%s:%s@%s%s" % [ api_url.scheme, @customer.orange_user, @customer.orange_password, api_url.host, "/pnd/index.php" ]
            stubs << stub_request(:post, url).with(query: hash_including({ })).to_return(status: 200, body: expected_response)
          when :get_vehicles
            expected_response = File.read(Rails.root.join("test/web_mocks/orange/get_vehicles.xml")).strip
            api_url = URI.parse Mapotempo::Application.config.devices.orange.api_url
            url = "%s://%s:%s@%s%s" % [ api_url.scheme, @customer.orange_user, @customer.orange_password, api_url.host, "/webservices/getvehicles.php" ]
            stubs << stub_request(:get, url).with(body: { ext: "xml" }).to_return(status: 200, body: expected_response)
          when :vehicles_pos
            expected_response = File.read(Rails.root.join("test/web_mocks/orange/get_vehicles_pos.xml")).strip
            api_url = URI.parse Mapotempo::Application.config.devices.orange.api_url
            url = "%s://%s:%s@%s%s" % [ api_url.scheme, @customer.orange_user, @customer.orange_password, api_url.host, "/webservices/getpositions.php" ]
            stubs << stub_request(:get, url).with(body: { ext: "xml" }).to_return(status: 200, body: expected_response)
        end
      end
      yield
    ensure
      stubs.each do |name|
        remove_request_stub name
      end
    end
  end

end
