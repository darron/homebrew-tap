class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.9"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.9/dbrain_v0.2.9_darwin_arm64.tar.gz"
      sha256 "ab7c3d86d618827d03cd86a2b00f6e96fc262a5a9e175d5c86d59f5751181728"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.9/dbrain_v0.2.9_darwin_amd64.tar.gz"
      sha256 "2c8a8537c6d8d4576017620946cf8a439c1caa1343b1c01aefd1e325ec4e214a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.9/dbrain_v0.2.9_linux_arm64.tar.gz"
      sha256 "9e0f6ed068430bd382de9b233d80e3c77e9c65310a1e5b935331ab596bd47f94"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.9/dbrain_v0.2.9_linux_amd64.tar.gz"
      sha256 "4550c743df2431ad9731180f3882db4efc30f6961220b35adb52ec70b08c3041"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
