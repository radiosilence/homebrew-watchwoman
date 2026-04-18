class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.0/watchwoman-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "65937e89990ee1a54fba021f648e97ebdd1beeabd6feb39b040e33e4c77a4520"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.0/watchwoman-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "42c674ed57801f8561d60ae689afb0738896a98d42417927d9a831d6c805a2a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.0/watchwoman-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cff0b13f664de40f4563ff318da5140d8d5117c87bc5d357e251f1a324f72ad0"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.0/watchwoman-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a95a3cc9dff71dcabe0723f0171ba45587df1fcaac47df47d4d6e1cdb96ca3aa"
    end
  end

  def install
    bin.install "watchwoman"
    bin.install "watchman"
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
