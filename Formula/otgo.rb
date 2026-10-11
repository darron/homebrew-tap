class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  url "https://github.com/darron/go-opentunnel/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "2c0fd0d1946c5157ace2237bd3caa95111a9c760e227562ba978f1dcf54b6852"
  license "MIT"
  head "https://github.com/darron/go-opentunnel.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"otgo", ldflags: "-s -w"), "./cmd/otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
