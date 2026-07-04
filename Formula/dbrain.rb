class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.28"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.28/dbrain_v0.2.28_darwin_arm64.tar.gz"
      sha256 "e827e31c1d33325b3eb7cd4557dc5b2060361898413e7be3c90dd87e32cce194"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.28/dbrain_v0.2.28_darwin_amd64.tar.gz"
      sha256 "01ba8b49abf01e051b02c7124c853ea5c190f0a9400cb94bd0e8876340e5def6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.28/dbrain_v0.2.28_linux_arm64.tar.gz"
      sha256 "d4ba7c747196f6dd97b68033cbb93f576ccbd16e8bad1757b404ee2b8c0b35cb"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.28/dbrain_v0.2.28_linux_amd64.tar.gz"
      sha256 "af6749067ebb36ebb9bddf19ae7d2b2e8c909eb07fe6bf7f8d37129473d91815"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
