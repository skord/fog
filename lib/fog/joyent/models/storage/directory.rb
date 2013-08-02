module Fog
  module Storage
    class Joyent
      class Directory < Fog::Model
        identity :key, :aliases => 'name'

        def directories
          @directories ||= begin
            Fog::Storage::Joyent::Directories.new(
              :directory => self,
              :service => service
            )
          end
        end

        def files
          @files ||= begin
            Fog::Storage::Joyent::Files.new(
              :directory => self,
              :service => service
            )
          end
        end
      end
    end
  end
end
