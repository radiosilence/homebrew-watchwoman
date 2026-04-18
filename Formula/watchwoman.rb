class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.2/watchwoman-0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "53ab71e179fb23c0634f311d179bd2612beb9c93852cd223599f77d3c42631a3"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.2/watchwoman-0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "cfa224ecb1f125815042d48188e6468dd99048036c63a7c87d13b05783838792"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.2/watchwoman-0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e3b71ef3973159429123f1adf1a40f136475b65dc4edc5d40fc98a8fc0e7a6c"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.2/watchwoman-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "116079b7cff196b5bd6a6d308642f278d3eefc26392e712346b35b543c879fe9"
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
