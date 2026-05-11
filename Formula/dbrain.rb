class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.3"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.3/dbrain_v0.2.3_darwin_arm64.tar.gz"
      sha256 "b1a3a6dc75a3d7e10eeb2beea105931de1c915c90af7f999ea04d3a1d4fa9933"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.3/dbrain_v0.2.3_darwin_amd64.tar.gz"
      sha256 "1dbb56b8fb9d094aa2b33b68a811e0a147862e770b574a7be72cfac8129ce82f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.3/dbrain_v0.2.3_linux_arm64.tar.gz"
      sha256 "31d1e93502102ed9b53f4e3cbdd04bab1e241c835580d0d69aa1c30fcf32dd4b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.3/dbrain_v0.2.3_linux_amd64.tar.gz"
      sha256 "3b80abb3d98732b16aa0f4b29da4f9995668f72802768b9636c93fd36cbf57be"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
