#https://www.grid5000.fr/mediawiki/index.php/Hadoop_On_Execo#hg5k_Script_Basic_Usage

ssh grid5000
ssh lyon
export http_proxy="http://proxy:3128"; export https_proxy="https://proxy:3128"
easy_install --user execo
wget https://github.com/mliroz/hadoop_g5k/archive/master.zip .
unzip master.zip
cd hadoop_g5k-master/
python setup.py install --user
rm -r hadoop_g5k-master/
rm master.zip

PATH=/home/nkienlen/.local/bin:$PATH #warn : not persistent

#reserving nodes for 1 hour
oarsub -I -t allow_classic_ssh -l nodes=4,walltime=1
hg5k --create $OAR_FILE_NODES --version 2
PATH=/home/nkienlen/.local/bin:$PATH #not clean
