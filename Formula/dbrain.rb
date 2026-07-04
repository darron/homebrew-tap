class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.26"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.26/dbrain_v0.2.26_darwin_arm64.tar.gz"
      sha256 "d4251c2df5bbb2c04b358cbf1826dc26baf1b42c4bd61076db22592d3d3d7e70"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.26/dbrain_v0.2.26_darwin_amd64.tar.gz"
      sha256 "4f8163719832f5cc1c305bbc67eee5c887570c8d11247253bfc9f2aea8c351da"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.26/dbrain_v0.2.26_linux_arm64.tar.gz"
      sha256 "fa1ed8f56733c3868e694c2339683d2f22c30282326df6885c375e5ad5a444bd"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.26/dbrain_v0.2.26_linux_amd64.tar.gz"
      sha256 "a4d8c2174f92b3424a295cd26576e5724defaa6bbb6b7f79c256c4636730e558"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
