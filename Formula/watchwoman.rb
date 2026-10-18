class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.8.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.1/watchwoman-0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "7e16dab177d49a6a4cd35b54977128e77c1a087bc9c078310b69971de38c80b7"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.1/watchwoman-0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "325695e12849d759ae1fb7ffc262c931e5c5a030f07f45eb3cadc278d66dc1cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.1/watchwoman-0.8.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e369a7f644ecd1b2cbaec482be3ad80ca972f1eb297c1197ef0dc7f2daaa136"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.1/watchwoman-0.8.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "891cf559dd9a31155ca1b23f93906d4f21b1a0e67905d3a8ab934bf17eaf6f95"
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
