class Tagit < Formula
  desc "To create and increment semantic Git tags"
  homepage "https://github.com/leprosus/tagit"
  url "https://github.com/leprosus/tagit/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "f0d7defb210ef511d65ac4fbdfc89746a0e4ae1c5f7b53eead15208bfb43453e"
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
