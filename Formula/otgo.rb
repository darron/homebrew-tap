class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.2/otgo_0.16.2_darwin_arm64.tar.gz"
      sha256 "80874a53f1840a6896ff669c1603e86bf99e4056c4665549d428a203f5756168"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.2/otgo_0.16.2_darwin_amd64.tar.gz"
      sha256 "5f5f06d77c5c72f35e9546ac52bbd3174dc1557f9a4769c49067e7e30bc1b8ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.2/otgo_0.16.2_linux_arm64.tar.gz"
      sha256 "76abefeaebb5b11c127f8527c6db025ed58e8e690f6654fb98d8aa89573de82f"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.2/otgo_0.16.2_linux_amd64.tar.gz"
      sha256 "1a3d001de5406bd3f72005c1916263b8743a2c72922c07aeabcdcdb5d89d444e"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=c5a7893e532f01602c84f0563871a92512244c1e clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
