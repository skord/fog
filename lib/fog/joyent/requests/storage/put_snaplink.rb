
module Fog
  module Storage
    class Joyent
      class Real
        def delete_directory(spath, dpath, options = {})
          spath = user_path_to(spath)
          dpath = user_path_to(dpath)

          self.connection.put_snaplink(spath, dpath, options)
        end
      end
    end
  end
end
