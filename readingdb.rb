require 'formula'

class ReadingDB < Formula
    homepage "https://github.com/SoftwareDefinedBuildings/readingdb"

    head "https://github.com/SoftwareDefinedBuildings/readingdb.git", :branch => "adaptive"

    depends_on 'lbdb'
    depends_on 'protobuf'
    depends_on 'protobuf-c'
    depends_on 'lzlib'
    depends_on 'autoconf'
    depends_on 'automake'
    depends_on 'swig'

    def install
        inreplace "src/reading-server.c", /inline valid_bucketsize/, "valid_bucketsize"
        ENV['CC'] = 'llvm-gcc'
        ENV['CXX'] = 'llvm-g++'
        system "autoreconf", "--install"
        system "./configure"
        system "make"
        system "make", "install"
    end
end

