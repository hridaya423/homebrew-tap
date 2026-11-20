class Phonedriver < Formula
  desc "phonedriver is an open-source MCP server and CLI that lets AI agents like Claude Code see and control Android and iOS phones."
  homepage "https://phonedriver.dev"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.6/phonedriver-aarch64-apple-darwin.tar.gz"
      sha256 "4c2e39e519627d31856abc512954862abfee042756b19325a3f6160bc363317f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.6/phonedriver-x86_64-apple-darwin.tar.gz"
      sha256 "f52b4b7aa2dc5115c92ba872b3d0335a3e8c194d14039cf09d942d3944994de4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.6/phonedriver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f89ae0d538712df394f0d9afb8f8b993cbadf277de416ea402e91accc0a27655"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.6/phonedriver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34f4e476835609a91ca8d0bd08c245d151df06994b5efb265126950374bcc355"
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
