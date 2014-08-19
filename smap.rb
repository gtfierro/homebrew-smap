require 'formula'

class Smap < Formula
  homepage 'http://pythonhosted.org/Smap/en/2.0/'
  head 'https://github.com/SoftwareDefinedBuildings/smap.git', :branch => 'unitoftime'

  #depends_on 'gnu-sed' => :build
  depends_on :python

  def install
    Dir.chdir("python")
    inreplace 'setup.py', "('/etc/supervisor/conf.d/', ['supervisor/archiver.conf']),", ''
    inreplace 'setup.py', "('/etc/smap/', ['conf/archiver.ini']),", ''
    system "python", 'setup.py', 'install', "--prefix=#{prefix}"
  end

  def caveats
    s = <<-EOS.undent
    Make sure you add homebrew to your PYTHONPATH. Add the following to your .bash_profile:

      export PYTHONPATH=`brew --prefix`/lib/python2.7/site-packages:$PYTHONPATH

    If you have supervisor installed (pip install supervisor), you can run the sMAP
    archiver by copying the archiver.conf file to your supervisor conf.d directory,
    and the archiver.ini file to a known location, e.g.

      sudo pip install supervisor
      sudo mkdir -p /etc/supervisor/conf.d
      sudo mkdir -p /etc/smap
      sudo cp supervisor/archiver.conf /etc/supervisor/conf.d/.
      sudo cp conf/archiver.ini /etc/smap/.

    EOS
    s
  end
end
