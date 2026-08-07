class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  license all_of: ["MIT", "Apache-2.0"]
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.11/dbrain_v0.8.11_darwin_arm64.tar.gz"
      sha256 "0043cc70f2e200efce60e89a66e3f58493c7cfb47787f0070e41729d04e1489f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.11/dbrain_v0.8.11_darwin_amd64.tar.gz"
      sha256 "29373f0fd82eacd26b1721eaee0cecd09624c367b349e119fe7dc56e7c1a18a8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.11/dbrain_v0.8.11_linux_arm64.tar.gz"
      sha256 "9f7a487b807736a6d1d15444a3464354cade84cfc80d8ee02d3b73cdbb772d6e"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.11/dbrain_v0.8.11_linux_amd64.tar.gz"
      sha256 "6675c46793e5cf07f69dec1961ef6b22cf01084b1ea91899b04012400b6ebddc"
    end
  end

  def install
    bin.install "dbrain"
    pkgshare.install "THIRD_PARTY_NOTICES.md", "LICENSE-USearch"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
    status = shell_output(
      "#{bin}/dbrain --root #{testpath}/dbrain --no-debug semantic status --json",
    )
    if OS.mac? && Hardware::CPU.arm?
      assert_match '"state": "supported_ready"', status
      assert_match '"backend": "usearch"', status
      assert_match '"version": "2.26.0"', status
    else
      assert_match '"state": "unsupported"', status
    end
  end
end
