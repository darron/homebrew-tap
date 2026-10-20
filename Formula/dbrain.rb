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
      url "https://github.com/darron/dbrain/releases/download/v0.8.25/dbrain_v0.8.25_darwin_arm64.tar.gz"
      sha256 "d34a97c241f3f7b4c6fda78d36fcd1a883a33e4c7d928f1576cf428a4ba05553"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.25/dbrain_v0.8.25_darwin_amd64.tar.gz"
      sha256 "386dafdae491ad7b700ec382be47784615d00418a92fe7ece1a74636ae1b551f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.25/dbrain_v0.8.25_linux_arm64.tar.gz"
      sha256 "796625af7bc9950b07e228fe747989f3e48f5a675182df442f105460974cea3c"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.25/dbrain_v0.8.25_linux_amd64.tar.gz"
      sha256 "9a525a21f49194536f3f8586ddf56268708b094d0e296a4da8b88ac6f43220cc"
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
