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
      url "https://github.com/darron/dbrain/releases/download/v0.8.15/dbrain_v0.8.15_darwin_arm64.tar.gz"
      sha256 "901ccbbc287477a62321df9c1d40d6219b152a12fb7c5a2b9c4ee7fb3ae2fc7d"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.15/dbrain_v0.8.15_darwin_amd64.tar.gz"
      sha256 "a91fdd601faf8e1018dcbdb6f1b234de83b54799c2c49d399bcdc26c7e0db2a5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.15/dbrain_v0.8.15_linux_arm64.tar.gz"
      sha256 "26182f43d1d58b23f0166cdf9cd17e2af492d0968327ef4ccd7bfacddf534a60"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.15/dbrain_v0.8.15_linux_amd64.tar.gz"
      sha256 "aa3ba0988f18d57aa1fb76091d58913b80688aa7e76d6c2db050b5e36b8d4e4c"
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
