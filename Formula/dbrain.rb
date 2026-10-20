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
      url "https://github.com/darron/dbrain/releases/download/v0.8.24/dbrain_v0.8.24_darwin_arm64.tar.gz"
      sha256 "554d13d5c2f2891e706dbb811fc499d0f38e61f24f37f666f24e80056da0919f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.24/dbrain_v0.8.24_darwin_amd64.tar.gz"
      sha256 "5886719073c03927572048d2eb7d2e5c3a72c5d6f3774c5286c9fe3b029d9571"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.24/dbrain_v0.8.24_linux_arm64.tar.gz"
      sha256 "47f2a342b7dbe8ab200ef0df7f9b7ed0ee9c6b44f729325d0635fd3c098133b5"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.24/dbrain_v0.8.24_linux_amd64.tar.gz"
      sha256 "3ff7d18fa59077bca1a66fd8bc2d751bda8a11ebbb27276ea11739314c1beca3"
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
