module Fog
  module Storage
    class Joyent
      class Real
        def put_directory(directory, options = {})
          self.build_response(self.connection.put_directory(directory, options))
        end
      end
    end
  end
end
