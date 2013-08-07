module Fog
  module Storage
    class Joyent
      class Real
        def put_directory(directory, options = {})
          object_path = directory
          self.connection.put_directory(directory, options)
        end
      end
    end
  end
end
