#/bin/bash

base=$(pwd)
cd pdbs

for file in *.pdb; do
	if [[ "$file" != *_clean*]]; then
		echo -e "1\n5\n0\n3\n2\n1\n python $base/pdb_wizard.py file
		# This may be possible in mercury too. In the GUI the commands are 
		# Edit -> Edit Structure -> Remove Molecules

done
