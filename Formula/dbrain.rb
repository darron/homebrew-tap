class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.14"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.14/dbrain_v0.2.14_darwin_arm64.tar.gz"
      sha256 "f88a1673f684ef580a799ffcbc3622bce92d7d7ba22b377b992d4ac81c687880"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.14/dbrain_v0.2.14_darwin_amd64.tar.gz"
      sha256 "c244ccc710bacc94c481837537bf4265dc889a143592e84dc2f5d4de15fdbb8d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.14/dbrain_v0.2.14_linux_arm64.tar.gz"
      sha256 "9c44aad2244beab2b46a94f61dd9e1dc14544fc3ac356b291f4b0a23c9597b91"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.14/dbrain_v0.2.14_linux_amd64.tar.gz"
      sha256 "6f15f775ac30455ae32243fc5d5a4e66d326d2fa4f119879b8ed64b5722eb475"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
