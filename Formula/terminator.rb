class Terminator < Formula
  desc "Multiple terminals in one window"
  homepage "https://gnometerminator.blogspot.com/p/introduction.html"
  url "https://launchpad.net/terminator/gtk3/1.91/+download/terminator-1.91.tar.gz"
  sha256 "95f76e3c0253956d19ceab2f8da709a496f1b9cf9b1c5b8d3cd0b6da3cc7be69"
  head "lp:terminator", :using => :bzr

  bottle do
    cellar :any_skip_relocation
    sha256 "00e85432871cb5e7df4bcbe8e835cf9ad619f772de9018c41ed781bef4fa6643" => :high_sierra
    sha256 "00e85432871cb5e7df4bcbe8e835cf9ad619f772de9018c41ed781bef4fa6643" => :sierra
    sha256 "00e85432871cb5e7df4bcbe8e835cf9ad619f772de9018c41ed781bef4fa6643" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtk+3"
  depends_on "python@2"
  depends_on "pygtk"
  depends_on "pygobject"
  depends_on "pango"
  depends_on "vte"

  def install
    ENV.prepend_create_path "PYTHONPATH", lib/"python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)
  end

  def post_install
    system "#{Formula["gtk"].opt_bin}/gtk-update-icon-cache", "-f",
           "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    ENV.prepend_path "PYTHONPATH", Formula["pygtk"].opt_lib/"python2.7/site-packages/gtk-2.0"
    ENV.prepend_path "PYTHONPATH", lib/"python2.7/site-packages"
    system "#{bin}/terminator", "--version"
  end
end
