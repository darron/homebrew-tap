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
      url "https://github.com/darron/dbrain/releases/download/v0.8.1/dbrain_v0.8.1_darwin_arm64.tar.gz"
      sha256 "944e9c3a39ca2e5fd7c6d536cdd6de35cda8fcbd304254a8d850a1c12efb0393"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.1/dbrain_v0.8.1_darwin_amd64.tar.gz"
      sha256 "b4fa671c7851fd7f1bf62537f59cb4597d229bb0c29c4fb912768614cf23ca59"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.1/dbrain_v0.8.1_linux_arm64.tar.gz"
      sha256 "477601d80daa30a3e7d0bd30822384aab543df3fdc584ece9a3e88091e7d6bda"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.1/dbrain_v0.8.1_linux_amd64.tar.gz"
      sha256 "8524468623cd31b466ce0369bf2cfe4c66f200f6c1669ee442b0577641a9dd32"
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
