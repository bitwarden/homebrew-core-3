class Maxima < Formula
  desc "Computer algebra system"
  homepage "https://maxima.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/maxima/Maxima-source/5.47.0-source/maxima-5.47.0.tar.gz"
  sha256 "9104021b24fd53e8c03a983509cb42e937a925e8c0c85c335d7709a14fd40f7a"
  license "GPL-2.0-only"
  revision 5

  livecheck do
    url :stable
    regex(%r{url=.*?/maxima[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b6bd7df65f8faf2d9832a7c48f314c9be177df6e57af9c2ff3e2de8428ec3612"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e67d03912081ab936c99e02665b4ee6948c4e335ebd61bbed87931d3ff756995"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "45974e94ce40871ded1dce948ce2e98b6cc19b4c2be8ee0e3464c7262de811a2"
    sha256 cellar: :any_skip_relocation, sonoma:         "bb4d02238bc2074ade685765a93f87c524b79ff9d08532309220926ca3a7a782"
    sha256 cellar: :any_skip_relocation, ventura:        "96528ff5941a939ee03f48a95ae51b159836e2ee955b9655fea79f8068332699"
    sha256 cellar: :any_skip_relocation, monterey:       "55958eeb6b599707876825338d5acd3adf1cba23810ca29347e99b397340608d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4018087d10006b3be5b4058ebdc51f981fce21c8eab3b590853dfc502f2a804f"
  end

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "perl" => :build
  depends_on "texinfo" => :build
  depends_on "gettext"
  depends_on "gnuplot"
  depends_on "rlwrap"
  depends_on "sbcl"

  def install
    ENV["LANG"] = "C" # per build instructions
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           "--enable-gettext",
           "--enable-sbcl",
           "--with-emacs-prefix=#{share}/emacs/site-lisp/#{name}",
           "--with-sbcl=#{Formula["sbcl"].opt_bin}/sbcl"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/maxima", "--batch-string=run_testsuite(); quit();"
  end
end
