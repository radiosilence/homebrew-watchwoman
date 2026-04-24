class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.1/watchwoman-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "068a63113ddc5a0f3098578235aa788d25acb7add5c4f061fb816e16a128619a"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.1/watchwoman-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "b68bafa1e7c8eb8ee16042718ac115e4ba75ad317ecb9d9bf2f0ca5c626621f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.1/watchwoman-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f89362f285379eb1b3d90342bff87068347b17e688825e1ce4bae0796ba4a9eb"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.5.1/watchwoman-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0870a7cfe7094eb0a429a1dc4c224a5a380231b3c701e5b25dd4d671b20a8d19"
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
