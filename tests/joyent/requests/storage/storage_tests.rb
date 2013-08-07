Shindo.tests('Fog::Storage[:joyent]', ['joyent', 'joyent-storage']) do

  SERVICE_PARAMS = {
    :joyent_username => "kevin",
    :joyent_manta_url => "https://us-east1.manta.joyent.com",
    :joyent_keyfile => "/Users/kevin/.ssh/test_rsa",
    :ssl_verify_peer => false
  }

  tests('#service initialization') do
    test "valid params return manta client instance" do
      @service = Fog::Storage::Joyent.new(SERVICE_PARAMS)

      test "connection is instance of MantaClient" do
        returns(MantaClient) do
          @service.connection.class
        end
      end
    end

    raises ArgumentError, "invalid key raises ArgumentError" do
      @service = Fog::Storage::Joyent.new(
        SERVICE_PARAMS.merge(:joyent_keyfile => "some-bogus-file")
      )
    end

    raises ArgumentError, "invalid manta url raises ArgumentError" do
      @service = Fog::Storage::Joyent.new(
        SERVICE_PARAMS.merge(:joyent_manta_url => "google.com")
      )
    end
  end

end
