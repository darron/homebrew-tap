class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.4"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.4/dbrain_v0.1.4_darwin_arm64.tar.gz"
      sha256 "a06829b378e194025757be1bf6d87bffed0f2dfdf06e797dc6abc217ec260468"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.4/dbrain_v0.1.4_darwin_amd64.tar.gz"
      sha256 "c566d215e8de8ee6f9445a75760d2cf144057605f7724138c8c0961df13317b8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.4/dbrain_v0.1.4_linux_arm64.tar.gz"
      sha256 "e8482664fac68f584ae8730d3684c8c7ff1dc34ee109a5009a0de37c38418794"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.4/dbrain_v0.1.4_linux_amd64.tar.gz"
      sha256 "f0a58618f6ed03022e1f760cbc7a58e71b1df6db0f44f7869db8b0145b89b89a"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
