require 'fog/core/model'

module Fog
  module Storage
    class Atmos

      class Directory < Fog::Model

        identity :key, :aliases => :Filename
        attribute :objectid, :aliases => :ObjectID

        def files
          @files ||= begin
                       Fog::Storage::Atmos::Files.new(
                         :directory => self,
                         :service   => service
                       )
                     end
        end

        def directories
          @directories ||= begin
                             Fog::Storage::Atmos::Directories.new(
                               :directory => self,
                               :service   => service
                             )
                           end
        end

        def save
          self.key = attributes[:directory].key + key if attributes[:directory]
          self.key = key + '/' unless key =~ /\/$/
          res = service.put_directory(key)
          reload
        end

        def path
          if parent
            "#{parent.path}/{name}"
          end
        end

        def destroy(opts={})
          service.delete_directory(path)
        end

      end

    end
  end
end
