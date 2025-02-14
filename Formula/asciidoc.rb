class Asciidoc < Formula
  include Language::Python::Virtualenv

  desc "Formatter/translator for text files to numerous formats"
  homepage "https://asciidoc-py.github.io/"
  url "https://files.pythonhosted.org/packages/4b/c0/ded4666a6d7a978b50fda85f44ba7f0939bd92838102769eca91a769aa9f/asciidoc-10.1.1.tar.gz"
  sha256 "33ac648f7b38fa8712cfdbbfd2465a263fea2dcd106946fcf7d59ae6473b47c5"
  license "GPL-2.0-only"
  head "https://github.com/asciidoc-py/asciidoc-py.git", branch: "main"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc87c367f62194b41a08b6affa82917ef8dd9a8e3c82ce6ec9d286ce15346b79"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dc87c367f62194b41a08b6affa82917ef8dd9a8e3c82ce6ec9d286ce15346b79"
    sha256 cellar: :any_skip_relocation, monterey:       "0159cbcaaadc71372413f3dc1c51a9ccd0b92416ab2dfdcb2d1abca2fac48ccb"
    sha256 cellar: :any_skip_relocation, big_sur:        "0159cbcaaadc71372413f3dc1c51a9ccd0b92416ab2dfdcb2d1abca2fac48ccb"
    sha256 cellar: :any_skip_relocation, catalina:       "0159cbcaaadc71372413f3dc1c51a9ccd0b92416ab2dfdcb2d1abca2fac48ccb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c269721f656990bb7523fa39ddc5f077e3a3d858b78375e12432bdc1294a651"
  end

  depends_on "docbook"
  depends_on "python@3.10"
  depends_on "source-highlight"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      If you intend to process AsciiDoc files through an XML stage
      (such as a2x for manpage generation) you need to add something
      like:

        export XML_CATALOG_FILES=#{etc}/xml/catalog

      to your shell rc file so that xmllint can find AsciiDoc's
      catalog files.

      See `man 1 xmllint' for more.
    EOS
  end

  test do
    (testpath/"test.txt").write("== Hello World!")
    system "#{bin}/asciidoc", "-b", "html5", "-o", testpath/"test.html", testpath/"test.txt"
    assert_match %r{<h2 id="_hello_world">Hello World!</h2>}, File.read(testpath/"test.html")
  end
end
