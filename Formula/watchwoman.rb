class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.1.1/watchwoman-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "49ceee1b143c35a26adb51446f23e1cad748dc33ee9831428a14232c7f9f67a0"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.1.1/watchwoman-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "5ca06a85cc7629fe77efc85138925dfe218d3bf93feafad84e177db8d3975d8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.1.1/watchwoman-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf2d776bdaa61d725ad9582641f95a01b6645f7353efafc6516120fba707852e"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.1.1/watchwoman-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "643c46d7888d57cdfeb6a8c2b7113d0a2fb0b3f114a4480d0d3d3ba45bacd040"
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
