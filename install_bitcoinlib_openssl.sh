#install liboqs
sudo apt install cmake gcc libtool libssl-dev make ninja-build git python3-pytest python3-pytest-xdist unzip xsltproc doxygen graphviz

sudo rm -r openssl
sudo rm -r liboqs


git clone https://github.com/open-quantum-safe/liboqs.git
git clone https://github.com/prchander/openssl.git
OPENSSL_DIR=$PWD/openssl
cd liboqs
mkdir build && cd build
cmake -GNinja -DOQS_USE_OPENSSL=ON ..
cmake -GNinja -DCMAKE_INSTALL_PREFIX=$OPENSSL_DIR/oqs ..
cmake -GNinja -DBUILD_SHARED_LIBS=ON ..
ninja
sudo ninja install 

#install openssl
cd $OPENSSL_DIR
#./Configure no-shared linux-x86_64 -lm
./Configure shared linux-x86_64 -lm
sudo make -j


# Install python-bitcoinlib
cd ~
if [ ! -d "python-bitcoinlib" ] 
then
    git clone https://github.com/prchander/python-bitcoinlib.git
fi

cd python-bitcoinlib
sudo python3 setup.py install
export LD_LIBRARY_PATH=$HOME/openssl
