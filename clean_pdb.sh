#/bin/bash

base=$(pwd)
cifs_dir=./paper-cifs-cp/

for file in ${cifs_dir}*.cif; do
    mol_name=${file%%.*}
    # mol_name=basename $file
    echo $mol_name
    exit 0
    # echo $file
    # Run EQeq to get the charges on the full system and convert to a pdb
    $base/eqeq.sh $file
    mv ./eqeq_output/*.pdb ./${cifs_dir}/${mol_name}.pdb

    # If file is not clean, run pdb_wizard to remove isolated molecules
	# if [[ "$file" != *_clean* ]]; then
    echo -e "1\n5\n0\n3\n3\n${mol_name}_clean.pdb" | python3 $HOME/bin/pdb_wizard.py $file
    # file = ${mol_name}_clean.pdb
    # fi
    # echo -e "1\n5\n0\n3\n2\n1\n" | python3 $HOME/bin/pdb_wizard.py $file # Append charges to the file
		# This may be possible in mercury too. In the GUI the commands are 
		# Edit -> Edit Structure -> Remove Molecules
        
done
