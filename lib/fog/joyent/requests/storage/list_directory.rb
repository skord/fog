module Fog
  module Storage
    class Joyent
      class Real
        def list_directory(directory, options={})
          unless options.kind_of?(Hash)
            raise ArgumentError('options should be a hash')
          end

          self.build_response(self.connection.list_directory(directory, options))
        end
      end
    end
  end
end
