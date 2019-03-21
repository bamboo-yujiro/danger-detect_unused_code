module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  bamboo-yujiro/danger-detect_unused_code
  # @tags monday, weekends, time, rattata
  #
  class DangerDetectUnusedCode < Plugin

    # An attribute that you can read/write from your Dangerfile
    #
    # @return   [Array<String>]
    attr_accessor :my_attribute

    attr_accessor :config_file

    # A method that you can call from your Dangerfile
    # @return   [Array<String>]
    #
    def detect
      git_diff_files = (git.modified_files - git.deleted_files) + git.added_files
      result = `ruby #{config_file} ci`
      result_array = result.split("\n")
      indicating_files = []
      unusecode_exists_line = result_array.each do |x|
        diff_file = git_diff_files.find { |y| x.include? y }
        next unless diff_file
        matches = x.match(/\.swift\:([0-9]+)\:[0-9]\: +(.*)/)
        indicating_files.push [matches[2], diff_file, matches[1].to_i]
      end
      indicating_files.each do |file|
        send(:warn, file[0], file: file[1], line: file[2])
      end
    end
  end
end
