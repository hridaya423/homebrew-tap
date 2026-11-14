class Phonedriver < Formula
  desc "phonedriver is an open-source MCP server and CLI that lets AI agents like Claude Code see and control Android and iOS phones."
  homepage "https://phonedriver.dev"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.4/phonedriver-aarch64-apple-darwin.tar.gz"
      sha256 "e0f4377edaf8d2cb057481e659b28783ac620c1dbc5015dfc537fa549ab22068"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.4/phonedriver-x86_64-apple-darwin.tar.gz"
      sha256 "28abeb941067fcb697961ff7df9276a9935648643df7ad65b6a13e6f345a2a1d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.4/phonedriver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a9d275692d08a6bfc1011e990e5b4ae3b68ab05537e7f7016b2e05438d81803"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.4/phonedriver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9df78278c884b8224f8b408361ac7d133758b859927c787081806b4fda6b6c3"
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
