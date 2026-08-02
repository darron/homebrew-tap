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
      url "https://github.com/darron/dbrain/releases/download/v0.8.2/dbrain_v0.8.2_darwin_arm64.tar.gz"
      sha256 "a9737f117cdead91f2d810cb1d59d3c3dcdb4ff359d5c20c7a829b118ce2d4b2"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.2/dbrain_v0.8.2_darwin_amd64.tar.gz"
      sha256 "d6bc962491158336a19f2b541d2794d0110d34f122e11aba9e723ab4a2fe1895"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.2/dbrain_v0.8.2_linux_arm64.tar.gz"
      sha256 "7df5d6538ea3f8f20dd7a3640932c3b85fe0d2dab620319e5e21fe47a2070723"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.2/dbrain_v0.8.2_linux_amd64.tar.gz"
      sha256 "dd3891a5624835506ddc35d74fa0f282adfce2a90e15894e250335c38e519ac4"
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
