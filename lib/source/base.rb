require 'yaml'

module Source
  class Base
    def call
      new_data = (data + latest_entries.collect(&:to_h))
        .uniq { |entry| entry['url'] }
        .sort_by { |entry| Time.parse(entry['created_at']).to_i * -1 }

      File.write( file, YAML.dump(new_data) )

      # Now to the distinct
      File.write( distinct_file, YAML.dump(new_data.uniq { |entry| entry['repository_url'] }) )
    end

    def data
      @data ||= YAML.safe_load(file.read) || []
    end

    def file
      @file ||= File.open(File.join(File.dirname(__FILE__), '../../src/_data/', filename))
    end

    def distinct_file
      @distinct_file ||= File.open(File.join(File.dirname(__FILE__), '../../src/_data/', distinct_filename))
    end
  end
end
