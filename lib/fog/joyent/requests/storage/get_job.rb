module Fog
  module Storage
    class Joyent
      class Real
        def get_job(job_path, options={})
          self.build_response(self.connection.get_job(job_path, options))
        end
      end
    end
  end
end
