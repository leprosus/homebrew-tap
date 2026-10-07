class Tagit < Formula
  desc "To create and increment semantic Git tags"
  homepage "https://github.com/leprosus/tagit"
  url "https://github.com/leprosus/tagit/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "b3d7cd24201121b35ea9b9ae5779b95a3377ce69a67516cee10d58cd650dbcda"
  license "MIT"

  depends_on "go" => :build
  depends_on "git"

  def install
    system "go", "build",
      *std_go_args(ldflags: "-s -w -X github.com/leprosus/tagit/command.releaseVersion=v#{version}"), "."
  end

  test do
    assert_equal "v#{version}\n", shell_output("#{bin}/tagit ver")
    system "git", "init"
    assert_match "unknown version increment",
      shell_output("#{bin}/tagit invalid 2>&1", 1)
  end
end
