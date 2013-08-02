module Fog
  module Storage
    class Joyent
      class Real
        def list_directory(directory, options = {})
          dir_path = user_path_to(directory)
          self.connection.list_directory(dir, options)
        end
      end
    end
  end
end
