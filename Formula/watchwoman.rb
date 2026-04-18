class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.1/watchwoman-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "475bdb43a3a24a715d79762aa9aca024ba1af19d095b10edeba03a740661e323"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.1/watchwoman-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "9bf486834903c7c637c6b06ab4adc5b3322009414a48872564d019f78ad5803f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.1/watchwoman-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5f21114b85495c6dfa52e85ce2e2972432186a9058545abe5112dd739091d24e"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.1/watchwoman-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8cd82dd0596aedab29d3d2215537623dbac04a3b4ca771b597c5e08ed1017c0"
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
