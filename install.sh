#!/bin/sh

date=$(date "+%Y%m%d")
time=$(date "+%H%M%S")
script_folder=$(dirname "$0");

# SETTINGS
my_htdocs=~/EDU/DEV/MAMP/htdocs

mamp_target=~/ENVIRONMENT
mamp_folder_name=MAMP
oldfiles_folder_name=$mamp_folder_name\_$date\_$time
link_path=~/Library/.Containers/MAMP
# End SETTINGS

#SCRIPT
printf "\e[43;30m ## MAMP INSTALLER ## \e[0m\n"

if [ ! -d $mamp_target ]; then
	printf "\e[33m## Creating folder $mamp_target...\e[0m\n"
	if mkdir -p $mamp_target; then
		printf "\e[32m## Folder created\e[0m\n"
	else
		printf "\e[31m## Folder not created\e[0m\n"
	fi
fi

pushd $mamp_target &> /dev/null
if [ -d $mamp_folder_name ]; then
	printf "\e[33m## Move old $mamp_target/$mamp_folder_name files to $oldfiles_folder_name...\e[0m\n"
	mv $mamp_folder_name $oldfiles_folder_name
	printf "\e[32m## Moving done\e[0m\n"
fi
popd &> /dev/null

printf "\e[33m## Copying new MAMP files to $mamp_target/$mamp_folder_name...\e[0m\n"
cp -R $script_folder/MAMP $mamp_target/$mamp_folder_name;


if cp -R $script_folder/MAMP $mamp_target/$mamp_folder_name; then
	printf "\e[32m## Copying successful\e[0m\n"

	ln -s $mamp_target/$mamp_folder_name/manager-osx.app ~/Desktop/MAMP
	ln -s $mamp_target/$mamp_folder_name/apache2/htdocs ~/Desktop/htdocs
	mv $mamp_target/$mamp_folder_name/apache2/htdocs $mamp_target/$mamp_folder_name/apache2/htdocs_old

	printf "\e[33m## Setup settings...\e[0m\n"
	ln -s $my_htdocs $mamp_target/$mamp_folder_name/apache2/htdocs
	sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' $mamp_target/$mamp_folder_name/php/etc/php.ini
	sed -i -e 's/;sendmail_path/sendmail_path/g' $mamp_target/$mamp_folder_name/php/etc/php.ini

	if [ -L $link_path ]; then
		printf "\e[33m## Removing old $link_path...\e[0m\n"
		if rm $link_path; then
			printf "\e[32m## Link removed\e[0m\n"
		else
			printf "\e[31m## Link not removed\e[0m\n"
		fi
	fi

	printf "\e[33m## Creating link from $mamp_target/$mamp_folder_name to ~/Library/.Containers/MAMP...\e[0m\n"
	if ln -s $mamp_target/$mamp_folder_name ~/Library/.Containers/MAMP; then
		printf "\e[32m## Link created\e[0m\n"
	else
		printf "\e[31m## Link not created\e[0m\n"
	fi

	printf "\e[32m## Setup settings done\e[0m\n"
	printf "\e[42;30m MAMP installed \e[0m\n"
else
	printf "\e[31m## Copying not successful\e[0m\n"
	printf "\e[41;30m MAMP not install \e[0m\n"
fi
# End SCRIPT
