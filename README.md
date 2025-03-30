# kiss-dw-aw
Reliable bootup script for Direwolf 1.8DEV, AX25 and Netrom.
Script also 'kissattach'es AX25 to Direwolf1.8d.
Tested on Raspberry Zero W with latest bookworm firmware. 

Directionarys need to be updated with YOUR home folder name. 
Check all 3 files for ''<YOURFOLDER>'' and update as needed. 

The directions below assume you have installed all needed programs/stacks,
and have configured them. Dont forget your dialout permissions.

kiss-dw-aw.sh needs put in /home/<YOURFILE>/
  In Terminal:
  cmd: sudo chmod o+w --recursive /home/<YOURFILE>/kiss-dw-aw.sh
  
rc.local needs put in /etc/
OR!
add text line "bash /home/<YOURFOLDER>/kissdwaw.sh" to a excisting rc.local file

rc-local.service needs put in: /etc/systemd/system/ if it isnt there allready
  In Terminal:
  cmd: sudo systemctl enable rc-local
  cmd: sudo systemct1 start rc-local
  cmd: sudo systemctl daemon-reload
        (To stop for debugging: cmd: sudo systemct1 stop rc-local)
        (To review for debugging: cmd: sudo systemct1 status rc-local)
        
On rebooting (sudo reboot) you should have ax0 and nr0 listed if you check (ifconfig) in terminal.
This script can also be started on its own if you dont want to use the systemd boot using
  cmd: bash /home/<YOURFILE>/kiss-dw-aw.sh #This will also tell you whats not getting loaded in text
  
