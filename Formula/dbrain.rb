class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.4.1"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.1/dbrain_v0.4.1_darwin_arm64.tar.gz"
      sha256 "b7882d15bc547a47770b550e0e673bd6f23d46d2364482190b7f778be5cea35b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.1/dbrain_v0.4.1_darwin_amd64.tar.gz"
      sha256 "8c5e585af0d3a2dca8ed0881babdc09fb44a5d66cc34df96c90fe50faa09f9f2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.1/dbrain_v0.4.1_linux_arm64.tar.gz"
      sha256 "6012d4407012b1f033319ecbd773c41e65c4ffdcd37f882c21f41ec371975d0e"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.1/dbrain_v0.4.1_linux_amd64.tar.gz"
      sha256 "a1c2da2a726c313bb040f875401c0b9441f788b9d33e25220f28b29dc23cd1f1"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
