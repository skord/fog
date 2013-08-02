module Fog
  module Storage
    class Joyent
      attr_reader :directory

      class File < Fog::Model
        identity :key,  :aliases => 'name'
        attribute :size
        attribute :parent
      end
    end
  end
end
