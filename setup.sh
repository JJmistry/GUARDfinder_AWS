### Sets up environment and installs dependencies
# This step must be run first and manually.

sudo yum install epel-release git wget -y

# Install C
#T sudo yum group install "Development Tools" -y

 # sudo yum yum install ncurses-devel zlib-devel texinfo gtk+-devel gtk2-devel qt-devel tcl-devel tk-devel kernel-headers kernel-devel readline-devel libcurl-devel -y

# https://stackoverflow.com/questions/37769985/how-to-install-older-r-version-on-centos

# download specific version of R 
wget https://cran.r-project.org/src/base/R-3/R-3.3.3.tar.gz

# unzip
 tar zxvf R-3.3.3.tar.gz

# change to directory
cd R-3.3.3

# Build dependencies for R 
sudo yum-builddep R -y

# install
./configure; make; sudo make install

# install generic r
# sudo yum install R

# install Devtools to run interactive R console
#sudo yum groupinstall "Development Tools"

# Open interactive R console
sudo -i R

cd /home/centos/

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("BSgenome", 'rtracklayer', 'GenomicRanges', 'GenomeInfoDb', 'Biostrings', 'XVector', 'IRanges', 'S4Vectors', 'BiocGenerics', 'nextflow')))
 
install.packages('optparse'))

git clone https://github.com/MatthewACoelho/GUARDfinder.git .

# Copy data download
 curl http://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.toplevel.fa.gz > /home/centos/GUARDfinder/data/hg38.fa.gz
 curl http://ftp.ensembl.org/pub/current_gtf/homo_sapiens/Homo_sapiens.GRCh38.96.chr.gtf.gz > /home/centos/GUARDfinder/data/hg38.gtf.gz


mkdir -p $guard_root/data/hg38/NGG
gunzip data/hg38.fa.gz

/bin/ot index -out /data/hg38/NGG -pam NGG data/hg38.fa
/bin/ot index -out /data/hg38/$pam -pam $pam data/hg38.fa


mkdir -p data/hg38/info
gunzip data/hg38.gtf.gz
bin/process_gtf.pl data/hg38/info < /data/hg38.gtf
