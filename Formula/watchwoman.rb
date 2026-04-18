class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.0/watchwoman-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "b5cb66ea10f9e02a477e98004f5ef5134712fbd71d75f66b9f3a2c7f255a0360"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.0/watchwoman-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "319eb0e6c60e7f4a8144a27a1d3449e059106c615b72312a95ef9968800df616"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.0/watchwoman-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "77630aef173565061b2a4dfbc8850fad02e837f0c9c16754fa9257d56d231289"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.0/watchwoman-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fca704a7d477f415b5c78af17c6c42d7d273ab80ecba6e00e1b6758e7efd1d5"
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
