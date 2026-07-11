class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.5.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.5.0/dbrain_v0.5.0_darwin_arm64.tar.gz"
      sha256 "87b5d3215309693d57d6b93897575d1775c838541973b9c330a006270c5b2f03"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.5.0/dbrain_v0.5.0_darwin_amd64.tar.gz"
      sha256 "f6b5558197d86581fcf9f0245a2b14a762254ee09ca35bba673b7446b0a10831"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.5.0/dbrain_v0.5.0_linux_arm64.tar.gz"
      sha256 "d96fa362de1e5fd0d9085d71ae0ca4031da44bb6329e8b3bfe44fdbc71c6c94d"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.5.0/dbrain_v0.5.0_linux_amd64.tar.gz"
      sha256 "2e9bab0c244ff87f50c4ec23898eb42bac8bead7cafe0fe50b943aaa575b87ca"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
