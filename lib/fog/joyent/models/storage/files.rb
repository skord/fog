require 'fog/core/collection'
require 'fog/joyent/models/storage/file'

module Fog
  module Storage
    class Joyent
      class Files < Fog::Collection
        model Fog::Storage::Joyent::File

        attribute :directory

        def all(options = {})
          require :directory

          response = service.list_directory(directory.path)
          files = response.body.select {|f| f[:type] === 'object'}
          files.map do |f|
            dir[:f] = directory
          end
        end
      end
    end
  end
end
