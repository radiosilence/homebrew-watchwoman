class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.0/watchwoman-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "1c92313ab30b20f2c5fe55cac73144f1bc4b5057a46de4a034a3a1d1337db3fe"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.0/watchwoman-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "8c7d5e6fff1b2a0aa0d76f2d0162c449490d4ef6e2c9c17a4866eebbb6b79dd0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.0/watchwoman-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4f3ed92fef68f7c67e9b765c2d8a6170884d4efdc0d250824a1d622ee0d4475a"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.0/watchwoman-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cd4c4a2872da66cf9ddc558018f89cc70bb4db485c6185bc49dee51248f7aed8"
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
