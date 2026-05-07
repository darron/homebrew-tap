class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.2"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.2/dbrain_v0.1.2_darwin_arm64.tar.gz"
      sha256 "8a78e945152a3eb1b2d1f74266b2a5a94b1c723a9767f12ddc82d4ced69e1371"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.2/dbrain_v0.1.2_darwin_amd64.tar.gz"
      sha256 "def7a98b38602bd9993d0464ebcd822ac844dd8cbbc57b948173c0bf7dc73778"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.2/dbrain_v0.1.2_linux_arm64.tar.gz"
      sha256 "bc9fbc037bd26c01fec163cb8d3391328d2ed1a12ab8a368c68bf7b490b623a9"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.2/dbrain_v0.1.2_linux_amd64.tar.gz"
      sha256 "54ae4619d7cb4b05d7173cd8b23463e00afe19160420a5c71a46e3d13cbe4cae"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
