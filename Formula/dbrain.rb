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
      url "https://github.com/darron/dbrain/releases/download/v0.8.10/dbrain_v0.8.10_darwin_arm64.tar.gz"
      sha256 "a23be2eaac0706e14b3943f1950514b04ace5b572e067acc9c12a593d00bc476"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.10/dbrain_v0.8.10_darwin_amd64.tar.gz"
      sha256 "8a0fb123094151afe840da7ee331b95b4c69ce298285c6b583745ec811af1a49"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.10/dbrain_v0.8.10_linux_arm64.tar.gz"
      sha256 "92ebcbd1d3379bf728d5551d9feac084dc66aee6ebcff0c70ebe3ec6b8c98111"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.10/dbrain_v0.8.10_linux_amd64.tar.gz"
      sha256 "e1ccfb41dd2e7a44431cf935087c1d6a62c872352350bbd5d75819e7cae6d67e"
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
