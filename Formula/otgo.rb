class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  url "https://github.com/darron/go-opentunnel/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "32fc5d56303df4d22a7f62b1c473a621c01b1df241d7309e2273011045d4004e"
  license "MIT"
  head "https://github.com/darron/go-opentunnel.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[-s -w]
    if build.stable?
      ldflags += %w[-X main.buildRevision=5fca156c7257fd6ff4bab1a0687ea1a70d3cfcc7 -X main.buildState=clean]
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
