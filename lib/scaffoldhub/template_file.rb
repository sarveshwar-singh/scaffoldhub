module Scaffoldhub
  class TemplateFile < RemoteFile

    def initialize(src, dest, local, base_url, status_proc)
      @src      = src
      @dest     = dest
      @local    = local
      @base_url = base_url
      super(status_proc)
    end

    def src
      if @local
        File.join(@base_url, @src)
      else
        @local_path
      end
    end

    def dest
      File.join(@dest, File.basename(@src))
    end

    def download!
      @local_path = Tempfile.new(File.basename(@src)).path
      open(@local_path, "wb") do |file|
        file.write(remote_file_contents!)
      end
    end

    def url
      "#{@base_url}/#{@src}"
    end

  end
end