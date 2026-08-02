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
      url "https://github.com/darron/dbrain/releases/download/v0.8.0/dbrain_v0.8.0_darwin_arm64.tar.gz"
      sha256 "52eb6d9b3b5e20c0fecea9107c939e03ebede6b4f9b87ccc4a7e00ef6be4aec1"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.0/dbrain_v0.8.0_darwin_amd64.tar.gz"
      sha256 "a41b8e848d56b4c39f56c9b4a782ea71bcb55f8c2cd8c3648be59c1710922899"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.0/dbrain_v0.8.0_linux_arm64.tar.gz"
      sha256 "f962df5e2eb8648e76274f3118921da973e3dcb840e71c42d537ca953a571a12"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.0/dbrain_v0.8.0_linux_amd64.tar.gz"
      sha256 "fa366a1ad9e09f40a4987b6598ebec05b9464d883e413c9ec4cae103fcb10ad2"
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
