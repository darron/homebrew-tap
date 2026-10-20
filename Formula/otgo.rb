class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.3/otgo_0.14.3_darwin_arm64.tar.gz"
      sha256 "88631f2c34976433c9d561bd318e10b3978ccbc558a0afdf524d0c3897da05c7"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.3/otgo_0.14.3_darwin_amd64.tar.gz"
      sha256 "ca304bf009d8a67333f62d3602116698d65dab834f155fd30ff62652b7465b60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.3/otgo_0.14.3_linux_arm64.tar.gz"
      sha256 "dbd1e25023de6a498f2801c1b96c958188a430191bb3105f8ec359a4ae909fd4"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.3/otgo_0.14.3_linux_amd64.tar.gz"
      sha256 "9ba7abd4bd602c48a9a253804fae442fd6a9123e129fc18e1c726e76f4743240"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=ee32736f3c274e759ba09a7cc8713500aa1f96ba clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
