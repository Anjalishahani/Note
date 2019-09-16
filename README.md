
# SecretNotes
Demo app

Pre-requirement
Mac machine required
XCode installed. 
Pod install : See Note Below *
git installed : https://www.atlassian.com/git/tutorials/install-git

How to run?

open terminal and follow the commands
mkdir SecretNotes
cd SecretNotes
git clone https://github.com/Anjalishahani/Note.git
cd Note
pod install
open -a XCode SecretNoteApp.xcworkspace
run on simulator




**Note**
POD Install

[ 1 ] Open terminal and type:

sudo gem install cocoapods
Gem will get installed in Ruby inside System library. Or try on 10.11 Mac OSX El Capitan, type:

sudo gem install -n /usr/local/bin cocoapods
If there is an error "activesupport requires Ruby version >= 2.xx", then install latest activesupport first by typing in terminal.

sudo gem install activesupport -v 4.2.6
[ 2 ] After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done. Next, you need to setup the cocoapods master repo. Type in terminal:

pod setup

And wait it will download the master repo. The size is very big (370.0MB at Dec 2016). So it can be a while. You can track of the download by opening Activity and goto Network tab and search for git-remote-https. Alternatively you can try adding verbose to the command like so:

pod setup --verbose
