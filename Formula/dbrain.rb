class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.6.1"
  license "MIT"

  conflicts_with "dbrain-test", because: "both install the dbrain binary"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.6.1/dbrain_v0.6.1_darwin_arm64.tar.gz"
      sha256 "bf3435757ca7e004c5e1854dc68c0b1b81b6e3e719bfc5feeab8c8f707fcd897"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.6.1/dbrain_v0.6.1_darwin_amd64.tar.gz"
      sha256 "ff01833b6055ec9fc0f223eb6ef2aa8f4ba0c16d194805294ba503f1e717deec"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.6.1/dbrain_v0.6.1_linux_arm64.tar.gz"
      sha256 "a8464940e239b6d73b01ddbba0c64e953c86deecccb25f406b7117558fb723d3"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.6.1/dbrain_v0.6.1_linux_amd64.tar.gz"
      sha256 "27a3f218572944c4349a1858b0d008ad9bef24b6226a066318e9b02141ec5011"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
