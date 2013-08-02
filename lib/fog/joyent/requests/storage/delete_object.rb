module Fog
  module Storage
    class Joyent

      class Real
        def delete_object(directory, options = {})
          object_path = user_path_to(directory)
          self.connection.delete_object(directory, options)
        end
      end

    end
  end
end
