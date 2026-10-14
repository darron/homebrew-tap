class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.12.0/otgo_0.12.0_darwin_arm64.tar.gz"
      sha256 "0258c7484033125a7b1105b2c091f96293c213332289ce17a37fd8ba83f4e0be"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.12.0/otgo_0.12.0_darwin_amd64.tar.gz"
      sha256 "d877e866fcd28ea1fa1438d706eb6dfcc4221bad7b1cd9b606833e9e59c60e84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.12.0/otgo_0.12.0_linux_arm64.tar.gz"
      sha256 "e4e5cba13259eb7d4f7ce98a559dc59579dc7caa977ba9766eead4aca4f77d89"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.12.0/otgo_0.12.0_linux_amd64.tar.gz"
      sha256 "0eb73b639928cdbfa90cdd7c1fb6aed4554f099c318b2fff1f6aa18136cece7e"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=12d58b03b7faace29132de5b72e2b95674a38eb1 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
