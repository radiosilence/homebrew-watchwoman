class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.8.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.2/watchwoman-0.8.2-aarch64-apple-darwin.tar.gz"
    sha256 "4283439a4b83c4bff23b32f3c481a35f7b7f6faba85b4f7b7cf2bfc6058ba889"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.2/watchwoman-0.8.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ebc3b12002793f340e56495ba0fc857f8ed84c1f68dbf87946a2d268d54ece2"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.2/watchwoman-0.8.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e31eb201bebe6ef87589df1c60203d36841d9a37510551988804355d6fe8187a"
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
