module Fog
  module Storage
    class Joyent
      class Real
        def create_job(options={})
          self.build_response(self.connection.create_job(options))
        end
      end
    end
  end
end
