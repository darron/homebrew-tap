class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.7"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.7/dbrain_v0.2.7_darwin_arm64.tar.gz"
      sha256 "f115e904cd524e7ae181a685fe7b79702dcf1b6ffac3ad6b31597ec3c4b7f162"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.7/dbrain_v0.2.7_darwin_amd64.tar.gz"
      sha256 "ead512d40ced65302cb4caae97f042b9432a715924975f52a579b298b4781ea0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.7/dbrain_v0.2.7_linux_arm64.tar.gz"
      sha256 "dd1277831a3dc989c7239f6cd0f63993192d83dc19cbc2961658bf4db1ed721f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.7/dbrain_v0.2.7_linux_amd64.tar.gz"
      sha256 "70a21f7a64ef6d5eb672cdb76dcec5831300ed9ce694f377c862517b0c013c75"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
