class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.8.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.0/watchwoman-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "dbe983c972213397e454edce6bac70624c2b3633223ed39b4684a6c7fe0f67c1"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.0/watchwoman-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "7bb1b5b74da3f18b9cecacaa6c3df2be883f449647b05c144e67de5441e09191"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.0/watchwoman-0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "447d0f27daca5f575759ebc9864398e20daa52f343bad79a30db970037a25416"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.0/watchwoman-0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7558b75cd0614a9ec58182c9f489e3603932b30181a6d956a46936b29080bbd0"
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
