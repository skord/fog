module Fog
  module Storage
    class Joyent
      class Directories < Fog::Collection
        model Fog::Storage::Joyent::Directory

        def all
          directory ? path = directory.parent : path = ''
          path = path + '/' unless path =~ /\/$/
          data = service.list_directory(path)

          dirs = data.select {|o| o[:type] == 'directory'}
          load(dirs)
        end

      end
    end
  end
end
