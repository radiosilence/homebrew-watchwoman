class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.7.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.2/watchwoman-0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "63002be15fa324a96701df1cf7c85ca07880db366a79011e54eacb03ea985180"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.2/watchwoman-0.7.2-x86_64-apple-darwin.tar.gz"
      sha256 "1f57b513eb1484dbe61ccbc97465e9c9cc5f6c1d29bc9448fabda159b82e5931"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.2/watchwoman-0.7.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6a3ac7626129b23889b9a8a890ca8878d48e0e003c7f79741057ef1cac85c93"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.2/watchwoman-0.7.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c38bdeb00146cea79bb74b3e3838f4bb105bd474eccb2f4a8667d7e83c24c10"
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
