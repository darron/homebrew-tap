class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.6.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.6.0/dbrain_v0.6.0_darwin_arm64.tar.gz"
      sha256 "787ba040175c28bc98a61297bea2b23afdb1946edace71a54b10599250c91c00"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.6.0/dbrain_v0.6.0_darwin_amd64.tar.gz"
      sha256 "8a702f71a7d52445cda5c93dc090df491c1fcb682a0f956ab189927fb7082c76"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.6.0/dbrain_v0.6.0_linux_arm64.tar.gz"
      sha256 "3ae491e0fcb2846f4a219e442a9ac8756037e659439134f9ddcebed07c9d523c"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.6.0/dbrain_v0.6.0_linux_amd64.tar.gz"
      sha256 "c7d6fb3d9769a058d1956e888cc847773f5353c78458a5497da7574e7e795f04"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
