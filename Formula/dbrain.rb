class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.9"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.9/dbrain_v0.1.9_darwin_arm64.tar.gz"
      sha256 "91c3f3cab3816aab27a73b42673196e230df9e4b7d4ba1872b5ff72ea94333ef"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.9/dbrain_v0.1.9_darwin_amd64.tar.gz"
      sha256 "c9490b030eaf6b69731236c661d764934ef18101b2ea25ce7115abe50c521bfe"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.9/dbrain_v0.1.9_linux_arm64.tar.gz"
      sha256 "42b66c5ac6464ddf3e7d208a1fd101106da73eb4491827473835129cd5bf29c1"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.9/dbrain_v0.1.9_linux_amd64.tar.gz"
      sha256 "56e3f42399ad1bea2fd540fb2f7f90c0fcd5ce372bd0b1c18b1f43c23dc8411b"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
