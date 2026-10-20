class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.15.0/otgo_0.15.0_darwin_arm64.tar.gz"
      sha256 "13eadb63a36078f0f1de54a536b09680c2f2752fe7781a1bbb61bb9164cfc4af"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.15.0/otgo_0.15.0_darwin_amd64.tar.gz"
      sha256 "ab9bfb3c365a211aa683bad38455b1cfd2b3585866d0b1af459b7a2a8972ce4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.15.0/otgo_0.15.0_linux_arm64.tar.gz"
      sha256 "5f7c834e00be19ce67c3932bc6404d9262e35e324a31929afbc4385ced984273"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.15.0/otgo_0.15.0_linux_amd64.tar.gz"
      sha256 "701ea92dc11d645f75c077725df305c06541d0eca7ac727cc1a1e6c5ac7c9950"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=767ef153377325ed321fdb2d4a2d0691bfde1c54 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
