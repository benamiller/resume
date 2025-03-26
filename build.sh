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

if [ ! -f resume.tex ]; then
	echo "Error: resume.tex not found"
	exit 1
fi

sed "s/EMAIL/$email/g" resume.tex > temp.tex

pdflatex temp.tex

rm temp.tex temp.aux temp.log

mv temp.pdf resume.pdf

echo "PDF generated"
