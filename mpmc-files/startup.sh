#/bin/bash

base=$(pwd)

for file in *.pdb; do
	mol="${file::-4}"
	mkdir -p $mol
	cd $mol

	cp ../file .
	sed "s/xjobx/$mol/g" $base/mpmc_submit.sh > mpmc_submit.sh
	sed "s/xjobx/$mol/g" $base/mpmc.inp > mpmc.inp

	rm -f std*
	rm -rf core.*

	bsub < mpmc_submit.sh
	pwd
	
	cd ../
done
