class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.1/otgo_0.14.1_darwin_arm64.tar.gz"
      sha256 "55d5a5d7500827b99ae0714fffd2342603af15211c991ae9ac4898f06084c3e7"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.1/otgo_0.14.1_darwin_amd64.tar.gz"
      sha256 "341c9088df9ab4fbe6ecaebbddca974e46ae0da4f2ae24e05d6425c95acc2a98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.1/otgo_0.14.1_linux_arm64.tar.gz"
      sha256 "cc8dcaa1d6da4d3cf1fbdc71e7b4259b1223196b0d4f483d1839790f86465a1b"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.1/otgo_0.14.1_linux_amd64.tar.gz"
      sha256 "f807226e24eb728b9313d69900773a7d0b49436670cae10c0a0ece32d75b59e4"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=04dffabd3d2fb52b1eee64d5603da6701b276216 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
