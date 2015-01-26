/* ===========================================================================
* @path $(IPNCPATH)\include
*
* @desc
* .
* Copyright (c) Appro Photoelectron Inc.  2008
*
* Use of this software is controlled by the terms and conditions found
* in the license agreement under which this software has been supplied
*
* =========================================================================== */
#ifndef __SYSTEM_DEFAULT_H__
#define __SYSTEM_DEFAULT_H__
/* Macro */
#define IPV4(a,b,c,d)		((d<<24)|(c<<16)|(b<<8)|(a))
/*
#define SYS_FILE			"/mnt/nand/sysenv.cfg"
#define LOG_FILE			"/mnt/nand/logfile.log"
#define SYS_LOG_FILE 		"/mnt/nand/systemlog.log"
#define ACCESS_LOG_FILE 	"/mnt/nand/accesslog.log"
*/
#define SYS_FILE			"/etc/sysconfig/sysenv.cfg"
#define LOG_FILE			"/etc/sysconfig/logfile.log"
#define SYS_LOG_FILE 		"/etc/sysconfig/systemlog.log"
#define ACCESS_LOG_FILE 	"/etc/sysconfig/accesslog.log"


#define SUPPORT_REPORT 	    "/var/www/SupportReport.zip"
#define SD_PATH				"/mnt/mmc/ipnc"
#define TEMP_FOLDER			"/tmp"

#define TITLE_DEFAULT				"GUO_IPNC"
#define MODELNAME_DEFAULT			"DM8168_IPNC"

#define IP_DEFAULT					IPV4(192,168,  1,8 )
#define NETMASK_DEFAULT				IPV4(255,255,255,  0)
#define GATEWAY_DEAFULT				IPV4(192,168, 1,1)
#define DNS_DEFAULT					IPV4(192,168, 1,1)
#define HTTP_PORT_DEFAULT			80
#define HTTPS_PORT_DEFAULT			81
#define DHCP_ENABLE_DEFAULT			0
#define NTP_SERVER_DEFAULT			"tw.pool.ntp.org"
#define NTP_TIMEZONE_DEFAULT		20
#define NTP_FREQUENCY_DEFAULT		0
#define TIME_FORMAT_DEFAULT			0
#define DAYLIGHT_DEFAULT			0
#define DEVICE_TYPE_DEFAULT			0x1687
#define MAC_DEFAULT					{0x12,0x34,0x56,0x78,0x9a,0xbc}
#define FTP_SERVER_IP_DEFAULT		"192.168.1.1"
#define FTP_USERNAME_DEFAULT		"ftpuser"
#define FTP_PASSWORD_DEFAULT		"9999"
#define FTP_FOLDERNAME_DEFAULT		"default_folder"
#define FTP_IMAGEAMOUNT_DEFAULT 	5
#define FTP_PID_DEFAULT				0
#define SMTP_SERVER_IP_DEFAULT		"192.168.1.1"
#define SMTP_SERVER_PORT_DEFAULT	25
#define SMTP_AUTHENTICATION_DEFAULT	0
#define SMTP_USERNAME_DEFAULT		"smtpuser"
#define SMTP_PASSWORD_DEFAULT		"9999"
#define SMTP_SNEDER_EMAIL_DEFAULT	"user@domain.com"
#define SMTP_RECEIVER_EMAIL_DEFAULT	"user@domain.com"
#define SMTP_CC_DEFAULT				""
#define SMTP_SUBJECT_DEFAULT		"TI"
#define SMTP_TEXT_DEFAULT			"ti mail."
#define SMTP_ATTACHMENTS_DEFAULT	2
#define SMTP_VIEW_DEFAULT			0
#define MPEG4_RESOLUTION_DEF		0
#define MPEG4_RESOLUTION2_DEF		0
#define LIVE_RESOLUTION_DEF			0
#define MPEG4QUALITY_DEF			0
#define JPEGQUALITY_DEF				75
#define MIRROR_DEF					0
#define ADVMODE_DEF 				0
#define M41SFEAT_DEF 				0
#define M42SFEAT_DEF				0
#define JPGSFEAT_DEF				0
#define FDETECT_DEF 				0
#define REGUSR_DEF					"User1"
#define DEMOCFG_DEF					0
#define	OSDSTREAM_DEF				0
#define	OSDWINNUM_DEF				0
#define	OSDWIN_DEF					0
#define	HISTOGRAM_DEF				0
#define DYNRANGE_DEF				0
#define	OSDTEXT_DEF					"IPNetCam"
#define	DUMMY_DEF					0
#define FTP_PORT_DEFAULT			21
#define AEW_SWITCH_DEFAULT			1
#define AEW_TYPE_DEFAULT			3
#define SUPPORTMPEG4_DEFAULT		1
#define IMAGEFORMAT_DEFAULT			1
#define IMAGESOURCE_DEFAULT			0
//#define MAX_FRAMERATE_DEFAULT		30000
#define MAX_FRAMERATE_DEFAULT		60000
#define DEFAULTSTORAGE_DEFAULT		1
#define DEFAULTCARDGETHTM_DEFAULT	"sdget.htm"
#define BRANDURL_DEFAULT			"www.ti.com"
#define BRANDNAME_DEFAULT			"TEXAS INSTRUMENTS INC"
#define SUPPORTTSTAMP_DEFAULT		1
#define	MPEG41XSIZE_DEFAULT			1280
#define	MPEG41YSIZE_DEFAULT			720
#define	MPEG42XSIZE_DEFAULT			352
#define	MPEG42YSIZE_DEFAULT			192
#define JPEGXSIZE_DEFAULT			640
#define JPEGYSIZE_DEFAULT			352
#define SUPPORTMOTION_DEFAULT		2
#define SUPPORTWIRELESS_DEFAULT		0
#define SERVICEFTPCLIENT_DEFAULT	1
#define SERVICESMTPCLIENT_DEFAULT	1
#define SERVICEPPPOE_DEFAULT		0
#define SERVICESNTPCLIENT_DEFAULT	1
#define SERVICEDDNSCLIENT_DEFAULT	0
#define SUPPORTMASKAREA_DEFAULT		0
#define MAXCHANNEL_DEFAULT			1
#define SUPPORTRS485_DEFAULT		0
#define SUPPORTRS232_DEFAULT		1
#define LAYOUTNUM_DEFAULT			0
#define SUPPORTMUI_DEFAULT			0
#define MUI_DEFAULT					0
#define SUPPORTSEQUENCE_DEFAULT		0
#define QUADMODESELECT_DEFAULT		-1
#define SERVICEIPFILTER_DEFAULT		0
#define OEMFLAG0_DEFAULT			1
#define	SUPPORTDNCONTROL_DEFAULT	0
#define SUPPORTAVC_DEFAULT			0
#define SUPPORTAUDIO_DEFAULT		1
#define SUPPORTPTZPAGE_DEFAULT		1
#define WHITEBALANCE_DEFAULT		0	/* auto white balance */
#define DAY_NIGHT_DEFAULT			1	/* Default: Day mode */
#define LOCALDISPLAY_DEFAULT		0
#define BINNING_DEFAULT				0
#define BACKLIGHT_CONTROL_DEFAULT	1
#define BACKLIGHT_VALUE_DEFAULT		1
#define BRIGHTNESS_DEFAULT			128
#define CONTRAST_DEFAULT			128
#define SATURATION_DEFAULT			128
#define SHARPNESS_DEFAULT			128
#define STREAMTYPE_DEFAULT			0
#define VCODECMODE_DEFAULT			0
#define VCODECCOMBO_DEFAULT			0
#define VCODECRES_DEFAULT			0
#define VCODECLEVEL_DEFAULT         0
#define SUPPORTSTREAM1_DEFAULT		0
#define SUPPORTSTREAM2_DEFAULT		0
#define SUPPORTSTREAM3_DEFAULT		0
#define SUPPORTSTREAM4_DEFAULT		0
#define SUPPORTSTREAM5_DEFAULT		1
#define SUPPORTSTREAM6_DEFAULT		0
#define RATECONTROL_DEFAULT			1		/* Set to CVBR */
//#define FRAMERATE1_DEFAULT			0
#define FRAMERATE1_DEFAULT			60

#define FRAMERATE2_DEFAULT			0
#define FRAMERATE3_DEFAULT			0
//#define MPEG41BITRATE_DEFAULT		5000000  //commented by lyy
#define MPEG41BITRATE_DEFAULT		8000000
#define MPEG42BITRATE_DEFAULT		512000
#define DHCP_CONFIG_DEFAULT			0
#define NO_SCHEDULE					{0,1,{0,0,0},{0,0,0}}
#define SCHEDULE_DEFAULT			{NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE,NO_SCHEDULE}
#define LOSTALARM_DEFAULT			0
#define SDAENABLE_DEFAULT			0
#define ALARMDURATION_DEFAULT		1
#define AFTPENABLE_DEFAULT			0
#define ASMTPENABLE_DEFAULT			0
#define AVIDURATION_DEFAULT			0
#define AVIFORMAT_DEFAULT			0
#define FTPFILEFORMAT_DEFAULT		0
#define SDFILEFORMAT_DEFAULT		0
#define ATTFILEFORMAT_DEFAULT		0

#define ASMTPATTACH_DEFAULT			0
#define RFTPENABLE_DEFAULT			0
#define SD_INSERT_DEFAULT			0
#define SDRENABLE_DEFAULT			0
#define AUDIOENABLE_DEFAULT			0
#define MOTIONENABLE_DEFAULT		0
#define MOTIONCENABLE_DEFAULT		0
#define MOTIONLEVEL_DEFAULT			1
#define MOTIONCVALUE_DEFAULT		50
#define MOTIONBLOCK_DEFAULT			"000"

#define PTZZOOMIN_DEFAULT			"0"	//"zoomin"
#define PTZZOOMOUT_DEFAULT			"0"	//"zoomout"
#define PTZPANUP_DEFAULT			"0"	//"up"
#define PTZPANDOWN_DEFAULT			"0"	//"down"
#define PTZPANLEFT_DEFAULT			"0"	//"left"
#define PTZPANRIGHT_DEFAULT			"0"	//"right"

//GIO
#define	GIOINENABLE_DEFAULT		0
#define	GIOINTYPE_DEFAULT		0
#define	GIOOUTENABLE_DEFAULT	0
#define	GIOOUTTYPE_DEFAULT		0

#define DATEFORMAT_DEFAULT 			2
#define TSTAMPENABLE_DEFAULT 		0
#define TSTAMPFORMAT_DEFAULT 		1
#define AUDIOINVOLUME_DEFAULT 		2
#define ALARMSTATUS_DEFAULT			0
#define MULTICAST_ENABLE_DEFAULT	0

/* authority AUTHORITY_NONE = 9 */
#define NONE_ACOUT				{"", "", 9}
#define ADMIN_ACOUT				{"admin", "9999", 0}
#define ACOUNT_DEFAULT			{ADMIN_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, \
							 	NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT, NONE_ACOUT}
#define ACOUNT_TIME_DEFAULT		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
#define CUR_LOG_DEFAULT			{"", {0, 0, 0, 0, 0, 0, 0, 0, 0}}

#endif   /* __SYSTEM_DEFAULT_H__ */
