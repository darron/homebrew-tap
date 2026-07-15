class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.7.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  conflicts_with "dbrain-test", because: "both install the dbrain binary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.7.0/dbrain_v0.7.0_darwin_arm64.tar.gz"
      sha256 "b62048cbeb4b6e4d5f13c205c7e841614bd46531a007f1eed9a960c3227a9037"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.7.0/dbrain_v0.7.0_darwin_amd64.tar.gz"
      sha256 "09f630c37018034b746d4abc10931b0579764c2888cb056d40c904c90882ca12"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.7.0/dbrain_v0.7.0_linux_arm64.tar.gz"
      sha256 "32bf1ece0a4fa7df1191f191c1483bbc7bce17508e06e4b068a9e721254ae8a6"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.7.0/dbrain_v0.7.0_linux_amd64.tar.gz"
      sha256 "adc931c024518734cfbaed4b5b4110c138c1e412002d473418e48349bbde3365"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
