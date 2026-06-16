class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.19"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.19/dbrain_v0.2.19_darwin_arm64.tar.gz"
      sha256 "3a34e0c642ccdeb0eea05057bdad923daf99ec1daffee359529bdc42172cca05"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.19/dbrain_v0.2.19_darwin_amd64.tar.gz"
      sha256 "b651c99e216bca7c7f223889baeb818d87a8f50c2bdbca3f8c3a83111bd94591"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.19/dbrain_v0.2.19_linux_arm64.tar.gz"
      sha256 "256872d17f4184860d463261528315a9388d5d5256e6b6d35e164e7ac270064d"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.19/dbrain_v0.2.19_linux_amd64.tar.gz"
      sha256 "6ce0bc1327ff70b90b23ef6be3292c235eaed5b6a5a8aa12754f8664364d9010"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
