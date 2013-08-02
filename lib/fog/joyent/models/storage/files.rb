module Fog
  module Storage
    class Joyent
      class Files < Fog::Collection
        model Fog::Storage::Joyent::File
      end
    end
  end
end
