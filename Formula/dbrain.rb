class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.2.15"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.15/dbrain_v0.2.15_darwin_arm64.tar.gz"
      sha256 "e82193382fb4ff9bcadb9872178a1dc6e090cab8e9b82da543189e2750c65f21"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.15/dbrain_v0.2.15_darwin_amd64.tar.gz"
      sha256 "7f416a841e93c90bb3cab9e9bb6eef0b5c47aa7c575fd914b04db202baf91ab8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.2.15/dbrain_v0.2.15_linux_arm64.tar.gz"
      sha256 "c3f23dd9980b59ba1e29eebaa676aaf80881ee4003e431b862a195fe8c23c94f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.2.15/dbrain_v0.2.15_linux_amd64.tar.gz"
      sha256 "d715ee52dcf520ef47208649bdac573327088587f81acfdfc46e8a6e9672a3af"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
