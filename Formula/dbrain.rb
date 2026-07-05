class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.3.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.3.0/dbrain_v0.3.0_darwin_arm64.tar.gz"
      sha256 "e99ae52501d2a080bd7caab64454d1910c99cd0d4b1a8391c884cccad4355566"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.3.0/dbrain_v0.3.0_darwin_amd64.tar.gz"
      sha256 "5f38ee7208dc2e83b61606040b122b5d26ddc18c41b1d31ebc21d1581bae42aa"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.3.0/dbrain_v0.3.0_linux_arm64.tar.gz"
      sha256 "932d849a8c01ed66b32cf6feff52ac56c5e206809c2d5b30d05bd2b29382148c"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.3.0/dbrain_v0.3.0_linux_amd64.tar.gz"
      sha256 "e9656c700f0385a0e1340b56897a94e6674ebc95ba90949af2abfabae49cd956"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
