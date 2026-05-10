class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.0/dbrain_v0.2.0_darwin_arm64.tar.gz"
      sha256 "138d6e2c5c4577496a5efa7407543233b445b88a9d00624410f44ec69cf7ea33"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.0/dbrain_v0.2.0_darwin_amd64.tar.gz"
      sha256 "9df208279e66ed2478ae4f38401cd0f7cb78c1a95aa6c4ed9f5365e5dd6c1184"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.0/dbrain_v0.2.0_linux_arm64.tar.gz"
      sha256 "90e921196c83d8c7be35a79c6b0c9153db46de5127892252584279b66e19c84b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.0/dbrain_v0.2.0_linux_amd64.tar.gz"
      sha256 "2c811113f896fc8d3d2a66d4b781ec528575eed8f30d22621272324685572308"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
