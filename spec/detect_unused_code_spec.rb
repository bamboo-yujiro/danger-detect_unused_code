require File.expand_path("../spec_helper", __FILE__)

module Danger
  describe Danger::DangerDetectUnusedCode do
    it "should be a plugin" do
      expect(Danger::DangerDetectUnusedCode < Danger::Plugin).to be_truthy
      @duc = testing_dangerfile.detect_unused_code
      allow(@duc.git).to receive(:added_files).and_return(["hoge/Piyo.swift"])
      allow(@duc.git).to receive(:deleted_files).and_return(["hoge/Piyo2.swift"])
      allow(@duc.git).to receive(:modified_files).and_return(["hoge/Piyo3.swift"])
      @duc.config_file = "dummy.rb"
      binding.pry
    end

    #
    # You should test your custom attributes and methods here
    #
=begin
    describe "with Dangerfile" do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.detect_unused_code

        # mock the PR data
        # you can then use this, eg. github.pr_author, later in the spec
        json = File.read(File.dirname(__FILE__) + '/support/fixtures/github_pr.json') # example json: `curl https://api.github.com/repos/danger/danger-plugin-template/pulls/18 > github_pr.json`
        allow(@my_plugin.github).to receive(:pr_json).and_return(json)
      end

      # Some examples for writing tests
      # You should replace these with your own.

      it "Warns on a monday" do
        monday_date = Date.parse("2016-07-11")
        allow(Date).to receive(:today).and_return monday_date

        @my_plugin.warn_on_mondays

        expect(@dangerfile.status_report[:warnings]).to eq(["Trying to merge code on a Monday"])
      end

      it "Does nothing on a tuesday" do
        monday_date = Date.parse("2016-07-12")
        allow(Date).to receive(:today).and_return monday_date

        @my_plugin.warn_on_mondays

        expect(@dangerfile.status_report[:warnings]).to eq([])
      end

    end
=end
  end
end
