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
            directory = Fog::Storage::Joyent::Directory.new(:path => path)
          end

          response = service.list_directory(directory.path)

          dirs = response[:body].select {|o| o['type'] == 'directory' }.map do |d|
            d[:directory] = directory
            d[:path] = ::File.join(directory.path, d["name"])
            d
          end

          load(dirs)
        end

        def new(attributes ={})
          attributes = {:directory => directory}.merge(attributes) if directory
          super(attributes)
        end


      end
    end
  end
end
