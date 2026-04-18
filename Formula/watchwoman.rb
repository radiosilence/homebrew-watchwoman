class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.1/watchwoman-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "9aa04686127e5fcdb5601686deb317a592e0082511cfee6ebb876e325fa32399"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.1/watchwoman-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "13907066a8945c226978097aeed6ad3e7e862233b69f54ce6315be88c0e7b6f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.1/watchwoman-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a2785772dad3a18a784e83fc9300277f65085e61db5d395a74ea68cd699c4372"
    else
      url "https://github.com/radiosilence/watchwoman/releases/download/v0.2.1/watchwoman-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d05b3ef729e5d1bbc6eecd72068ce22828f0595eaeeaa19b8d1ee4907d76e8d3"
    end
  end

  def install
    %w[watchwoman watchman watchman-wait watchman-make].each do |b|
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
