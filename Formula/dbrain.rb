class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.11"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.11/dbrain_v0.2.11_darwin_arm64.tar.gz"
      sha256 "f0acb3869dd81d52cd7d4e12e9652d3af8524bfe2a1b0813a2bc96ffb48c2b67"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.11/dbrain_v0.2.11_darwin_amd64.tar.gz"
      sha256 "b26a94ddb4f8cb4c95d73a23a36855b975154a0d04c2fa8db4f11a815e07c593"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.11/dbrain_v0.2.11_linux_arm64.tar.gz"
      sha256 "54240d754b33aa36fab4fda49c2965071b8d02d31402109764a329c2516c21eb"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.11/dbrain_v0.2.11_linux_amd64.tar.gz"
      sha256 "edd75c41c221fadc517005a94bcf72d92f8879d999917b0ea474eb8f8afd2bc8"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
