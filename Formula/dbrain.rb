class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.7.1"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  conflicts_with "dbrain-test", because: "both install the dbrain binary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.7.1/dbrain_v0.7.1_darwin_arm64.tar.gz"
      sha256 "80b48968e5ef1d295b00e395d2ad8be1259e215c968adbf2bff30142ccb0a718"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.7.1/dbrain_v0.7.1_darwin_amd64.tar.gz"
      sha256 "61298dc34f014505034e67ac93e5f0efc12311dcde7ef967c1d66239a0f9ccef"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.7.1/dbrain_v0.7.1_linux_arm64.tar.gz"
      sha256 "f33a91643ddc880e5b1654ac15a805fc6c98238486c13a92f12e6a9602e9f832"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.7.1/dbrain_v0.7.1_linux_amd64.tar.gz"
      sha256 "f58bd95bd49c330da41184269b08278e19c9c252874e5a77882267e2c1ac95d3"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
