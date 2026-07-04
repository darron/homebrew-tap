class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.27"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.27/dbrain_v0.2.27_darwin_arm64.tar.gz"
      sha256 "24d7be09ce8ca315ed30a6837be62092ac945c8e0c692975f9dc08aa1cf1280f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.27/dbrain_v0.2.27_darwin_amd64.tar.gz"
      sha256 "b01d773aea3127eb4516635b76bbd649f5ca5d598966a0d5cd02fbe1420d7c20"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.27/dbrain_v0.2.27_linux_arm64.tar.gz"
      sha256 "e3bc105dac3618e60c93b6616650956e8ed3153c5b23c98d7d6cebb9f8472522"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.27/dbrain_v0.2.27_linux_amd64.tar.gz"
      sha256 "cf98df45969bd9a1300b981fa4bcc0ce0eab3f60e2528e7f648239f2347eb55d"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
