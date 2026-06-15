class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.17"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.17/dbrain_v0.2.17_darwin_arm64.tar.gz"
      sha256 "1e5cf344df1c377230262f459d3481d633507847320e991dd2110529173740ae"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.17/dbrain_v0.2.17_darwin_amd64.tar.gz"
      sha256 "d53388d1e82a9625b7c821fc6203e18299ca49829f151c02797f457c5375fb5c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.17/dbrain_v0.2.17_linux_arm64.tar.gz"
      sha256 "d6cdfe3a18a21078a409210063b1e146cc5b7c54941c099dd9615dcd140282f6"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.17/dbrain_v0.2.17_linux_amd64.tar.gz"
      sha256 "7647fe766881b1b17621ff49b081cfe9f259b88a89ce01c02293c0ff5f91d0e1"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
