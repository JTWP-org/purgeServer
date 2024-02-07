#!/bin/bash
echo ''
gameserver=$1
echo ''
clear
sudo systemctl stop ${gameserver}
echo ''
cp /home/steam/${gameserver}/Pavlov/Saved/Config/LinuxServer/Game.ini /home/steam/${gameserver}/Pavlov/Saved/Config/LinuxServer/Game.ini.backup 
echo ''
echo 'Game.ini backed up to: /home/steam/'${gameserver}'/Pavlov/Saved/Config/LinuxServer/Game.ini.backup'
echo ''
today=$(date +%m-%d-%y)
echo ''
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
echo ''
sudo systemctl daemon-reload
echo ''
sudo systemctl start ${gameserver}
echo ''

echo '------------------------------'
echo ''
echo 'waiting 5 seconds'
sleep 5s
echo ''

sudo systemctl status ${gameserver} | grep ' Active:'
