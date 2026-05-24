class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.12"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.12/dbrain_v0.2.12_darwin_arm64.tar.gz"
      sha256 "082e9c6db452b51ae67bd8d1bc885eb2dc9241ab8646dabc25a131f078f78144"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.12/dbrain_v0.2.12_darwin_amd64.tar.gz"
      sha256 "af18f212967521f083d0033711009b98bdd1595b8d0a2b127482378eb82b2d9e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.12/dbrain_v0.2.12_linux_arm64.tar.gz"
      sha256 "66d49053dfe5e0caf2b8f1129eae6440cc19230c350f8a34e1e92911b083b181"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.12/dbrain_v0.2.12_linux_amd64.tar.gz"
      sha256 "59b01a3701b06cca3df9cdeee3d3a96924db433e1c5b3a24aafc93abb251ad56"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
