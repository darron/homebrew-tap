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
      url "https://github.com/darron/dbrain/releases/download/v0.8.26/dbrain_v0.8.26_darwin_arm64.tar.gz"
      sha256 "af9955ef567a45a446a8ea61b93817514ff393371021b5a4be06adb650cbb01a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.26/dbrain_v0.8.26_darwin_amd64.tar.gz"
      sha256 "6ca34fcbc9e82ac01010ff95c6f0be28fb147a9c75efeb7d21e4076c58014dcf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.26/dbrain_v0.8.26_linux_arm64.tar.gz"
      sha256 "a99d09576ff71f24f9537a6ff3f879785bc285fafac5d8bd6afb067d81d68df0"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.26/dbrain_v0.8.26_linux_amd64.tar.gz"
      sha256 "a0a960958fb46d0fae21d607daf62a71590e55822c5732ed13c67b108284a4a9"
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
