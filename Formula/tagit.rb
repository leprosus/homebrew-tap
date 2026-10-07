class Tagit < Formula
  desc "To create and increment semantic Git tags"
  homepage "https://github.com/leprosus/tagit"
  url "https://github.com/leprosus/tagit/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d2b0d2ccdcc9e5386d45c9e9830fa5b71d3234eec297733d04e961f02e16ab69"
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
