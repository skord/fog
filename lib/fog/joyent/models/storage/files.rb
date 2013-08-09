require 'fog/core/collection'
require 'fog/joyent/models/storage/file'

module Fog
  module Storage
    class Joyent
      class Files < Fog::Collection
        model Fog::Storage::Joyent::File

        attribute :directory

        def all(options = {})
          unless directory
            path = ::File.join(service.user_path, 'stor')
            directory = Fog::Storage::Joyent::Directory.new(:path => path)
          end

          response = service.list_directory(directory.path)
          files = response.body.select {|f| f['type'] === 'object'}.map do |f|
            f[:directory] = directory
            f[:path] = ::File.join(directory.path, f["name"])
            f
          end

          load(files)
        end
      end
    end
  end
end
