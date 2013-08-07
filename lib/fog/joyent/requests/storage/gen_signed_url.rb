module Fog
  module Storage
    class Joyent
      class Real
      	def gen_signed_url(expiry_date, http_method, path, query_args={})
          self.build_response(self.connection.gen_signed_url(expiry_date, http_method, path, query_args))
        end
      end
    end
  end
end
