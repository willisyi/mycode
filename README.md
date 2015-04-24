# mycode
All In one
文件目录如下
/DVR_RDK$ tree -L 1
.
├── 8168_Boa       			///source code for boa
├── DM81xx_DVR_RDK_Install_Guide.pdf
├── DM81xx_DVR_RDK_Overview.pdf
├── DM81xx_DVR_RDK_Release_Notes.pdf
├── DM81xx_DVR_RDK_Release_Summary.pdf
├── dvr_rdk				///source code of dm8168 link chain,your development dir
├── dvr_rdk_MsgQTest			///*source code of dm8168 link chain to test messageq
├── freetype-2.4.0			///componet needed by boa.has been installed.
├── freetype-2.4.0.tar.gz		///componet needed by boa.has been installed.
├── interface				///source code of boa,sysserver			
├── LiveServer				///source code of wis-streamer
├── openssl-1.0.0g.tar.gz		///componet needed by boa.has been installed.
├── pre_built_binary			///not used
├── ReadMe
├── source_tree
├── sys_server				///source code of sys_server
├── target
├── tftphome
├── ti_tools				///tool chain


How to make?
DM8168:go into dvr_rdk,and run "$run_make.sh ti816x-etv" in bash/dash shell
BOA: go into 8168_Boa dir,and refer "how to make"
LiveServer:go into LiveServer dir and read "how to make"
sys_server:go into sys_server/src dir and run make,if there's error"ln: 无法创建符号链接"../../target/rfs_816x/usr/share/zoneinfo/localtime": 没有那个文件或目录",ignore it.

