class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.4"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.4/dbrain_v0.2.4_darwin_arm64.tar.gz"
      sha256 "b6d616410011fe28ce3dae22296e3f57af92cdd26b27f1049e90910cface3968"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.4/dbrain_v0.2.4_darwin_amd64.tar.gz"
      sha256 "8cd6b62678090614f32cab7350455f0aeb3dd2d86ee16b47983e681fd8208639"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.4/dbrain_v0.2.4_linux_arm64.tar.gz"
      sha256 "9207b48cd645b5a8c6d0a2e0ba6626fdd701714706dbfa1795b3b29e944f6011"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.4/dbrain_v0.2.4_linux_amd64.tar.gz"
      sha256 "53a76c7615fec5f0efa2f0e2dc4e2047d95101e2ce83c6a79391e2b9abfc7f71"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
