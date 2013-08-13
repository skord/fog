module Fog
  module Storage
    class Joyent
      class Directory < Fog::Model
        identity :key, :aliases => 'name'
        attribute :creation_date, :aliases => 'mtime', :type => 'time'


        def directory
          @directory
        end

        def directory=(new_directory)
          @directory = new_directory
        end

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

        def destroy
          requires :key
          res = service.delete_directory(key)
          true
        end

        def save
          requires :directory, :key

          d = if directory.kind_of?(Fog::Storage::Joyent::Directory)
            directory.key
          else
            directory
          end

          path = ::File.join(d, key)
          res = service.put_directory(path)
          self.key = key
          reload
        end
      end
    end
  end
end
