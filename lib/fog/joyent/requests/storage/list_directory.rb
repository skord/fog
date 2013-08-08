module Fog
  module Storage
    class Joyent
      class Real
        def list_directory(directory, options={})
          self.build_response(self.connection.list_directory(directory, options))
        end
      end
    end
  end
end
