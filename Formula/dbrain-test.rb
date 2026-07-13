class DbrainTest < Formula
  desc "Local-first second-brain CLI test candidate"
  homepage "https://github.com/darron/dbrain"
  version "0.0.1.1"
  license "MIT"

  conflicts_with "dbrain", because: "both install the dbrain binary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-1-1-security-harden-00b8d3dd9fc9/dbrain_homebrew-test-1-1-security-harden-00b8d3dd9fc9_darwin_arm64.tar.gz"
      sha256 "abb14ffe58f2f6cf60ed00a6f7bac14cb356715f7c94a32918652df7c661cdd1"
    else
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-1-1-security-harden-00b8d3dd9fc9/dbrain_homebrew-test-1-1-security-harden-00b8d3dd9fc9_darwin_amd64.tar.gz"
      sha256 "b010c49d9de3ea01eca28185e4f9e896e6477df50f7f1b0eb9b1f451ac4dbf0d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-1-1-security-harden-00b8d3dd9fc9/dbrain_homebrew-test-1-1-security-harden-00b8d3dd9fc9_linux_arm64.tar.gz"
      sha256 "176014526fc3f7ceddedbf75db91e400c25b7d0b054f41f30b00a4f119d9b7d8"
    else
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-1-1-security-harden-00b8d3dd9fc9/dbrain_homebrew-test-1-1-security-harden-00b8d3dd9fc9_linux_amd64.tar.gz"
      sha256 "509060a6209a81bc3cdf18efa1725e3d0a60f6c635ff8eced0b1080a71940874"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    output = shell_output("#{bin}/dbrain version")
    assert_match "release_version: test/security-harden@00b8d3dd9fc9", output
    assert_match "commit: 00b8d3dd9fc9227ada43f1ff8f8cf5ff66314c3e", output
  end
end
