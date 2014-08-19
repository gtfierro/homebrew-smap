require 'formula'

class Readingdb < Formula
  homepage 'https://github.com/SoftwareDefinedBuildings/readingdb'

  head 'https://github.com/SoftwareDefinedBuildings/readingdb.git', :branch => 'adaptive'

  depends_on 'berkeley-db'
  depends_on 'protobuf'
  depends_on 'protobuf-c'
  depends_on 'lzlib'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'swig'
  depends_on :python
  depends_on 'numpy' => :python

  def install
    inreplace 'src/reading-server.c', /inline int valid_bucketsize/, 'int valid_bucketsize'
    ENV['CC'] = 'llvm-gcc'
    ENV['CXX'] = 'llvm-g++'
    system 'autoreconf', '--install'
    system './configure', '--prefix=/usr/local/'
    system 'make'
    system 'sudo', 'make', 'install'

    Dir.chdir("python")
    system 'make'
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

