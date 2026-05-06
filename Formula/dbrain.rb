class Dbrain < Formula
  desc "Local-first second-brain CLI"
  homepage "https://github.com/darron/dbrain"
  version "0.1.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_darwin_arm64.tar.gz"
      sha256 "5e7efc7b2766c6e8482dbbf149aff715b6c21a848404d92cc7d2c656835c55e3"
    end

    on_intel do
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_darwin_amd64.tar.gz"
      sha256 "6f751f975a20f801ce7596ffc4ec1016f5ee916946f8e423a73b8818fc0c89d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_linux_arm64.tar.gz"
      sha256 "3c870995f622283979b0a3ebc1787f4e9b43bc364140a71ef89e4ed982879f26"
    end

    on_intel do
      url "https://github.com/darron/dbrain/releases/download/v#{version}/dbrain_v#{version}_linux_amd64.tar.gz"
      sha256 "86098ac14a753ec65e9c0db31077a1d58aa7ce34f5a8c03eae00e0c9f9f352c7"
    end
  end

  def install
    bin.install "dbrain"
  end

  test do
    assert_match "module_path: github.com/darron/dbrain", shell_output("#{bin}/dbrain version")
  end
end
