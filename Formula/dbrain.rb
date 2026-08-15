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
      url "https://github.com/darron/dbrain/releases/download/v0.8.16/dbrain_v0.8.16_darwin_arm64.tar.gz"
      sha256 "b23dbae16c964e6edf03404b5fbad3d80191f51195934280e56cb6b261982111"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.16/dbrain_v0.8.16_darwin_amd64.tar.gz"
      sha256 "d400f6b96c474515dc1ab6eb913fa808caa8642d38ad88175a845a6b24168485"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.16/dbrain_v0.8.16_linux_arm64.tar.gz"
      sha256 "669c3b3bf2b84b4e9539243ee7328c8e755810d15786bb3db967ac896474aaa8"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.16/dbrain_v0.8.16_linux_amd64.tar.gz"
      sha256 "b4a711ec3b2c2b7d39cc073211ea065ed159d87b372df74374fe00195b4fd4b2"
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
