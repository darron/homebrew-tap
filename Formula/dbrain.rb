class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.3"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.3/dbrain_v0.1.3_darwin_arm64.tar.gz"
      sha256 "840c79e0da754d980bf513a16e5a54adfdd9fe7f137caee81e3c87043559e36f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.3/dbrain_v0.1.3_darwin_amd64.tar.gz"
      sha256 "874100a624b34aa80a3653879141b7f3a226cb785372c80fb178ec463aeb3990"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.3/dbrain_v0.1.3_linux_arm64.tar.gz"
      sha256 "291e2759716bea434d3fb33bcc9980f9d0de98d67db2d4a22319917da0762176"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.3/dbrain_v0.1.3_linux_amd64.tar.gz"
      sha256 "dd6c68e79f861f40e62dd413c7c01b055304a8e04c991f7f4af3d276d3c30028"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
