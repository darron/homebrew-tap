class DbrainTest < Formula
  desc "Local-first second-brain CLI test candidate"
  homepage "https://github.com/darron/dbrain"
  version "0.0.2.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-2-1-summarize-fix-95f7537f25cd/dbrain_homebrew-test-2-1-summarize-fix-95f7537f25cd_darwin_arm64.tar.gz"
      sha256 "6c0f69076316d870469e6688fec4c0b3477f9c6ba49f0af0c1ce496f788ce746"
    else
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-2-1-summarize-fix-95f7537f25cd/dbrain_homebrew-test-2-1-summarize-fix-95f7537f25cd_darwin_amd64.tar.gz"
      sha256 "93f5fcc9bbf8a62bca8b9699fa07fec5690803fd365f9d2d9354a91afb43231e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-2-1-summarize-fix-95f7537f25cd/dbrain_homebrew-test-2-1-summarize-fix-95f7537f25cd_linux_arm64.tar.gz"
      sha256 "787d49114d77a9ac891c79c7900636c936ac54c0110d5006eff122558b3752f8"
    else
      url "https://github.com/darron/dbrain/releases/download/homebrew-test-2-1-summarize-fix-95f7537f25cd/dbrain_homebrew-test-2-1-summarize-fix-95f7537f25cd_linux_amd64.tar.gz"
      sha256 "a958c5523cfcac2a8d564ffd4f8cf395f728800a8499f693ea25555515434248"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    output = shell_output("#{bin}/dbrain version")
    assert_match "release_version: test/summarize-fix@95f7537f25cd", output
    assert_match "commit: 95f7537f25cdec10d51eea732aaa7501ac2f4c07", output
  end
end
