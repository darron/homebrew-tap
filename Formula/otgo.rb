class Otgo < Formula
  desc "OpenTunnel CLI with an embeddable Go client"
  homepage "https://github.com/darron/go-opentunnel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.13.0/otgo_0.13.0_darwin_arm64.tar.gz"
      sha256 "d7d839fc18392525d797b2c9a0083e1bb0f16eba4b95ab3720a7062f3c1a9d2e"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.13.0/otgo_0.13.0_darwin_amd64.tar.gz"
      sha256 "d6503edd779002545a5c4e91c3995258425fa25be4073c0a216783f4bd017824"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.13.0/otgo_0.13.0_linux_arm64.tar.gz"
      sha256 "da94bb990f494dc33ad2121a02b1fa631eda5219dd7eb95632598001adcc2cad"
    end

    on_intel do
      url "https://github.com/darron/go-opentunnel/releases/download/v0.13.0/otgo_0.13.0_linux_amd64.tar.gz"
      sha256 "6dc6c52ee25d5e5132feab85855e753707b877df1aa3d3314ed378604d0ca241"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/otgo"

  def install
    bin.install "otgo"
  end

  test do
    assert_match "Usage: otgo", shell_output("#{bin}/otgo help")
    assert_equal "otgo #{version} sha=caec102691d804485f93804b316da3b953c3ae20 clean\n", shell_output("#{bin}/otgo version")
    output = shell_output("#{bin}/otgo get --data-dir #{testpath}/tunnels --json")
    assert_equal "null\n", output
    refute_path_exists testpath/"tunnels/default/private-key.pem"
  end
end
