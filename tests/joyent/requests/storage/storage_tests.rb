require 'minitest/autorun'

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
      p = @service.user_path + '/stor'
      res = @service.list_directory(p)

      returns(Excon::Response) do
        res.class
      end

      returns(Array, 'body is an array') do
        res[:body].class
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


    tests "delete_directory" do
      dir = File.join(@service.user_path, '/stor/ruby-manta.test')

      res = @service.delete_directory(dir)

      returns(Excon::Response) do
        res.class
      end

      returns(true, 'true for success delete') do
        res[:body]
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


    tests "put_snaplink" do
      spath = File.join(@service.user_path, 'stor', 'ruby-manta.test.hello')
      dpath = File.join(@service.user_path, 'stor', 'ruby-manta.test.world')

      res = @service.put_snaplink(spath, dpath)

      returns(Excon::Response) do
        res.class
      end

      returns(true, 'true for success snaplink') do
        res[:body]
      end

      test 'get created snaplink' do
        res = @service.get_object(File.join(@service.user_path, 'stor'), 'ruby-manta.test.world')
        returns(Excon::Response) do
          res.class
        end
        returns('hello ruby-manta') do
          res[:body]
        end
      end
    end


    tests "jobs" do
      job_details = {
        :name => 'total word count',
        :phases => [ {
          :exec => 'wc'
          }, {
            :type => 'reduce',
            :exec => "awk '{ l += $1; w += $2; c += $3 } END { print l, w, c }'"
            } ]
      }

      res = {}
      res[:job] = @service.create_job(job_details)

      tests "create_job" do
        returns(Excon::Response) { res[:job].class }
        returns(String) { res[:job][:body].class }
      end

      tests "add_job_keys" do
        f = File.join(@service.user_path, 'stor', 'ruby-manta-test.hello')
        res[:add_job_keys] = @service.add_job_keys(res[:job][:body], [f])
        returns(Excon::Response) { res[:add_job_keys].class }
      end

      tests "get_job" do
        job_path = res[:job][:body]
        returns(Excon::Response) { @service.get_job(res[:job][:body]).class }
      end
    end

    tests "delete_object" do
      dir = File.join(@service.user_path, '/stor')
      f = 'ruby-manta.test.hello'

      res = @service.delete_object(dir, f)

      returns(Excon::Response) do
        res.class
      end

      returns(true, 'true for success delete') do
        res[:body]
      end
    end
  end

  tests "models" do
    @service = Fog::Storage[:joyent]

    tests "File" do
      tests "files.all" do
        files = @service.files.all
        returns(Fog::Storage::Joyent::Files) { files.class }
      end

      tests "save file" do
        file = @service.files.create(
          :directory => @service.user_path + '/stor',
          :key => 'hello.file',
          :body => 'hello'
          )

        test "object contains body" do
          file.body == 'hello'
        end

        test "object contains etag" do
          file.etag.kind_of?(String)
        end

        test "object contains size" do
          file.size == 5
        end
      end


      tests "destroy file" do
        file = @service.files.create(
          :directory => @service.user_path + '/stor',
          :key => 'hello.file',
          :body => 'hello'
        )

        test "destroy succeeded" do
          file.destroy
        end
      end
    end


    tests "Directory" do
      test "create" do
        directory = @service.directories.create(
          :directory => ::File.join(@service.user_path, 'stor'),
          :key => 'hello.dir'
        )

        returns(Fog::Storage::Joyent::Directory) do
          directory.class
        end
      end

      test "destroy" do
        directory = @service.directories.get(::File.join(@service.user_path, 'stor', 'hello.dir'))
        puts directory.inspect
        directory.destroy
      end
    end

  end

end
