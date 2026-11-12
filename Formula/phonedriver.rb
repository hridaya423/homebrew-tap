class Phonedriver < Formula
  desc "phonedriver is an open-source MCP server and CLI that lets AI agents like Claude Code see and control Android and iOS phones."
  homepage "https://phonedriver.dev"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.2/phonedriver-aarch64-apple-darwin.tar.gz"
      sha256 "c7ac31e63226e43f112fc349f3880c139bb81131ae8245f60692f568a362fc84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.2/phonedriver-x86_64-apple-darwin.tar.gz"
      sha256 "6f6da601b6c18e2171fde89577756d76f6484e5ab34a5961e3eb32a326bb4948"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.2/phonedriver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d8b4dd3d60e58707fc505a870c49a54ad49ba29b66bac3a5a2800071cf482d24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hridaya423/phonedriver/releases/download/v0.1.2/phonedriver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d1db9bdd1342a05b0e197be7356402d57cabfe306770e090e2b06b322e17a57"
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
