module Fog
  module Storage
    class Joyent
      class Real
        def delete_object(directory, object_name, options = {})
          object_path = ::File.join(directory, object_name)
          self.build_response(self.connection.delete_object(object_path, options))
        end
      end

      class Mock
        def delete_object(directory, object_name, options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
