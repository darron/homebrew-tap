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
      url "https://github.com/darron/dbrain/releases/download/v0.8.5/dbrain_v0.8.5_darwin_arm64.tar.gz"
      sha256 "ef83f57fda0ae4f49f3e7507985d532487ea170ceabce854a307cbe9af614cc0"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.5/dbrain_v0.8.5_darwin_amd64.tar.gz"
      sha256 "740a53ebebfddae3dcda0f14bb1474dd4555e94340e4c940a63f12181790b1e8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.5/dbrain_v0.8.5_linux_arm64.tar.gz"
      sha256 "9b39e67abfa0902341ab3986321e2af5f8d4cd18d85df195fc7cd6e38248a570"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.5/dbrain_v0.8.5_linux_amd64.tar.gz"
      sha256 "6c1f7121fabc3e16660d93988a81dd4f93a5722c34795991fb138a53d28b4639"
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
