class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.1"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_darwin_arm64.tar.gz"
      sha256 "90b01c551ce40b38f6c7a51550595936961e8ca8b91840c7fada915eccd995a2"
    else
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_darwin_amd64.tar.gz"
      sha256 "d1f69de4d8a8dd5eb2167827ff1af982e2b1ae56442df59857c2affe9bf3fd69"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_linux_arm64.tar.gz"
      sha256 "c0df4292643e5dcbbd3c710847642ed55c4c3df0ba397d1dd8794a41c20aed04"
    else
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_linux_amd64.tar.gz"
      sha256 "6a960f7799403597c1789d389c8e1adc0a7b373149b5c3692b96dc1e13dcb889"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
