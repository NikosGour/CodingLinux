#!/bin/bash
function _backup()
{

    tar czvf "/tmp/Documents-backup-$(date +"%d-%m-%Y").tar.gz" ~/Documents > /dev/null 2> /dev/null
    echo "Creating backup..."
}

function _QR()
{
    read -p "Give the text for QR code :" p
    curl qrcode.show -d "$p" > /tmp/qr-file 2> /dev/null
    echo "qr file saved to /tmp/qr-file"
}

function _ip()
{
    echo "Your ip is $(curl icanhazip.com 2> /dev/null)"
}

#Select for the options
PS3="Please select an option: "
select ans in backup QR ip quit
do

    #for every option there is a function
    case $ans in
        backup) _backup;;
        QR)     _QR;;
        ip)     _ip;;
        quit)   break;;
        *) echo "Incorrect reply : $REPLY"
    esac

done