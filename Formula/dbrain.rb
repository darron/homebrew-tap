class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.5"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.5/dbrain_v0.2.5_darwin_arm64.tar.gz"
      sha256 "1978073ef04a32a4267bcff1c6028d661c8710e1871a812b2ab821c02ea24339"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.5/dbrain_v0.2.5_darwin_amd64.tar.gz"
      sha256 "e9f3f3586da557a2b8a5ecd8444e052a2c2f735807517a3f23ed2ba1aee42ff1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.5/dbrain_v0.2.5_linux_arm64.tar.gz"
      sha256 "b868ebbbca7e67b508a3ed1d5c9b9561588401a7211a466f5ba870c9ceca6921"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.5/dbrain_v0.2.5_linux_amd64.tar.gz"
      sha256 "189d95a3ee5585dee1b913ba5a08187b4fc2e9c03a2db8220855894d4ea78aa3"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
