class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.0/watchwoman-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "76bb1a263918336a3a2fd64efea30c65c898d93a034f5d841b97f58f249e99f6"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.0/watchwoman-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "e58bd3ed800226a611bd0ce92cae8d7e49912ce632bb78700d504f6545ebf197"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.0/watchwoman-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "462f8f98cfaa0107b256ee4055e10778781ebce85a1044febb8561a40621f80a"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.3.0/watchwoman-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8218a9029c6e180ecbd6f0d271485bcb9d07e3cf7edd59d4ff14685a2d3b9ee6"
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
