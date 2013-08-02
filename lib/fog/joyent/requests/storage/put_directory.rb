module Fog
  module Storage
    class Joyent
      class Real
        def put_directory(directory, options = {})
          object_path = user_path_to(directory)
          self.connection.put_directory(directory, options)
        end
      end
    end
  end
end
