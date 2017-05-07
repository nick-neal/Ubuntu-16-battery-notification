# Ubuntu Desktop 16.04 LTS Battery Notification
A script that will notify you that your battery is getting low on Ubuntu Desktop 16.04.2 LTS

## Setup

To setup this script, you will need to clone the repo, and go into the directory on your computer.

After that, run the following commands:

	chmod u+x battery-notification.sh

	./battery-notification.sh --install

What these commands will do is set the shell script to executable by the user, and install the script.

The script will install the script to a 'bin' directory in your home directory.

Then, it will install a cron job to call it every 2 minutes.

## Output

* When your battery is between 11-15%, it will tell you to plug in your computer.

* When your battery is between 6-10%, it will alert you that it will shutdown at 5%.

* At 5% it will alert you that your computer is shutting down, and shut down your computer safely.

## Uninstall

To uninstall this script , delete the line that calls '*bn.sh*' from your crontab, and delete the bn.sh script from your '~/bin' directory.


