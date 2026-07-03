class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.25"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.25/dbrain_v0.2.25_darwin_arm64.tar.gz"
      sha256 "913a0f483c8d18595ea172f05cabfb1d2564c9d09c23f09e4544efd93df2f3f3"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.25/dbrain_v0.2.25_darwin_amd64.tar.gz"
      sha256 "f136cebea5a5f55585e50b9c54c5164ac53fb806e3468966e1087cb5f640c3de"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.25/dbrain_v0.2.25_linux_arm64.tar.gz"
      sha256 "e09dfaea29b44f0965d694885ee61750a3188a36e1ebabb620ca1fd2858fb034"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.25/dbrain_v0.2.25_linux_amd64.tar.gz"
      sha256 "f5e301afcbd91ee066f309752558d6927f37f81dda8a5d0514420716efd438d1"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
