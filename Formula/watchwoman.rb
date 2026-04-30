class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.5.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.2/watchwoman-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "839a5b5b2454106f42d0982f475e3bb4d753d29b73bdf75f09161b0a47e41f57"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.2/watchwoman-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "55c93370c466729dd497f6a3bc4dc26b740a8c55dbe2629cb754d7dddf94ba91"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.2/watchwoman-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dada12ff7e260b439908ddf25b83a7bbfa5d1591f81706664da1b5fe9f0c178a"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.2/watchwoman-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b351ab29ebb9758e8e5df835e92f7a4933cb752b143297919540463a2a82d53"
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
