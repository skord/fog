require 'ruby-manta'

module Fog
  module Storage

    class Joyent < Fog::Service
      attr_reader :connection

      requires :joyent_username
      requires :joyent_manta_url
      requires :joyent_private_key

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

      def user_path_to(args*)
        "/#{File.join(@joyent_username, args}"
      end
    end

    class Mock < Joyent::Service

    end

    class Real < Joyent::Service
      @joyent_username = options[:joyent_username]
      @joyent_manta_host = options[:joyent_manta_host]
      @joyent_private_key = options[:joyent_private_key]
      @ssl_verify_peer = options[:ssl_verify_peer] || false

      def initialize(options = {})
        @connection = MantaClient.new(
          @joyent_manta_host,
          @joyent_username,
          @joyent_private_key,
          :disable_ssl_verification => !@ssl_verify_peer)
      end
    end
  end
end
