class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.22"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.22/dbrain_v0.2.22_darwin_arm64.tar.gz"
      sha256 "05623eb74c9f6aca771f279cb37ee74f662059b01479a67e584f95f3925282bf"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.22/dbrain_v0.2.22_darwin_amd64.tar.gz"
      sha256 "204f5aac996e839e9d3a858decf45f2499cb4055707a6a9a67fa4223a5c58218"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.22/dbrain_v0.2.22_linux_arm64.tar.gz"
      sha256 "d5ee0bd816e921a28a400ec5f0b4a2dccd3b093405179e9452990758879f9a81"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.22/dbrain_v0.2.22_linux_amd64.tar.gz"
      sha256 "755717afcf4abde7ab30a98aaf62a3e2a1c489e52bcba902072876fd7a40fcc0"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
