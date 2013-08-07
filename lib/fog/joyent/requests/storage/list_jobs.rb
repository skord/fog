module Fog
  module Storage
    class Joyent
      class Real
      	# valid states: :done, :all, :running
        def get_job_errors(state, options={})
          self.build_response(self.connection.get_job_errors(state, options))
        end
      end
    end
  end
end
