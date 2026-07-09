class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.4.2"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.2/dbrain_v0.4.2_darwin_arm64.tar.gz"
      sha256 "3ce1b8bdcfbf0e6781992dde265f57cefbf74ba137ef2dc1432aa91432b2fa2a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.2/dbrain_v0.4.2_darwin_amd64.tar.gz"
      sha256 "b9069edba1c725573984d2175c66fdbd85d3743c0ade56bf461a9e8cf94282e0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.2/dbrain_v0.4.2_linux_arm64.tar.gz"
      sha256 "a6ed9507eb3422e8cc9f13d6476c46dbfa2cc2c69838fa2c27c1a84ba0c6383e"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.2/dbrain_v0.4.2_linux_amd64.tar.gz"
      sha256 "72b18714b6db71eeca3b0f03b1ac490f0ec3b3ab663fc85d192df7c563499eb6"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
