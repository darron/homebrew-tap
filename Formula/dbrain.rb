class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.4.3"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.3/dbrain_v0.4.3_darwin_arm64.tar.gz"
      sha256 "35d3861e70109f359d20a82612cd3bdcecabbe5b6f6d0662b654304dc9dff591"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.3/dbrain_v0.4.3_darwin_amd64.tar.gz"
      sha256 "25f960b33694b640c92e32b47ecf3e01308867d7ec6d1897997a09b94219854d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.4.3/dbrain_v0.4.3_linux_arm64.tar.gz"
      sha256 "f29daa7f7396f6af47f93469927fc58e2b3bf0ead5cde1fc9b03fd2ba0c658e0"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.4.3/dbrain_v0.4.3_linux_amd64.tar.gz"
      sha256 "8638eae46a90f28383e74f1a31b8ae6e742c97ab06a396728e9116fb9923d365"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
