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
      url "https://github.com/darron/dbrain/releases/download/v0.8.20/dbrain_v0.8.20_darwin_arm64.tar.gz"
      sha256 "ab003fc9a11bf438b9cb050c5a6f580d4f4b7b5108077f422339d4c7b4266e88"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.20/dbrain_v0.8.20_darwin_amd64.tar.gz"
      sha256 "4fb235930d028f3cb1b88cec65ea4742aca15de5da8e1e8f9bf76a20d02656aa"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.20/dbrain_v0.8.20_linux_arm64.tar.gz"
      sha256 "8867233a3adcb82458fd10116f7b2f47f8044d4b52547c8b171d4545e532f080"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.20/dbrain_v0.8.20_linux_amd64.tar.gz"
      sha256 "3ff3ab321cca32ac679466b6deb12b24c09ac1f77636389d9402200f8bec93ea"
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
