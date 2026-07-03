class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.24"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.24/dbrain_v0.2.24_darwin_arm64.tar.gz"
      sha256 "bd00fb3b092ae0a0399c05ffc3532ed0e5d5dd12fb375051959c5ed265de3d29"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.24/dbrain_v0.2.24_darwin_amd64.tar.gz"
      sha256 "754e41641627dfe14b9c4e57491105682d69a33ce91553de86bcc36333e5e9ca"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.24/dbrain_v0.2.24_linux_arm64.tar.gz"
      sha256 "b977eaaf806ab3aa1c6c1a8f3437cadc0c3d11da335e5a8cddd2983bc8d49a94"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.24/dbrain_v0.2.24_linux_amd64.tar.gz"
      sha256 "42866aecd8cd23d75e8e403a6e8eabf6f30a531c401aada94dfb5dac3d4c9c74"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
