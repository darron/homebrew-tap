class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.0/otgo_0.14.0_darwin_arm64.tar.gz"
      sha256 "63ed3bef398d7a9d4e76342410ad255547a3f72e17d33d0283a1c59b3827ab75"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.0/otgo_0.14.0_darwin_amd64.tar.gz"
      sha256 "e4b6551748680972922d817e9d29f1cd1c5aec7ef5e7fb4755edb0ea83a13090"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.0/otgo_0.14.0_linux_arm64.tar.gz"
      sha256 "abd93c8f2d4a82696eb27f3dab885077e83c4dc7026d0f1c65ac32af1272aebc"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.0/otgo_0.14.0_linux_amd64.tar.gz"
      sha256 "ff8e842897126801a3cbefa901cc3b68570ec44aeea9a79ee001a90df9f25ad0"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=160589d55ab1c1ff3006500e8d7187636f9ab500 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
