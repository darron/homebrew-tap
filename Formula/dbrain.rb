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
      url "https://github.com/darron/dbrain/releases/download/v0.8.6/dbrain_v0.8.6_darwin_arm64.tar.gz"
      sha256 "36c044b8993e8ac932a7dd218f0fa3976dfc31001ec5df33972f4d227291b8d9"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.6/dbrain_v0.8.6_darwin_amd64.tar.gz"
      sha256 "bc47f040d4ded3e453448904c56fe4e99463c9904eb85987d4e6f856b2fdac96"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.6/dbrain_v0.8.6_linux_arm64.tar.gz"
      sha256 "0db33f6d8631278f8c34a18b900713ed6f145493db8af4f07783721173c243f5"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.6/dbrain_v0.8.6_linux_amd64.tar.gz"
      sha256 "596b56b35ad07a672afc343d6635b5c24ce14b7310152e3238683c8c54077c44"
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
