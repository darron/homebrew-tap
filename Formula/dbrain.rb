class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.4.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.0/dbrain_v0.4.0_darwin_arm64.tar.gz"
      sha256 "9cadf084a6c8ec49f056841d92126c784c193b39b8803edd19d1a4b17059629d"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.0/dbrain_v0.4.0_darwin_amd64.tar.gz"
      sha256 "60179af78592d06603453ffb5be13f11d7e9a21e8ca5356315dec10bb824d5f0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.0/dbrain_v0.4.0_linux_arm64.tar.gz"
      sha256 "fe7491b335a8a65f74286f14b5d0a6c4070a9550997ad267a511f47cd31ac0b8"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.0/dbrain_v0.4.0_linux_amd64.tar.gz"
      sha256 "61b3ff0c53b9e390c551e3cdae9bd3cbf13d47efbf082c71b7e4ebdb3ae70c0e"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
