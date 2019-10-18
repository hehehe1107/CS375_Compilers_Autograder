#! /bin/bash

CS375DIR=~/Dropbox/CS375_Compilers
AUTOGRADERDIR=$CS375DIR/autograder
FILEDIR=$AUTOGRADERDIR/cs375_minimal

##
## Copy all files from $FILEDIR to the student's dir
## if the file is not there
##
copyifnotexist(){
    for f in $FILEDIR/*
    do
        ##
        ## Note that $f is the full path of the file
        ## so we need to extract the basename of the file first
        ## because the existence checking only works for
        ## file's basename
        ##
        filename=$(basename $f)
        if [ ! -e "$filename" ]; then
            cp $f ./
        fi
    done
}


cd "$1_gradingDir"

for studentDir in ./*
do
    cd $studentDir
    echo "processing student: $studentDir"
    for submittedFile in ./*
    do
        ##
        ## the downloaded submitted file has the following form
        ## 
        ## name_LATE_3454987397_397484737_parse-3.y
        ##
        ## The goal is to extract the basename of the file without
        ## version number
        ##
        ## Step 1: extract the filename with version number
        fwithV=$(echo ${submittedFile##*_})
        ## Step 2: replace version number (-[1-9]) with nothing
        fwithoutV=$(echo ${fwithV/-[1-9]})
        ## Step 3: rename the file
        mv $submittedFile $fwithoutV
    done
    copyifnotexist
    cd ..
done
