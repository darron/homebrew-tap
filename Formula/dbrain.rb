class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.6"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.6/dbrain_v0.1.6_darwin_arm64.tar.gz"
      sha256 "53058d4fe5b609ab00fcd870c947ee1e4f14fb3aabb52726337598a2f9ab224b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.6/dbrain_v0.1.6_darwin_amd64.tar.gz"
      sha256 "e0cd40e72be681f1b165ceba67aedc43ff385a624723692c2529aed328ec704d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.6/dbrain_v0.1.6_linux_arm64.tar.gz"
      sha256 "6eda08a04dcf9bd2eca5e504564c25202a2194c779c4b1972f04467825c55483"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.6/dbrain_v0.1.6_linux_amd64.tar.gz"
      sha256 "128e7c7d96ffabeef3966f89e3a6fcbb4e81bc31b80b1f2871a69d104213c16c"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
