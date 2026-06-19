class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.21"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.21/dbrain_v0.2.21_darwin_arm64.tar.gz"
      sha256 "3a0da2767eb1ed49f340e6c0b073afb63500e6141f06a0131a28ff778a22d933"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.21/dbrain_v0.2.21_darwin_amd64.tar.gz"
      sha256 "e774bf4512a7505f55494bfe8d59136f2f9e3f0800a91fa5e0887fe7f9af54f1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.21/dbrain_v0.2.21_linux_arm64.tar.gz"
      sha256 "7fdf7cf9acd7409cd7b7cebf0025b5a8ff30a04bb708c2ae8c96ae4fc3857575"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.21/dbrain_v0.2.21_linux_amd64.tar.gz"
      sha256 "06ad2ea81519e19d2dddd20ed087b8b41a1701ccd5d8ce1c8b2fbcbf6355fb43"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
