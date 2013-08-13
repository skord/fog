require 'fog/core/collection'
require 'fog/joyent/models/storage/directory'

module Fog
  module Storage
    class Joyent
      class Directories < Fog::Collection
        model Fog::Storage::Joyent::Directory

        attribute :directory

        def all

          unless directory
            path = ::File.join(service.user_path, 'stor')
            directory = Fog::Storage::Joyent::Directory.new(:key => path)
          end

          response = service.list_directory(directory.key)

          dirs = response[:body].select {|o| o['type'] == 'directory' }.map do |d|
            d[:directory] = directory
            d[:path] = ::File.join(directory.path, d["name"])
            d
          end

          load(dirs)
        end

        def get(key, options = {})
          new(:key => key)
        end

        def new(attributes = {})
          if directory
            attributes = {:directory => directory}.merge(attributes)
          end

          super(attributes)
        end

      end
    end
  end
end
