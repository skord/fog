module Fog
  module Storage
    class Joyent
      class Real
        def put_object(directory, object_name, data, options = {})
          object_path = File.join(directory, object_name)
          res = self.connection.put_object(object_path, data, options)
          self.build_response(res)
        end
      end
    end
  end
end
