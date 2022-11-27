conda create --name singularity -y notebook
conda activate singularity
conda install -c conda-forge singularity

Old Version:
singularity --version
2.6.1-dist
which singularity
/usr/bin/singularity
https://docs.sylabs.io/guides/3.0/user-guide/installation.html#install-the-debian-ubuntu-package-using-apt
sudo wget -O- http://neuro.debian.net/lists/xenial.us-ca.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xA5D32F012649A5A9
sudo apt-get update
sudo apt-get install -y singularity-container


