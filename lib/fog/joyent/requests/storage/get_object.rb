module Fog
  module Storage
    class Joyent
      class Real
        def get_object(bucket_name, object_name, options = {})
          object_path = user_path_to(bucket_name, object_name)
          self.connection.get_object(object_path, options)
        end
      end
    end
  end
end
