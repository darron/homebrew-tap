class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  url "https://github.com/darron/go-opentunnel/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "3b37f7dd9dec8523464932f016cdf746a14420f974c6bc8066172f8bc1626796"
  license "MIT"
  head "https://github.com/darron/go-opentunnel.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[-s -w]
    if build.stable?
      ldflags += %w[-X main.buildRevision=50fcd131a7c4b5a67ed8471c3b1c174e0a0b5402 -X main.buildState=clean]
    end
    system "go", "build", *std_go_args(output: bin/"otgo", ldflags: ldflags.join(" ")), "./cmd/otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    if build.head? || version >= Version.new("0.6.0")
      output = shell_output("#{bin}/otgo version")
      assert_match(/sha=[a-f0-9]{40} (clean|dirty)/, output)
      assert_match "#{version} sha=", output if build.stable?
      assert_match " clean", output if build.stable?
    end
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
