class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.8"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.8/dbrain_v0.2.8_darwin_arm64.tar.gz"
      sha256 "d4532c0963997f48214babd73315b81ba4ac9a17ad2d2465494f1b9709ca370b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.8/dbrain_v0.2.8_darwin_amd64.tar.gz"
      sha256 "b2747c1d6178cd84c4fd75ac7e2948672abc044bff59a000e5091cce39e7ec5a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.8/dbrain_v0.2.8_linux_arm64.tar.gz"
      sha256 "ec0b7c5800a71eb4abd888d3e089bbed063aedc25ca6b668e66090a80af35155"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.8/dbrain_v0.2.8_linux_amd64.tar.gz"
      sha256 "7e78dd2f699de13d7af062be830d71f2b2d8f6857239b4788baf7a98d7d77348"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
