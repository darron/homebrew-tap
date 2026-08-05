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
      url "https://github.com/darron/dbrain/releases/download/v0.8.9/dbrain_v0.8.9_darwin_arm64.tar.gz"
      sha256 "edac981e597d8f389b97a644b6daaf06359c6636a05a889e0eff8b535c9313e0"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.9/dbrain_v0.8.9_darwin_amd64.tar.gz"
      sha256 "4315357d61e114755d406774632b352a728d800984498f26b8a8316be75ce5e3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.9/dbrain_v0.8.9_linux_arm64.tar.gz"
      sha256 "4bfb05d5e250bd3f427efae5380175365048503fa6c9d4ca937e5b7604273f6b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.9/dbrain_v0.8.9_linux_amd64.tar.gz"
      sha256 "88bcc7065a20b3246c8f7580574b7793b524e182456edf3bc27bf55274118973"
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
