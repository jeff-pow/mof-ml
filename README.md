create_pdbs.ipynb's goal is to read in the MOFs from the review paper table, clean them, and create a pdb for each.
core_mof.ipynb will then create a dataframe from all of the pdbs generated that can be used for a machine learning model.

Currently create_pdbs is still not working, and will likely take a lot of tweaking because often times the names the review
paper gave don't actually line up with the names that the CCDC database has.
