class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.16"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.16/dbrain_v0.2.16_darwin_arm64.tar.gz"
      sha256 "a9ac449173730b9665a3a8348e1718786bc4aefff4686c5afaf64bebae984231"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.16/dbrain_v0.2.16_darwin_amd64.tar.gz"
      sha256 "b026139201ecb26c57b1bd416848e73b2f372d0d85521718c915ea4b27ca61ce"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.16/dbrain_v0.2.16_linux_arm64.tar.gz"
      sha256 "101caefef3d35826210f6bfb4f5a903724b51a2b5b76e6a05242f4bb30782d65"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.16/dbrain_v0.2.16_linux_amd64.tar.gz"
      sha256 "f5741fdbba1a72fed43e9468b6f0f406f7df3f6bb4932107ffc38397a44b0d2d"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
