# SETTINGS
mamp_target=~/ENVIRONMENT
mamp_folder_name=MAMP

link_path=~/Library/.Containers/MAMP
# End SETTINGS

# SCRIPT
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
# END SCRIPT