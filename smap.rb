require 'formula'

class Smap < Formula
  homepage 'http://pythonhosted.org/Smap/en/2.0/'
  head 'https://github.com/SoftwareDefinedBuildings/smap.git', :branch => 'unitoftime'

  #depends_on 'gnu-sed' => :build
  depends_on :python

  def install
    Dir.chdir("python")
    system "python", 'setup.py', 'install', "--prefix=#{prefix}"
  end

  def caveats
    s = <<-EOS.undent
    Make sure you add homebrew to your PYTHONPATH. Add the following to your .bash_profile:
    export PYTHONPATH=`brew --prefix`/lib/python2.7/site-packages:$PYTHONPATH
    EOS
    s
  end
end
