#!/bin/bash


	# Function to enable a module.

function enable_apache_module()
{
	a2enmod $1
}


	# Function to disable a module.

function disable_apache_module()
{
	a2dismod $1
}

	# List the available sites.

function list_sites()
{
	ls /etc/apache2/sites-available/*.conf | xargs -I{} basename {} \;
}

	# Enable a site.

function enable_site()
{
	printf "Enabling the site.. %s\n", $1
	a2ensite $1

	service apache2 start # Necessary to run the following statement.
	service apache2 reload # This must be run to activate the new configuration.
}

	# Disable a site.

function disable_site()
{
	printf "Disabling the site.. %s\n", $1
	a2dissite $1

	service apache2 start # Necessary to run the following statement.
	service apache2 reload # This must be run to activate the new configuration.
}



function printhelp()
{
	printf "apachemod l - List the available sites.\n"
	printf "apachemod e|d <module> - Enable or disable module.\n"
	printf "apachemod up|down <site> - Enable or disable site.\n"
}



	# Check if the script was passed two parameters and call a function if this is the case.

if [ $# -eq 1 ]; then

	# The parameter was l, so call the function to list the available sites.

	if [ "$1" == "l" ]; then
		printf "Listing available sites..\n"
		list_sites
	fi


	if [ "$1" == "h" ]; then
		printhelp
	fi

	exit	# Exit the script
fi




if [ $# -ne 2 ]; then
	printf "Insufficient parameters passed..\n"
	printhelp
else

		# The first parameter was e, so call the function to enable a module.

	if [ "$1" == "e" ]; then
		printf "Enabling ", $2
		enable_apache_module $2
	fi

		# The first parameter was d, so call the function to disable a module.

	if [ "$1" == "d" ]; then
		printf "Disabling ", $2
		disable_apache_module $2
	fi


		# The first parameter was up, so call the function to enable a site.

	if [ "$1" == "up" ]; then
		printf "Enabling the site.. %s\n", $2
		enable_site $2
	fi

		# The first parameter was d, so call the function to disable a site.

	if [ "$1" == "down" ]; then
		printf "Disabling the site.. %s\n", $2
		disable_site $2
	fi



fi	# End of block for 2 parameters passed to script.


