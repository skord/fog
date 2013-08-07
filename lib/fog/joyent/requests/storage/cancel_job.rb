module Fog
  module Storage
    class Joyent
      class Real
      	# valid states: :done, :all, :running
        def cancel_job(state, options={})
          self.build_response(self.connection.cancel_job(job_path, options))
        end
      end
    end
  end
end
