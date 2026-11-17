class Phonedriver < Formula
  desc "phonedriver is an open-source MCP server and CLI that lets AI agents like Claude Code see and control Android and iOS phones."
  homepage "https://phonedriver.dev"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.5/phonedriver-aarch64-apple-darwin.tar.gz"
      sha256 "07b20ccbc6bcc82d3a3ae3b85b1789f05b429cdac9465fe321ff473992aebf11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.5/phonedriver-x86_64-apple-darwin.tar.gz"
      sha256 "61b83057e091bd6cab7ad81b6848280e3d5cd417ee338b2a4592f3173f1271cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.5/phonedriver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f4db60b3f65f157af9eaece33984e65a50e000db0c26b430a71b7684665e40ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.5/phonedriver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "edd903e306ba00959340b9f005626ad6037aaffd2e70206f2f78bb4e21dcf0dc"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "phonedriver"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "phonedriver"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "phonedriver"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "phonedriver"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
