module Fog
  module Storage
    class Joyent
      class Real
        def delete_directory(directory, options = {})
          self.build_response(self.connection.delete_directory(directory, options))
        end
      end
    end
  end
end
