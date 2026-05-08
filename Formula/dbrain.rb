class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.5"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.5/dbrain_v0.1.5_darwin_arm64.tar.gz"
      sha256 "d5e7c4b74a6918c09a1e6d8231ef119fe17d92da2b9582de7d53259fe7061326"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.5/dbrain_v0.1.5_darwin_amd64.tar.gz"
      sha256 "71311945b6350c7fe61342eddf7b99360be8ff0f09ec60c1ebac8cbfa0dc0c42"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.1.5/dbrain_v0.1.5_linux_arm64.tar.gz"
      sha256 "58bf645f9620baf8999b9c07011e5f947c5b5daa925657e2a5506807243793b1"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.1.5/dbrain_v0.1.5_linux_amd64.tar.gz"
      sha256 "7ab53750416577fcb094cb4b91eb05427270fe657db4e23a4163beeb7312cd93"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
