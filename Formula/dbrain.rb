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
      url "https://github.com/darron/dbrain/releases/download/v0.8.3/dbrain_v0.8.3_darwin_arm64.tar.gz"
      sha256 "312d5309309e054630fcfd894fe131f29980cf9f890d2c7146b97c01539d8315"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.3/dbrain_v0.8.3_darwin_amd64.tar.gz"
      sha256 "22fea4a7e8efff37062420e95917157251c7552eb41a9bab1aa8e7cf1b09699d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.3/dbrain_v0.8.3_linux_arm64.tar.gz"
      sha256 "9a7afa07855677db1340e75d443c99b5e58ff44ff619d2fc716146ffe8644a43"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.3/dbrain_v0.8.3_linux_amd64.tar.gz"
      sha256 "8ff6b1256428cb6c38b63b07abc1c39a513537fac0c4eca230e8d9a41edcf230"
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
