class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.0/watchwoman-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "11437f3f1a4a763d90a9c9420188b7e808fed3105b0a528458139995c72c65ce"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.0/watchwoman-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "f8f178363978385baec3e4f1b977d2d1977e7ca837736a179bff7a08c623a95e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.0/watchwoman-0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d0265c3e8976bd5135d79f48fa9e5c44932c7bf392c6842903913bf5fe6ff59b"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.7.0/watchwoman-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c97cd701f97a11799e1b19daca6715449bf5851a9fb14004b26de0270f179b2"
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
