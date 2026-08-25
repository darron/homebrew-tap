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
      url "https://github.com/darron/dbrain/releases/download/v0.8.19/dbrain_v0.8.19_darwin_arm64.tar.gz"
      sha256 "f5b9458d1aa039933c1f73fb38134c4f0020952e3304ad74b0a2041cf8c7a942"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.19/dbrain_v0.8.19_darwin_amd64.tar.gz"
      sha256 "2c2077d9f7d1a6c13731ebdc6fe59afe464af34275cf561591e044f39ab1bee1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.19/dbrain_v0.8.19_linux_arm64.tar.gz"
      sha256 "14ce15801d95c2dbe8d90d89a7d041bf4b22505052b6c3ae41e051948d7877cf"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.19/dbrain_v0.8.19_linux_amd64.tar.gz"
      sha256 "634f0950d619e9ac4e2da76a210b24f5e9c8504bd38f077f199e41e922964815"
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
