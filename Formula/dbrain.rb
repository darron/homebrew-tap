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
      url "https://github.com/darron/dbrain/releases/download/v0.8.14/dbrain_v0.8.14_darwin_arm64.tar.gz"
      sha256 "e138681f1abeba35d340920f5edc409e36924e86646f3beb1619e4f710945b8a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.14/dbrain_v0.8.14_darwin_amd64.tar.gz"
      sha256 "2e2a8c7f67ee71a976dc4fdd2e63e6b8ce304d104fd746ca3e4273d241eb4b71"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.14/dbrain_v0.8.14_linux_arm64.tar.gz"
      sha256 "a60cf657bf66e5df5fe67b98a5f2b36d366eaffe147f563bcd696bb93f7fdb6c"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.14/dbrain_v0.8.14_linux_amd64.tar.gz"
      sha256 "d3a90d9b64d4e74e52e99914b6d14fcfe0494860725b5ba24e0cf516ab3a9e7e"
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
