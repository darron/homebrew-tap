class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.0/otgo_0.16.0_darwin_arm64.tar.gz"
      sha256 "68d13aa6425f960aa9b9b1d3cf64010532d6f1f9c5a31bb3adc03882990320e7"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.0/otgo_0.16.0_darwin_amd64.tar.gz"
      sha256 "0998008dab7c768041476fa68533d9cf091b8762bc9a7a394abfc90796c27389"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.0/otgo_0.16.0_linux_arm64.tar.gz"
      sha256 "98e8848e09041582b16d40caccd3b091b24d67d7789ecfefa4e51258a883c83a"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.16.0/otgo_0.16.0_linux_amd64.tar.gz"
      sha256 "81552ab30abc14f2d61e1f07aa188847cb42fb89549573e750a95754f42e5726"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=5ce0ba4fcf5f00b0eacea8b5e36d9fe4979378c3 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
