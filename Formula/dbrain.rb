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
      url "https://github.com/darron/dbrain/releases/download/v0.8.8/dbrain_v0.8.8_darwin_arm64.tar.gz"
      sha256 "04f74a1d4a0f3793ca78eaf98e2eb6a28917684ea673ea4bff8b1eae91a784a0"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.8/dbrain_v0.8.8_darwin_amd64.tar.gz"
      sha256 "37a25834c893dff57757cdcf53293499c3521a97bf79091feb7a6d09b50b006d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.8/dbrain_v0.8.8_linux_arm64.tar.gz"
      sha256 "abab07825a2e9db95885a5151f46df9b2fd454b8c4a636151230f5c73771b63a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.8/dbrain_v0.8.8_linux_amd64.tar.gz"
      sha256 "3778e603f1fac08eb27fafcce1f845c0271d07e5a53fd86cf2e38546a1d2319c"
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
