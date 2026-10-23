class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.1/otgo_0.16.1_darwin_arm64.tar.gz"
      sha256 "6da4528b5db7ec2e6a00911d64efbb739d45f0f7821b3617eeb12e44c3d05b74"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.1/otgo_0.16.1_darwin_amd64.tar.gz"
      sha256 "fb71219d5c3f0e9920fcc92fdba0a9496227b95196cff352b6a2cfebf04871fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.1/otgo_0.16.1_linux_arm64.tar.gz"
      sha256 "aa1857fb455e89cacd1c1337a540f5273ca9d517c296f50e842bda074b033f66"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.1/otgo_0.16.1_linux_amd64.tar.gz"
      sha256 "1de993a051d3acee8058a87c35696ecf5a5bf6e0355faaf31e13840036bf8b90"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=a1bc15b7ae96c89ac4a29316e939987240f73f8b clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
