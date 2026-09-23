class Tagit < Formula
  desc "To create and increment semantic Git tags"
  homepage "https://github.com/leprosus/tagit"
  url "https://github.com/leprosus/tagit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "bcea8a2a1b0dd76c80b85f682c03c5f6b1c1de3ef464565e5b5e871102bef4a9"
  license "MIT"

  depends_on "go" => :build
  depends_on "git"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "unknown version increment",
      shell_output("#{bin}/tagit invalid 2>&1", 1)
  end
end