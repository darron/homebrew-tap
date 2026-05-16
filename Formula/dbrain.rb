class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.6"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.6/dbrain_v0.2.6_darwin_arm64.tar.gz"
      sha256 "95264496c93cf52375764f348d353bec0567ec9a7091131cb305ebad53185921"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.6/dbrain_v0.2.6_darwin_amd64.tar.gz"
      sha256 "965196697c25db336ec50cd8dda74f3d6cbd0442bb96ae49dd799142c99d2c28"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.6/dbrain_v0.2.6_linux_arm64.tar.gz"
      sha256 "65489b248823f88bfc3759abf1495de1787904c973ed95c7a874984c53134e09"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.6/dbrain_v0.2.6_linux_amd64.tar.gz"
      sha256 "8603aac7fbadeeaf29ad6bfc940679a73ef8f691c7c69d22487d98745dd88729"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
