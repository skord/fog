module Fog
  module Storage
    class Joyent
      class Real
        def put_object(directory, object_name, data, options = {})
          data = Fog::Storage.parse_data(data)
          object_path = File.join(directory, object_name)
          self.connection.put_object(object_path, data[:body], options)
        end
      end
    end
  end
end
