class Phonedriver < Formula
  desc "phonedriver is an open-source MCP server and CLI that lets AI agents like Claude Code see and control Android and iOS phones."
  homepage "https://phonedriver.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.0/phonedriver-aarch64-apple-darwin.tar.gz"
      sha256 "790524fc9f1c0b9f638715d55dc0be514c7667267f127ba5b78f1820424b81a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.0/phonedriver-x86_64-apple-darwin.tar.gz"
      sha256 "5e57b3bc7d89967b152ee0aba8bdefdde7261615da1ff0712267e5a4933fce70"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.0/phonedriver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "937e8319f311163ee054509868efd207f408afcc1840c4d802f4ac144c756476"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.0/phonedriver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ae22c6a02ad6ba85895a3c58175b3bfbd4f91d083a74abb592b21f1e800160f"
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
