class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.10"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.10/dbrain_v0.2.10_darwin_arm64.tar.gz"
      sha256 "20db66d0344fa3535c817962b0805118029acb00049841156743429dbf58fd1b"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.10/dbrain_v0.2.10_darwin_amd64.tar.gz"
      sha256 "e3c5352ede08a357a7274cfffb7e45d45f914d3cef5c3d6fcf6fd0112017f423"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.10/dbrain_v0.2.10_linux_arm64.tar.gz"
      sha256 "4f69069a45ce9c70d6e08a65486f8a80ce8712c91be68afc802fe68c2bba7620"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.10/dbrain_v0.2.10_linux_amd64.tar.gz"
      sha256 "484b1f14e433fb21871c24ef69143b980a380be618814d3e51f7cfc4d8ae229b"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
