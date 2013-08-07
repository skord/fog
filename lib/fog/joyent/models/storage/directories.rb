require 'fog/core/collection'
require 'fog/joyent/models/storage/directory'

module Fog
  module Storage
    class Joyent
      class Directories < Fog::Collection
        model Fog::Storage::Joyent::Directory

        attribute :directory

        def all
          path = if directory
            directory.path
          else
            service.user_path
          end

          response = service.list_directory(path)

          dirs = response.data.select do |o|
            o[:type] == 'directory'
          end

          dirs = dirs.map do |d|
            d[:directory] = directory
          end

          load(dirs)
        end

      end
    end
  end
end
