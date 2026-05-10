class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.8"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.8/dbrain_v0.1.8_darwin_arm64.tar.gz"
      sha256 "f7ea1501435dce19a3c13eb6493b86194dd6a1bb650a19308368b3029f4d6ba6"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.8/dbrain_v0.1.8_darwin_amd64.tar.gz"
      sha256 "5321071bb1591e41b1b9d36d4f8d083a9faed49c2af5f6654faa7d5690537f56"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.8/dbrain_v0.1.8_linux_arm64.tar.gz"
      sha256 "d9c43da62d8f9f28d38061bc31c9aa039f6fb19eefa2cff1bed36e4f2d6a1156"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.8/dbrain_v0.1.8_linux_amd64.tar.gz"
      sha256 "94456ea1b804bbe6530920941fbf4fca113bbb6f4a4a6da7972b4001c2eebad7"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
