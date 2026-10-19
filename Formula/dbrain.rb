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
      url "https://github.com/darron/dbrain/releases/download/v0.8.22/dbrain_v0.8.22_darwin_arm64.tar.gz"
      sha256 "4b746f8fabc746dbe36f60c6bac776f127181326307bc4aa57de586d15b01932"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.22/dbrain_v0.8.22_darwin_amd64.tar.gz"
      sha256 "93726a324eb0489e20338d4c7bc49b55268045c05b0b15dc5aa7bae335939e49"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.22/dbrain_v0.8.22_linux_arm64.tar.gz"
      sha256 "5a0eafdacc1653b578de627247d9a6ed7649a251225062ad57896b2723a4f25a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.22/dbrain_v0.8.22_linux_amd64.tar.gz"
      sha256 "3d2ed8ecdea766f8f755bb54fa81c5ed28c580b31010aebdb6c7a601c1806cf9"
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
