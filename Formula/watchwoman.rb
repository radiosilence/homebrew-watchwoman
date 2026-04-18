class Watchwoman < Formula
  desc "Drop-in watchman replacement that doesn't eat your RAM"
  homepage "https://github.com/radiosilence/watchwoman"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/radiosilence/watchwoman.git", branch: "main"

  depends_on "rust" => :build

  def install
    cd "crates/watchwoman" do
      system "cargo", "install", *std_cargo_args,
             "--bin", "watchwoman",
             "--bin", "watchman"
    end

    # Shell completions. Generated at install-time so they reflect the
    # exact subcommand set that shipped.
    generate_completions_from_executable(bin/"watchwoman", "completion")
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
