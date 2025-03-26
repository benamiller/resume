#!/bin/bash

if [ -f .env ]; then
	source .env
else
	echo "Error: .env not found"
	exit 1
fi

if [ -z "$email" ]; then
	echo "Error: email variable not found in .env"
	exit 1
fi

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 {cad|uk}"
	exit 1
fi

case "$1" in
	"cad")
		if [ -z "$cad" ]; then
			echo "Error: cad variable not found in .env"
			exit 1
		fi
		phone=$cad
		;;
	"uk")
		if [ -z "$uk" ]; then
			echo "Error: uk variable not found in .env"
			exit 1
		fi
		phone=$uk
		;;
	*)
		echo "Error: Argument must be 'cad' or 'uk'"
		exit 1
		;;
esac

if [ ! -f resume.tex ]; then
	echo "Error: resume.tex not found"
	exit 1
fi

sed "s/EMAIL/$email/g;s/PHONE/$phone/g" resume.tex > temp.tex

pdflatex temp.tex

rm temp.tex temp.aux temp.log

mv temp.pdf resume.pdf

echo "PDF generated"
