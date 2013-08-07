module Fog
  module Storage
    class Joyent
      class Real
        def add_job_keys(job_path, object_keys, options)
          self.build_response(self.connection.add_job_keys(job_path, object_keys, options))
        end
      end
    end
  end
end
