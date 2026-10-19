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
      url "https://github.com/darron/dbrain/releases/download/v0.8.23/dbrain_v0.8.23_darwin_arm64.tar.gz"
      sha256 "f1986b70bc9fe630fc179d4e0173d1a1c7361325b1ecaff08e8ccdaf42c85e24"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.23/dbrain_v0.8.23_darwin_amd64.tar.gz"
      sha256 "544ea5f60ce17d5fa34c2f42907c0cbc83dd3ad9749d74693e799ee1cb6198b0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.23/dbrain_v0.8.23_linux_arm64.tar.gz"
      sha256 "6bf60f9f4e49dbc46224721e5b6c2da0718d4f0e5e5b52f2164493b99d4218e9"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.23/dbrain_v0.8.23_linux_amd64.tar.gz"
      sha256 "576afc4776cda270d640003b6ed46dfd51fea2b682eb5ac0e0d822bb6a8baa3f"
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
