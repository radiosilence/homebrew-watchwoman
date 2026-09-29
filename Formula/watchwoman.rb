class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.7.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.1/watchwoman-0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "66c91d9ac9dabfc029fe8c6aff15d4e61e11002e4cc3c1a9ba4fe3ad25353c6b"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.1/watchwoman-0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "e14db82d71e1621870bc97628a7be1bff65c5b2e566207cbab1bc3a131738c1a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.1/watchwoman-0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26abb7d95eef96437a5208b1ac024032b7d101276b81a5d05b71352d2b2118c5"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.1/watchwoman-0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb2032e924b7a9a389117d3affff06f8fcec7c25a6998127101b7e5cb5500171"
    end
  end

  def install
    %w[watchwoman watchman watchman-wait watchman-make watchman-diag watchmanctl].each do |b|
      bin.install b
    end
  end

  def caveats
    <<~EOS
      watchwoman ships a `watchman` binary for drop-in compatibility.
      If you previously installed facebook/fb's watchman, uninstall it
      and make sure #{HOMEBREW_PREFIX}/bin comes first on your PATH:

        brew uninstall --ignore-dependencies watchman || true
        which watchman   # should resolve to #{HOMEBREW_PREFIX}/bin/watchman

      See https://github.com/radiosilence/watchwoman/blob/main/docs/REPLACING_WATCHMAN.md
    EOS
  end

  test do
    assert_match "watchwoman", shell_output("#{bin}/watchwoman --version")
    assert_match "watchwoman", shell_output("#{bin}/watchman --version")
  end
end
