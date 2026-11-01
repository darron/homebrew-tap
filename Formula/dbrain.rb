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
      url "https://github.com/darron/dbrain/releases/download/v0.8.27/dbrain_v0.8.27_darwin_arm64.tar.gz"
      sha256 "11d898c4df9e5f357423f6c1b07b93c5cc884cb0d296b503ae8d3b2cb832c5d5"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.27/dbrain_v0.8.27_darwin_amd64.tar.gz"
      sha256 "f4ea8df3e712d09b1bd6b69222646b1912b96fe0411e47f52b56b050e6349b83"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/darron/dbrain/releases/download/v0.8.27/dbrain_v0.8.27_linux_arm64.tar.gz"
      sha256 "2c510fe7ec23df3fbfb318e8b5eb2e67ccf70461902f44d766d36359966e1ffe"
    else
      url "https://github.com/darron/dbrain/releases/download/v0.8.27/dbrain_v0.8.27_linux_amd64.tar.gz"
      sha256 "6ec2f7a7add0d77882bf80ccb5e938f20ad4cb049277384474a89e5a24ae776e"
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
