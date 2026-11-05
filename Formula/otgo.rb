class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.3/otgo_0.16.3_darwin_arm64.tar.gz"
      sha256 "11091ce595ba600b5b05117b2fddf46ca4463eddc952c14b30c4c3f16ad3e65f"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.3/otgo_0.16.3_darwin_amd64.tar.gz"
      sha256 "c4c9a7dcf9ec08a82ceecd4da046531389e9ce765f3be024264f645752094719"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.3/otgo_0.16.3_linux_arm64.tar.gz"
      sha256 "b03bfd4d37858dc66618e85489f85d054a1e6ab4d9c5def81804ae28ecdf69b1"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.3/otgo_0.16.3_linux_amd64.tar.gz"
      sha256 "0c3eea7572c66d130f8d42b4d9051abd891624a0597adcce83c99525213be8a4"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=907e3df7c7d9e99ac88b8b979801d7fdb229a9cb clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
