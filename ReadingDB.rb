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

  def install
    inreplace 'src/reading-server.c', /inline int valid_bucketsize/, 'int valid_bucketsize'
    ENV['CC'] = 'llvm-gcc'
    ENV['CXX'] = 'llvm-g++'
    system 'autoreconf', '--install'
    system './configure', '--prefix=/usr/local/'
    system 'make'
    system 'sudo', 'make', 'install'
  end
end

