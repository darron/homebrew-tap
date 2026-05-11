class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.2"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.2/dbrain_v0.2.2_darwin_arm64.tar.gz"
      sha256 "37efc981c602e1df6082a783fcf0c8add801f3b03fda730a3c5f72457bc1038b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.2/dbrain_v0.2.2_darwin_amd64.tar.gz"
      sha256 "2cdeb86534c0fcee7846c499b48e1f57c47caf0efd6b65513e4f5b9213fb19fd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.2/dbrain_v0.2.2_linux_arm64.tar.gz"
      sha256 "c222b1a020acd73ff9c1aee93ea716f75bccbece2e6c4ef0abc88d4a953aff19"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.2/dbrain_v0.2.2_linux_amd64.tar.gz"
      sha256 "1ec4b65c5da2604a805c1df9ac073291550f83351d36bc0477015c9351b43a97"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
