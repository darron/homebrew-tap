class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.13"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.13/dbrain_v0.2.13_darwin_arm64.tar.gz"
      sha256 "977166fe93c846930499a74e55ad76be2841e7c104ab30b279824ad0c58a14c4"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.13/dbrain_v0.2.13_darwin_amd64.tar.gz"
      sha256 "83cc6f2ff6dd2adb2e778a4314797387974c30566889ba62c33db28a4d27d8cc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.13/dbrain_v0.2.13_linux_arm64.tar.gz"
      sha256 "5c43c385abfaa41becfe2bffc12309a74b0be2e07abceb82028d5e921ac1e359"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.13/dbrain_v0.2.13_linux_amd64.tar.gz"
      sha256 "ae966f5088fc471d89e4cb11b4c8e45a73d704c6312cf9d5bf994bf50e5b3e88"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
