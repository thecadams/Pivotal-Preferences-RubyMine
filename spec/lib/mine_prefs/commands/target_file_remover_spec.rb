require "mine_prefs/commands/target_file_remover"

module MinePrefs
  module Commands
    describe TargetFileRemover do
      context "target files exist" do
        it "removes all target files" do
          filesystem = double :filesystem
          installation_bundle = double :installation_bundle, target_files: ["/BAZ/foo/bar"]

          filesystem.should_receive(:rm_rf).with("/BAZ/foo/bar")

          TargetFileRemover.new(
            filesystem: filesystem
          ).execute(installation_bundle)
        end
      end

      context "target files don't exist" do
        it "silently ignores them" do
          filesystem = double :filesystem
          installation_bundle = double :installation_bundle, target_files: ["/BAZ/foo/bar"]

          filesystem.stub(:rm_rf).with("/BAZ/foo/bar").and_raise Errno::ENOENT

          TargetFileRemover.new(
            filesystem: filesystem
          ).execute(installation_bundle)
        end
      end
    end
  end
end
