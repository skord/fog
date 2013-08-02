module Fog
  module Storage
    class Joyent
      class Real
        def delete_directory(directory, options = {})
          dir_path = user_path_to(directory)
          self.connection.delete_directory(dir, options)
        end
      end
    end
  end
end
