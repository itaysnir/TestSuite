[ -z "$1" ] && exit -1;

#dir=19_06_14_18.40.40/
dir=$1
ag=/homes/markuze/allocator_graphs/scripts/
suite=/homes/markuze/TestSuite/
cd /tmp/
rm -fr $dir
mkdir -p $dir
cd $dir
pwd
$suite/parse.pl -d $suite/Results/OCTO/$dir
$suite/display.pl -d ${dir}.csv
$ag/plot.pl -d setup.csv
ls
cd ..
gdrive upload -r -p 1Asc-CvlH-6fp-muaRX6zbLKORWpt3G2R $dir

