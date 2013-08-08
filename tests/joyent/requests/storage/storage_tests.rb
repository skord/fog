Shindo.tests('Fog::Storage[:joyent]', ['joyent', 'joyent-storage']) do

  tests('initialize') do
    test_params = {
      :joyent_username => "kevin@joyent.com",
      :joyent_manta_url => "https://us-east1.manta.joyent.com",
      :joyent_keyfile => "/Users/kevin/.ssh/test.key",
      :ssl_verify_peer => false
    }

    test "valid params return manta client instance" do
      @service = Fog::Storage::Joyent.new(test_params)

      test "connection is instance of MantaClient" do
        returns(MantaClient) do
          @service.connection.class
        end
      end
    end

    raises ArgumentError, "invalid key raises ArgumentError" do
      @service = Fog::Storage::Joyent.new(
        test_params.merge(:joyent_keyfile => "some-bogus-file")
      )
    end

    raises ArgumentError, "invalid manta url raises ArgumentError" do
      @service = Fog::Storage::Joyent.new(
        test_params.merge(:joyent_manta_url => "google.com")
      )
    end

    test "#user_path should = /<username>" do
      @service = Fog::Storage::Joyent.new(test_params)
      returns "/#{test_params[:joyent_username]}" do
        @service.user_path
      end
    end
  end




  tests "requests" do
    @service = Fog::Storage[:joyent]

    tests "list_directory" do
      res = @service.list_directory(@service.user_path + '/stor')

      returns(Excon::Response) do
        res.class
      end

      returns(Array, 'body is an array') do
        res[:body].class
      end
    end

    tests "put_object" do
      dir = File.join(@service.user_path, '/stor')
      f = 'ruby-manta.test.hello'

      res = @service.put_object(dir, f, 'hello ruby-manta')

      returns(Excon::Response) do
        res.class
      end

      returns(true, 'true for success put') do
        res[:body]
      end
    end

    tests "put_directory" do
      dir = File.join(@service.user_path, '/stor/ruby-manta.test')

      res = @service.put_directory(dir)

      returns(Excon::Response) do
        res.class
      end

      returns(true, 'true for success put') do
        res[:body]
      end
    end

    tests "get_object" do
      dir = File.join(@service.user_path, '/stor')
      f = 'ruby-manta.test.hello'
      res = @service.get_object(dir, f)

      returns(Excon::Response) do
        res.class
      end

      returns('hello ruby-manta', 'body contains contents of file') do
        res[:body]
      end
    end

  end
end
