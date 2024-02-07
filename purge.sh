#!/bin/bash

gameserver=$1

clear
sudo systemctl stop ${gameserver}

cp /home/steam/${gameserver}/Pavlov/Saved/Config/LinuxServer/Game.ini /home/steam/${gameserver}/Pavlov/Saved/Config/LinuxServer/Game.ini.backup 

echo 'Game.ini backed up to: /home/steam/'${gameserver}'/Pavlov/Saved/Config/LinuxServer/Game.ini.backup'

today=$(date +%m-%d-%y)

echo '
[/Script/Pavlov.DedicatedServer]
bEnabled=true
ServerName="Server Purged '"${today}"'"
MaxPlayers=10
#ApiKey="'${API}'"
bSecured=true
bCustomServer=true
bVerboseLogging=false
bCompetitive=false
bWhitelist=false
RefreshListTime=120
LimitedAmmoType=0
TickRate=90
TimeLimit=60
#Password=0000
#BalanceTableURL="vankruptgames/BalancingTable/main"
MapRotation=(MapId="sand", GameMode="DM")
' > "/home/steam/${gameserver}/Pavlov/Saved/Config/LinuxServer/Game.ini"

sudo systemctl daemon-reload

sudo systemctl start ${gameserver}

clear
echo '------------------------------'
echo ''
echo 'waiting 5 seconds'
sleep 5s
echo ''

sudo systemctl status ${gameserver} | grep ' Active:'
