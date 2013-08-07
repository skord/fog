
module Fog
  module Storage
    class Joyent
      class Real
        def delete_directory(spath, dpath, options = {})
          self.build_response(self.connection.put_snaplink(spath, dpath, options))
        end
      end
    end
  end
end
