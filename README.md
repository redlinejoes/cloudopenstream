# What is this?
This is a series of PowerShell scripts inspried by accleration3's "cloudgamestream" and Parsec's Cloud Preperation Tool. This combines the best of both scripts. It allows you to use Moonlight on your cloud server, that may not be compatible with Gamestream, and sets up your Windows Server for gaming. All of this without activating old Windows features like Direct Play or changing wallpapers. It automatically installs Open-stream, Firefox, VBCable, Razer Surround, and uses Parsec's excellent GPU updater. Afterward, you can choose to install Steam and/or Playnite.

### What is Open-stream?
Open-stream is a remote desktop like application that allows users of the popular Moonlight application to use the desktop instead of their library of games. 

Join the Moonlight Discord here: https://moonlight-stream.org/discord

The Open-stream repo is here: https://github.com/LS3solutions/openstream-server

This happens to use the latest version in installer form, from the Moonlight Discord Server, but not all recent releases are guarenteed to be in installer form. In case the installer breaks, and so does the script, you can download the one from the website.  
https://open-stream.net/openstream_alpha_2312.1.exe

### Why should I use this?
This automatically prepares your Windows Server for gaming. This is important because most games will not function unless some of the "fixes" in this script are applied. You can do most of the functions manually, but that would take a long time to do wasting time/money.

This script does not require you to install AnyDesk and disable IE, you can just use RDP the whole time, even more time saved!

For more in-depth documentation, please visit the wiki page. 
https://github.com/rionthedeveloper/cloudopenstream/wiki

This should be compatible with...

### These Operating Systems:
* Windows Server 2016
* Windows Server 2019

### These GPUs:
* AWS G3.4xLarge (Tesla M60)
* AWS G2.2xLarge (GRID K520)
* AWS G4dn.xLarge (Tesla T4 with vGaming driver)
* AWS G4ad.2xlarge (AMD V520 with AMD driver)
* Azure NV6 (Tesla M60)
* Google P100 VW (Tesla P100 with Virtual Workstation Driver)
* Google P4 VW (Tesla P4 with Virtual Workstation Driver)
* Google T4 VW (Tesla T4 with Virtual Workstation Driver)

If your server type is not here, just choose "n" when asked about the GPU updater. Please stay in tune for a version for AMD GPUs and Windows 10. Sadly this script applies some of the fixes Paperspace should automatically apply when you launch your instance, so it may not be compatible with your Paperspace system. 

### What would this be useful for, doesn't `xyz` already work well?
Even though NiceDCV works very well, you're limited to the web browser, or a desktop enviroment (Windows, Mac, Linux). Forget running on a phone or a Raspberry PI. For Parsec, although it does work well, there is video compression that lots of people notice. There are also times where Parsec will suddenly freeze up. For example, you can take a look at TechGuru's video here: https://youtu.be/WUrlguuY5UU?t=378

However, these apps work exceptionally well at there job which is why they are an option in this script and even though Moonlight works REALLY well, it's not perfect. You'll just have a much better experience in many people's opinon. 

For example, take a look at what Acceleration3 (the creator of the cloudgamestream says)
https://www.reddit.com/r/cloudygamer/comments/i3pkpu/guide_enabling_nvidia_gamestream_on_a_cloud/

# How to start the script
You just need to install the newest release here: 
https://github.com/rionthedeveloper/cloudopenstream/releases

When you download it, extract the ZIP and you should see a folder with the name of the archive. Open it. Then just right click on the Powershell script called `setup.ps1`, the GPU Updater is like a step, it will automatically prompt you as you are using the script. 

Open-stream, Accleration3, or pretty much anything/one in this script or referenced is not related to the script. This is just a friendly way to get cloud gaming with Open-stream, which is an amazing project I've poured hours into using. If your `insert thing here` is included in the script, but you don't want it to be, I can remove it. Your `insert thing here` will be removed when the next version is released. 
