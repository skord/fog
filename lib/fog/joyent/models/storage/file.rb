module Fog
  module Storage
    class Joyent

      class File < Fog::Model
        identity :key,  :aliases => 'name'
        attribute :size
        attribute :etag
        attribute :directory
        attr_accessor :directory
        

        def directory
          @directory
        end

        def directory=(new_directory)
          @directory = new_directory
        end

        def save(options = {})
          requires :body, :directory, :key

          d = if directory.kind_of?(Directory)
            directory.key
          else
            directory
          end

          res = service.put_object(d, key, body, options)

          merge_attributes(
            :content_length => Fog::Storage.get_body_size(body),
            :last_modified  => res[:headers]['Last-Modified'],
            :size => Fog::Storage.get_body_size(body),
            :etag => res[:headers]['Etag']
          )
          true
        end

        def body
          attributes[:body] ||= begin
            res = service.get_object(directory.key, key)
            res[:body]
          end
        end

        def body=(b)
          attributes[:body] = b
        end

        def destroy
          requires :directory, :key

          d = if directory.kind_of?(Directory)
            directory.key
          else
            directory
          end

          service.delete_object(d, key)
          true
        end
      end
    end
  end
end
