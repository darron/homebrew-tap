class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.5.1"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.5.1/dbrain_v0.5.1_darwin_arm64.tar.gz"
      sha256 "0b475fc8abb9415b41c1851144080beb0b3ffd74e1ceef2db04772126f38b92c"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.5.1/dbrain_v0.5.1_darwin_amd64.tar.gz"
      sha256 "2703ba2b946fbfe571c47c7644a0a71c98485a8dbb205a90eff627f3311081bf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.5.1/dbrain_v0.5.1_linux_arm64.tar.gz"
      sha256 "aa331017070f1be6af7c29c627f0ce02c778499a8bc2bd99d22ae5825afa5cbc"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.5.1/dbrain_v0.5.1_linux_amd64.tar.gz"
      sha256 "407caee6ded8a4a02bf92e834021dd09f4d55fa2031c8f55f8135691d16acbc1"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
