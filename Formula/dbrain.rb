class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.23"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.23/dbrain_v0.2.23_darwin_arm64.tar.gz"
      sha256 "758487148284a735fea62842707d24b0aa5f804a5b3abc7ee8056442bf98475a"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.23/dbrain_v0.2.23_darwin_amd64.tar.gz"
      sha256 "21d4bc8583cbd2b48d7e678d130d2cb4f63702c5638dd81aa32eb656b54bceb6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.23/dbrain_v0.2.23_linux_arm64.tar.gz"
      sha256 "7b50e7574e183cc042021e02628288fde5af36eccc4135c4e29bb3d7bc44a707"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.23/dbrain_v0.2.23_linux_amd64.tar.gz"
      sha256 "4b664017a04abca16ad0e0b099c7cbfa75362d628823e63ba274764d8882a3b6"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
