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
      url "https://github.com/darron/dbrain/releases/download/v0.8.12/dbrain_v0.8.12_darwin_arm64.tar.gz"
      sha256 "d90506aa8fc4d5a658ec6ef32b1e27210f9fcb192d9a0dc363cd2c1e7f8fce49"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.12/dbrain_v0.8.12_darwin_amd64.tar.gz"
      sha256 "d67b9bec13e2565eb9a4ac0575e89d8e3fcb0fd3e5341cf28c4e3576913dabfd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.12/dbrain_v0.8.12_linux_arm64.tar.gz"
      sha256 "77fadad822b180e4e8ac5d901ddf101d3039e8ce0c91e647af02ab01b71886a7"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.12/dbrain_v0.8.12_linux_amd64.tar.gz"
      sha256 "5cdea80b11142338a928acac589ed014c819b783d3e22837324589e3a249c49d"
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
