module Fog
  module Storage
    class Joyent
      class Real
        def get_job_errors(job_path)
          self.build_response(self.connection.get_job_errors(job_path))
        end
      end
    end
  end
end
