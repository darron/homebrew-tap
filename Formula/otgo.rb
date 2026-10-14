class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.11.0/otgo_0.11.0_darwin_arm64.tar.gz"
      sha256 "80516b5fd09abb95b7fe008ac248e73e18bc3df39e0f5932538cbeded188e543"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.11.0/otgo_0.11.0_darwin_amd64.tar.gz"
      sha256 "477d8d2be432d1f67c7907edc74c8305cfc187299996b889440af4387bcb8cc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.11.0/otgo_0.11.0_linux_arm64.tar.gz"
      sha256 "75dca7d1f7f833adebc2644ebcdc58ecb376f4a5ce4ea5f9b31e621fa48fecf4"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.11.0/otgo_0.11.0_linux_amd64.tar.gz"
      sha256 "4ca885261ceb28eaa5855d9b995cdfcb59720ada3f0791437802c5252ae36ff3"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=14620a57b0fe2dc88860304df90093cc24da09f5 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
