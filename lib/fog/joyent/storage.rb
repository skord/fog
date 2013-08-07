require 'fog/storage'
require 'fog/joyent'
require 'fog/joyent/errors'

require 'ruby-manta'

module Fog
  module Storage

    class Joyent < Fog::Service
      requires :joyent_username
      requires :joyent_manta_url
      requires :joyent_keyfile

      recognizes :ssl_verify_peer

      model_path 'fog/joyent/models/storage'
      model :directory
      collection :directories

      model :file
      collection :files

      request_path 'fog/joyent/requests/storage'

      request :put_object
      request :get_object
      request :delete_object

      request :list_directory
      request :put_directory
      request :delete_directory

      request :put_snaplink

      request :create_job
      request :get_job
      request :get_job_errors

      request :list_jobs
      request :cancel_job

      request :add_job_keys
      request :end_job_input
      request :get_job_input
      request :get_job_output
      request :get_job_failures
      request :gen_signed_url

      module Common
        attr_reader :connection
        attr_reader :root

        def user_path(*args)
          "/#{@joyent_username}"
        end

        def initialize(options = {})
          @joyent_username = options[:joyent_username]
          @joyent_manta_url = options[:joyent_manta_url]
          @joyent_keyfile = options[:joyent_keyfile]

          @ssl_verify_peer = options[:ssl_verify_peer] || false

          unless ::File.exists? @joyent_keyfile
            raise ArgumentError.new(":joyent_keyfile does not exist: #{@joyent_keyfile}")
          end

          @joyent_keydata = ::File.read(@joyent_keyfile)

          @connection = MantaClient.new(
            @joyent_manta_url,
            @joyent_username,
            @joyent_keydata,
            :disable_ssl_verification => !@ssl_verify_peer
          )
        end

        def build_response(manta_client_res)
          headers, body = manta_client_res
          Excon::Response.new(
            headers: headers,
            body: body
          )
        end
      end

      class Real
        include Common
      end

      class Mock
        include Common
      end
    end
  end
end
