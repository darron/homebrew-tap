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
      url "https://github.com/darron/dbrain/releases/download/v0.8.7/dbrain_v0.8.7_darwin_arm64.tar.gz"
      sha256 "d6014c1f5ada053d5a78d8b86aff089100cf6648a1aea43378ef4fed46f233c5"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.7/dbrain_v0.8.7_darwin_amd64.tar.gz"
      sha256 "d797ff78e1ceea91fe559f72289db2afc20c1b4d1bd57f97877d98717e420e52"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.7/dbrain_v0.8.7_linux_arm64.tar.gz"
      sha256 "4c75111ce9cb5cf9a722ea00aa997dadb1b62856dae22bef151ed3b87f8a2dc8"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.7/dbrain_v0.8.7_linux_amd64.tar.gz"
      sha256 "c7f10ab278112739207b3873765e420fad8ab20e0c1f865d4d20c763248f7a76"
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
