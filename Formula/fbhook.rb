class Fbhook < Formula
  desc "Shared feedback intake and issue delivery"
  homepage "https://github.com/darron/fbhook"
  license "MIT"
  on_macos do
    on_arm do
      url "https://github.com/darron/fbhook/releases/download/v0.1.0/fbhook_0.1.0_darwin_arm64.tar.gz"
      sha256 "223cf43530e1d928ed7b6ec9bd00728761b3b4b3b158b32c098c7f8670b716b7"
    end
    on_intel do
      url "https://github.com/darron/fbhook/releases/download/v0.1.0/fbhook_0.1.0_darwin_amd64.tar.gz"
      sha256 "9cc2d9db6368b0987db4c0206b8da25c95c289312483fe0c1c4d79c4efb4ecb3"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/darron/fbhook/releases/download/v0.1.0/fbhook_0.1.0_linux_arm64.tar.gz"
      sha256 "266bcea09fc289eaa747f1bfe9cf0f20b533944ab02da94432da0d0463fa25c1"
    end
    on_intel do
      url "https://github.com/darron/fbhook/releases/download/v0.1.0/fbhook_0.1.0_linux_amd64.tar.gz"
      sha256 "029608c657639950bb464a2508f97b9c219a6139296fcd09db1e0a145f42b102"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/fbhook"

  def install
    bin.install "fbhook"
    prefix.install "THIRD_PARTY_NOTICES.txt"
  end
  test do
    assert_equal "fbhook #{version} sha=0027985e0e9d791375e9b5458b48a215e6051274 clean\n", shell_output("#{bin}/fbhook version")
    assert_match "shared feedback", shell_output("#{bin}/fbhook help")
    assert_path_exists prefix/"THIRD_PARTY_NOTICES.txt"
  end
end
