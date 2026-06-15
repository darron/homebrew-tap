class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.18"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.18/dbrain_v0.2.18_darwin_arm64.tar.gz"
      sha256 "85e055c3597c179fb035701fa388cf759c921eb86640c4de540a9645bcb03109"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.18/dbrain_v0.2.18_darwin_amd64.tar.gz"
      sha256 "101903a28e78e5de35b0889ead02e37c70236fd03cdd472d530fd3886028e293"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.18/dbrain_v0.2.18_linux_arm64.tar.gz"
      sha256 "bbe6152afa78880e9ef4536fb1b610aef7a51fa062d9c281a359968ecd64ca0f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.18/dbrain_v0.2.18_linux_amd64.tar.gz"
      sha256 "671e3f61fc797573b5c999af997919288be91a20e5756fe2ee2c59bcdb90ab7b"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
