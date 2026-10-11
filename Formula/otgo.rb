class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  url "https://github.com/darron/go-opentunnel/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "fc1fac934452fe84371d197dd4949bd30dbe94c7441cd72d7a31dd48d08658be"
  license "MIT"
  head "https://github.com/darron/go-opentunnel.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[-s -w]
    if build.stable?
      ldflags += %w[-X main.buildRevision=4dd2042e9e2608d51c7864c3f85a2f252e31d63d -X main.buildState=clean]
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
