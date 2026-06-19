class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.20"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.20/dbrain_v0.2.20_darwin_arm64.tar.gz"
      sha256 "2b0c2c7d55537c2460649789eef663a356268d71f5f9515d1b49d004917aab78"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.20/dbrain_v0.2.20_darwin_amd64.tar.gz"
      sha256 "34f0e9159054f41fee3eecefbb15d4c3c1cbd2cb791e22d083d54b559f432b88"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.20/dbrain_v0.2.20_linux_arm64.tar.gz"
      sha256 "b949e4f367fd2c21ab6e82002996f0fc5e4d417bf46d134e641dad6d608235c3"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.20/dbrain_v0.2.20_linux_amd64.tar.gz"
      sha256 "6c3d81ea987c04fa96e187840e278fae9ff9ab461e90450ef4ab5fe3c56b7c78"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
