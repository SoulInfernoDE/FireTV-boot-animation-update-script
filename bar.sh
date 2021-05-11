#!/sbin/sh

# die when an error occurs
set -e

echo "Mounting /system writeable!"
mount -o rw /system
echo "DONE!"

export AFTV4KBAPMS="/system/media"
export AFTV4KBAPMM="/data/adb/modules/aftv-4k/system/media"
export BTAZIP="bootanimation.zip"
read -r -p "
###############################################################
# Bootanimation update script v0.1a @github.com/SoulInfernoDE #
###############################################################
# bootanimation.zip will be updated. Do you want to continue? #
#                                                             #
#   - Make sure zip is placed in /sdcard                      #
############################################################### 
(y|Y)es (n|N)o # " input

case $input in
    [yY][eE][sS]|[yY])
 echo "Executing..!"
 ;;
    [nN][oO]|[nN])
 echo "No, we stop here.."
 exit 1
       ;;
    *)
 echo "Invalid selection input.. ..aborting!"
 exit 1
 ;;
esac

echo "Removing old bootanimation.zip files.."

rm -f $AFTV4KBAPMS/$BTAZIP
rm -f $AFTV4KBAPMM/$BTAZIP

echo "DONE!"

echo "cp new $BTAZIP to '$AFTV4KBAPMS' and '$AFTV4KBAPMM'"

cp -f /sdcard/$BTAZIP $AFTV4KBAPMS/
cp -f /sdcard/$BTAZIP $AFTV4KBAPMM/

echo "DONE!"

echo "Modifying permissions to 644"

chmod 644 $AFTV4KBAPMS/$BTAZIP
chmod 644 $AFTV4KBAPMM/$BTAZIP

echo "DONE!"

read -r -p " Reboot now?
(y|Y)es (n|N)o #  " input2

case $input2 in
    [yY][eE][sS]|[yY])
 echo "Rebooting to system..!"
 ;;
    [nN][oO]|[nN])
 echo "No, we stop here.."
 exit 1
       ;;
    *)
 echo "Invalid selection input.. ..aborting!"
 exit 1
 ;;
esac

reboot system

