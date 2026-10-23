class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.8.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.3/watchwoman-0.8.3-aarch64-apple-darwin.tar.gz"
    sha256 "5b95a3340db85d27375cf8d03e254012c9f4f24a2cd6e0d3b3a575a3ca282875"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.3/watchwoman-0.8.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3c695ed9a84195348948406868c36d24d86924967656206565082fb07e2e210"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.8.3/watchwoman-0.8.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a71b044afff2d36681d40f14c75feae20332a57d8500ab5cad944b9abe6d6a9"
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
