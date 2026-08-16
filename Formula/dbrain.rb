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
      url "https://github.com/darron/dbrain/releases/download/v0.8.17/dbrain_v0.8.17_darwin_arm64.tar.gz"
      sha256 "c1bc0cd99e1bdd35f86d187eebd30650b1f6c5dcb74f5087653346380b050d42"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.17/dbrain_v0.8.17_darwin_amd64.tar.gz"
      sha256 "ec18ad538f5ff14ef1261de186a0134a88ea2d390a5576d5751227774f961047"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.17/dbrain_v0.8.17_linux_arm64.tar.gz"
      sha256 "08e06580cbd088e295e02da0b04abde8cce08fd4c2fcfd74b34bb299449335bd"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.17/dbrain_v0.8.17_linux_amd64.tar.gz"
      sha256 "91c74462f8b59993f2724b5b269ebc326ad47f39589ee8a2f27cd193dd932291"
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
