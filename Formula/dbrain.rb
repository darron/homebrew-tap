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
      url "https://github.com/darron/dbrain/releases/download/v0.8.13/dbrain_v0.8.13_darwin_arm64.tar.gz"
      sha256 "edbcc2f70b00592036b07ec3aa64f13d8da522ce54ae47a894e9a56f2ab5600f"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.13/dbrain_v0.8.13_darwin_amd64.tar.gz"
      sha256 "fbe065a7c98c912bb43fabc137fc03f2787e2380e2fda28f425626f23edafb5b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.13/dbrain_v0.8.13_linux_arm64.tar.gz"
      sha256 "5be93ec8068ce6541dad74d7429bf74264de5dd51db476244726ad18a2b035d1"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.13/dbrain_v0.8.13_linux_amd64.tar.gz"
      sha256 "316a7727f416145001256fe26abdbb6bbaec1b6ce1057f6bf9f34e1ca24a8d82"
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
