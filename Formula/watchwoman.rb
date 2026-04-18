class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.1/watchwoman-0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "6b5d874c61af8c642abb1b6ac06329b92658947c42a0f92044acbd3ae0babe9d"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.1/watchwoman-0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "efaf525965068f7274273b04922c428b55270d9b424acb54d11391b3c4f1b400"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.1/watchwoman-0.4.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dfe3dc10f7d2f49b89e5a488bd54cc6775ba11fcac8eabd3afdf16bdfff6c718"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.4.1/watchwoman-0.4.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "539440f4fb8c5200a241477e7fb76ee5ed8e79595b0eb1d8754969d9a6a95c46"
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
