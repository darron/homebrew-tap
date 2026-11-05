class Fbhook < Formula
  desc "Shared feedback intake and issue delivery"
  homepage "https://github.com/darron/fbhook"
  license "MIT"
  on_macos do
    on_arm do
      url "https://github.com/darron/fbhook/releases/download/v0.2.0/fbhook_0.2.0_darwin_arm64.tar.gz"
      sha256 "539f0879affb46b73fb82cdf25983ce55c347de5251b3de8f7e42bf2ab0af3a2"
    end
    on_intel do
      url "https://github.com/darron/fbhook/releases/download/v0.2.0/fbhook_0.2.0_darwin_amd64.tar.gz"
      sha256 "9c8bf2eec8464e303b6520613b2be8b163d03dd2f2851432c539eb8cff9e7ae6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/darron/fbhook/releases/download/v0.2.0/fbhook_0.2.0_linux_arm64.tar.gz"
      sha256 "70793a57b33f6a8abae0fd04fb90ef18468a6a97ce60d5b047175aa45853e56b"
    end
    on_intel do
      url "https://github.com/darron/fbhook/releases/download/v0.2.0/fbhook_0.2.0_linux_amd64.tar.gz"
      sha256 "46994766d98c27b26ea64dfe956537e33d6612624b26e29f8ccb9bd471490e94"
    end
  end

  # Preserve the exact executable published on GitHub.
  skip_clean "bin/fbhook"

  def install
    bin.install "fbhook"
    prefix.install "THIRD_PARTY_NOTICES.txt"
  end
  test do
    assert_equal "fbhook #{version} sha=8c8892a37f75d0d66311a855db719236c4047fc9 clean\n", shell_output("#{bin}/fbhook version")
    assert_match "shared feedback", shell_output("#{bin}/fbhook help")
    assert_path_exists prefix/"THIRD_PARTY_NOTICES.txt"
  end
end
