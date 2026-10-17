class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.2/otgo_0.14.2_darwin_arm64.tar.gz"
      sha256 "100c96d06306af0cc72e6bfb4c43f076fd21a1d73b39ed57ca2d15a7978e724b"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.2/otgo_0.14.2_darwin_amd64.tar.gz"
      sha256 "62a3a98d3be1d674a8324bdab2779da386bdc975cc765f64cae64784c44ca330"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.2/otgo_0.14.2_linux_arm64.tar.gz"
      sha256 "956f4e790eea7f0041001294039ba31982076fe97f73971c58dbc009da7e394c"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.14.2/otgo_0.14.2_linux_amd64.tar.gz"
      sha256 "a0b686250da71356e8fcc84424c0503abe7bb98ab5aad165a11a477578eb8498"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=0de13c2231322629bc4abd93b73661a018fe208f clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
