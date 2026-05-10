class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.7"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.7/dbrain_v0.1.7_darwin_arm64.tar.gz"
      sha256 "ed8cfecbcda5dc53a3049afc767d112d362e556b49ae04a7e5de8281c822e3b3"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.7/dbrain_v0.1.7_darwin_amd64.tar.gz"
      sha256 "3b9f5b4f688adabf94f92a3bfbbf869658109e3fe8ef8066ac4500391cf1cf50"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.7/dbrain_v0.1.7_linux_arm64.tar.gz"
      sha256 "17c5329343a2064f827204aa1dddbca9ab979bf168e6e74b3c08e9548a35d80a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.7/dbrain_v0.1.7_linux_amd64.tar.gz"
      sha256 "4e7f70bb3ee3e764e4b1493936b884fe6dfb0b5a525f33aac5216fad8ef764b6"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
