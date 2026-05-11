class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.1"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.1/dbrain_v0.2.1_darwin_arm64.tar.gz"
      sha256 "f46c48dfaf5b839e8a0993db6dd9788d8a78ba9287a799d441b7818dfde607bb"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.1/dbrain_v0.2.1_darwin_amd64.tar.gz"
      sha256 "4c4c39c7b3adc45eb8545f3b110a494fb043aed20f69f7bfe5cae5ad46193b89"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.1/dbrain_v0.2.1_linux_arm64.tar.gz"
      sha256 "0584cfab1bf56191a3187106c72758b46493b6923cb1255d68f0383c5e2697c3"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.1/dbrain_v0.2.1_linux_amd64.tar.gz"
      sha256 "5217769a1a17269f371c4ce88f58668190ea26c8b3da5d755ba6f27a7756e108"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
