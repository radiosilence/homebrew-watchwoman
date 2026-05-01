class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.6.0/watchwoman-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "8a25b80113d230e3c3451e43aaa74793bf099b5d16f090aa7ec50a7bd05a71f3"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.6.0/watchwoman-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "104cbb39da17d52238df1f7db971331b8ca9b7907f3ce3be341f5a2d06ff1f7e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.6.0/watchwoman-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "45d7ca8d84095aad7f665f2d6255910828dd8062e70b1143942c0cc117a3b48b"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.6.0/watchwoman-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4a89daa9c02723005ad8eb11d6669deac0a19a358093bc4776bc79b9168b249"
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
