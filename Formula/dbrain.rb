class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  license all_of: ["MIT", "Apache-2.0"]
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.18/dbrain_v0.8.18_darwin_arm64.tar.gz"
      sha256 "d2d31367a421d09eea66d1a6fcd6b4cb1da40c9ca384c6686003087ceecbb184"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.18/dbrain_v0.8.18_darwin_amd64.tar.gz"
      sha256 "e8a4ac451610c62fb32c5a407dd5bf8a258a8cc4783ab367cf9629508ca70a5e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.18/dbrain_v0.8.18_linux_arm64.tar.gz"
      sha256 "50cc135ebf68353318239fc12a9cb4316fcb90ebf5d7ca08e9a1d50909cd028b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.18/dbrain_v0.8.18_linux_amd64.tar.gz"
      sha256 "6695fc44464760b9bb9d100ce649fbbf65ee503283d5989a3b93eaacb6d3fa36"
    end
  end

  def install
    bin.install "dbrain"
    pkgshare.install "THIRD_PARTY_NOTICES.md", "LICENSE-USearch"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
    status = shell_output(
      "#{bin}/dbrain --root #{testpath}/dbrain --no-debug semantic status --json",
    )
    if OS.mac? && Hardware::CPU.arm?
      assert_match '"state": "supported_ready"', status
      assert_match '"backend": "usearch"', status
      assert_match '"version": "2.26.0"', status
    else
      assert_match '"state": "unsupported"', status
    end
  end
end
