/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : All Streams Video Settings  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/
/*
Displays all available streams
*/

option(4+1)
dimi timerCount  
/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Macro Defines � menu display and settings page  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/














SETOSVAR("*FLUSHEVENTS", "")




/****************************************************************************
 * gTI IPNC - Common �
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights
 * reserved.
 *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT 
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER 
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, 
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) 
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB 
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
 *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN
 * PERMISSION FROM GoDBTech.
 ***************************************************************************/
 

/***********************************************************

 * Description: 
 * Generate the authentication header
 * 
 * Params:

 * dims password$: String - Password
 * Created by: Partha Sarathi.K On 2009-02-27 15:16:53
 ***********************************************************/
� generateauthHeader$(dims userName$, dims password$) 
 dims Src$,Dest$ 
 dimi ret
 dims temp$,destTemp$
 
 Src$=userName$+":"+password$  
 � "Before encode: " + Src$ + " : " + Dest$
 ret = Encode(Src$,Dest$,1) 
 � "Encode ret = "+ret
 temp$ = Src$+":"+~rememberPwd
 ret = Encode(temp$,destTemp$,1) 
 � "Write Profile = " + destTemp$
 writeprofile("IPNC",destTemp$)
 generateauthHeader$ = Dest$
 
�F

/***********************************************************

 * Description: � this � � 
 * calculate width and height � the stream aspect ratio

 * Params:
 * byref dimi gdoCurWidth: Numeric - Video Width
 * byref dimi gdoCurHeight: Numeric - Video Height
 * dimi xRatio: Numeric - Stream x ratio
 * dimi yRatio : Numeric - Stream y ratio
 * Created by: On 2009-06-30 14:37:28
 ***********************************************************/
� checkAspectRatio(byref dimi gdoCurWidth, byref dimi gdoCurHeight,dimi xRatio,dimi yRatio)
 � "gdoCurWidth = " + gdoCurWidth
 � "gdoCurHeight = " + gdoCurHeight

 � xRatio = 0 � xRatio = 1
 � yRatio = 0 � yRatio = 1

 Dimi TempW, TempH
 TempW = gdoCurHeight * xRatio/yRatio
 �B TempW > gdoCurWidth �
 TempH = gdoCurWidth * yRatio/xRatio
 gdoCurHeight = TempH
 �C
 gdoCurWidth = TempW
 �D
 
 gdoCurWidth = gdoCurWidth/16
 gdoCurWidth = gdoCurWidth*16
 
 � "gdoCurWidth = " + gdoCurWidth
 � "gdoCurHeight = " + gdoCurHeight
�F

/***********************************************************

 * Description: � this � � create GDO control(Video player)
 
 * Params:




 * dimi gdoH: Numeric - control h value
 * Created by: On 2009-06-19 12:31:55
 ***********************************************************/
� createGDOControl(dims ctrlname$, dimi gdoCurX, dimi gdoCurY, dimi gdoCurWidth, dimi gdoCurHeight)
 createobject("GDO", ctrlname$, " x='" + gdoCurX + "' y='" + gdoCurY + "' w='" + gdoCurWidth + "' h='" + gdoCurHeight +"' ProgID='Gffx.GFFMpeg.1'" )
 #{ctrlName$}.scrollable=0  
�F

/***********************************************************

 * Description: 
 * Load data into arraystring and check each key value � Validaion 

 * Params:


 * keypressed$: String - Keypressed value
 * Created by: Franklin Jacques On 2009-03-03 17:25:00
 ***********************************************************/
� CheckKey(Key,rule,keypressed$)
 dims strsplit$,charset$
 dimi num
 
 strsplit$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .~"_
 "1234567890.~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/-,. ()[]#~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,-_.:/ ~"_
 "1234567890~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-/ ~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ .~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/~"_
 "1234567890#@/~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@_-~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@#$%^&*()_<>?/{}[]~"_
 "123456789~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.~"_
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_~"  
 num=�<(charset$,strsplit$,"~")
 
 �B Key > 31 and rule > 0 �
 � �&(charset$(rule-1),�7(keypressed$))=-1 � CheckKey=1
 �D
 
�F


/***********************************************************

 * Description: 
 * Add the option values into the drop down box.
 * 
 * Params:

 * dims items$: String - Items � added � the drop down
 * dimi selIndex: Numeric - Drop down selected item.
 * Created by: Partha Sarathi.K  On 2009-02-26 19:20:58
 * Modified by: Vimala On 2009-08-05 11:22:45
 ***********************************************************/
�h addItemsToDropDown(dims controlName$, dims items$(), dimi selItem)
 
 dimi ret
 dimi index
 dims tempVal$
 
 
 #{controlName$}.removeall()
 
 
 ret = ��(items$)
 � ret < 0 � �
 � index = 0 � ret
 �B �#(items$(index)) <> "" � 
 #{controlName$}.additem(index, items$(index))
 �D
 �
 
 
 � selItem == -1 or selItem > ret � selItem = 0
 #{controlName$}$ = selItem
 
�F



/***********************************************************

 * Description: 
 * Display the controls based on the screen resolution.
 * Set the X and Y pos � form controls and it's properties.  

 * Created by:vimala  On 2009-04-03 11:21:04
 ***********************************************************/
�h displayControls(dims LabelName$(),dimi XPos(),dimi YPos(),dimi Wdh(),dimi height()) 
 dimi i
 
 �B  ~menuXRes > 1024 �  
 � i = 0 � ��(LabelName$) 
 �B XPos(i)> 70 � 
 XPos(i) = XPos(i) - 20  
 �C
 XPos(i) = XPos(i) - 5 
 �D 
 �
 �D
 
 � i = 0 � ��(LabelName$) 
 #{LabelName$(i)}.x = XPos(i)* ~factorX  
 #{LabelName$(i)}.y = YPos(i)* ~factorY

 �B �&(LabelName$(i),"img")= -1 �
 #{LabelName$(i)}.w = Wdh(i)* ~factorX
 �D
 
 �  
 
�F

/***********************************************************

 * Description: � this � � assign image
 * 
 * Params:


 * dims imageNameOff$: String - OFF image name
 * Created by:Vimala  On 2009-05-19 10:26:24
 * History: 
 ***********************************************************/
�h showimages(dims ctrlName$,dims imageNameOn$,dims imageNameOff$) 
 �B #{ctrlName$}.src$ = imageNameOn$ � 
 #{ctrlName$}.src$ = imageNameOff$
 �C
 #{ctrlName$}.src$ = imageNameOn$
 �D
�F


/***********************************************************

 * Description: � this � � add hour,minute and 
 * seconds values � drop down
 * Params:

 * dimi maxValue: Numeric - Maximum value � be add � the drop down.
 * Created by: vimala On 2009-03-17 17:47:16
 * History: 
 ***********************************************************/
�h loadTimeValues(dims ctrlName$,dimi maxValue) 
 dimi idx
 dims itemVal$
 
 � idx = 0 � maxValue
 itemVal$ = idx
 � idx < 10 � itemVal$ = "0" + idx  
 #{ctrlName$}.additem(itemVal$,itemVal$) 
 �  
 
�F


/***********************************************************

 * Description: � this � � calculate aspect ratio � the 
 * selected stream
 * Params:


 * dimi byref yRatio: Numeric - returns the calculated Y ratio
 * Created by: On 2009-09-07 12:45:34
 * History: 
 ***********************************************************/
�h calVideoDisplayRatio(dims selectedStream$,byref dimi xRatio,byref dimi yRatio) 
 dimi gcdValue,startPos,endPos,splitCount,xResVal,yResVal
 dims streamRes$,splitArray$  
 startPos = �&(selectedStream$,"(")
 endPos = �&(selectedStream$,")")
 streamRes$ = �%(selectedStream$,startPos+1,endPos-startPos)
 splitCount = �<(splitArray$,streamRes$,"x")
 
 �B splitCount = 2 �
 xResVal = strtoint(splitArray$(0))
 yResVal = strtoint(splitArray$(1))
 gcdValue = GCD(xResVal,yResVal)
 � xResVal/gcdValue
 � yResVal/gcdValue  
 xRatio = xResVal/gcdValue
 yRatio = yResVal/gcdValue  
 � xRatio
 � yRatio
 � 1
 �D  
 
 � 0
�F


/***********************************************************

 * Description: � this � � get the selected stream resolution
 * 
 * Params:


 * byref dimi yRes: Numeric - Y Resolution
 * Created by: On 2009-09-23 17:08:49
***********************************************************/
�h getCurStreamResolution(dims selectedStream$,byref dimi xRes,byref dimi yRes)
 �B selectedStream$ <> "" �
 dimi startPos,endPos,splitCount,xResVal,yResVal
 dims streamRes$,splitArray$  
 startPos = �&(selectedStream$,"(")
 endPos = �&(selectedStream$,")")
 streamRes$ = �%(selectedStream$,startPos+1,endPos-startPos)
 splitCount = �<(splitArray$,streamRes$,"x")
 
 �B splitCount = 2 �
 xRes = strtoint(splitArray$(0))
 yRes = strtoint(splitArray$(1))
 �D
 �C 
 xRes = 0
 yRes = 0
 �D
 
�F


/***********************************************************

 * Description: � this � � �& GCD of two numbers  
 * 
 * Params:

 * num2: Numeric - Y resolution
 * Created by:S.Vimala On 2009-09-07 10:45:09
 ***********************************************************/
� GCD(num1,num2) 
 � num1=0 and num2=0 � � 1
 � num2=0 � � num1
 � GCD(num2,num1%num2) 
�F

/***********************************************************

 * Description: � this � � get user typein URL from 
 * CommandLine Parameters Passed � the GoDB VM
 * 
 * Created by: On 2010-12-20 10:16:33
***********************************************************/
�h ModifyStreamUrl(byref dims stream$())
 dimi location
 dims tmpvalue$,fin$
 location = �&(stream$(1),":",7)
 tmpvalue$ = �%(stream$(1),location,� (stream$(1))) 
 fin$ = "rtsp://"+�%(~camAddPath$,�&(~camAddPath$,"//")+2,� (~camAddPath$)-8)+tmpvalue$
 stream$(1)=fin$
�F

/***********************************************************

 * Description: � this � � get stream names and its rtsp urls
 * 
 * Created by:Vimala  On 2009-09-08 16:02:29
 ***********************************************************/
�h loadStreamDetails(byref dims stream$(),byref dims rtspUrl$()) 
 
 dims streamName1$,streamName2$,streamName3$
 dims tempStream1$,tempStream2$,tempStream3$
 dimi videocodec,sptCount1,sptCount2,sptCount3
 dimi retVal,i
 
 
 retVal = getStreamDisplayOrder(videocodec,streamName1$,streamName2$,streamName3$)
 � streamName1$;streamName2$;streamName3$
 
 �B retVal>=0 �
 
 sptCount1 = �<(tempStream1$,streamName1$,"@")
 sptCount2 = �<(tempStream2$,streamName2$,"@")
 sptCount3 = �<(tempStream3$,streamName3$,"@")
 � ModifyStreamUrl(tempStream1$) 
 � ModifyStreamUrl(tempStream2$)
 � ModifyStreamUrl(tempStream3$) 
 �B videocodec = 0 �  
 �B sptCount1 = 2 �
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 �D
 �y videocodec = 1 �
 �B sptCount1 = 2 �
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 �D
 �B sptCount2 = 2 �
 stream$(1) = tempStream2$(0)
 rtspUrl$(1) = tempStream2$(1)
 �D
 �y videocodec = 2 �
 �B sptCount1 = 2 �
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 �D
 �B sptCount2 = 2 �
 stream$(1) = tempStream2$(0)
 rtspUrl$(1) = tempStream2$(1)
 �D
 �B sptCount3 = 2 �
 stream$(2) = tempStream3$(0)
 rtspUrl$(2) = tempStream3$(1)
 �D
 �D
 �C 
 �("Valid stream not available")
 �_("!auth.frm")
 �D  
 
�F


/***********************************************************

 * Description: � this � � get camera IP address from 
 * CommandLine Parameters Passed � the GoDB VM
 * 
 * Created by: On 2009-09-23 10:16:33
***********************************************************/
�h GetIPAddress()
 dims cmdline$
 dimi file
 cmdline$ = ��("*CMDLINE")
 �B �&(cmdline$, "http:") = 0 �
 ~uiType = 2  
 dimi pos1
 pos1 = �&(cmdline$, "/", 0, 1)
 �B pos1 > 0 �
 ~camAddPath$ = �%(cmdline$, 0, pos1+1)
 �C
 ~camAddPath$ = cmdline$
 �D
 �C  
 dims ipAddress$
 file = �K("ip.txt", 1, 1)
 
 �B file <> -1 �
 ipAddress$ = �L(file)
 ~camAddPath$ = "http://"+�#(ipAddress$)+"/"
 �O(file)
 �D
 
 �D
�F

/***********************************************************

 * Description: � this � � get user authourity � logged in 
 user name.
 
 * Created by: Vimala On 2009-05-17 22:55:12
 ***********************************************************/
� getUserAuthority
 dims user$(10)
 dims authority$(10)
 dimi retVal,retVal1,i,sptidx
 dimi retFlag
 
 retVal = getPropValue("user", user$)
 retVal1 = getPropValue("authority", authority$) 
 
 �B retVal >= 0  and retVal1 >= 0 �  
 dims username$(2)
 dims authname$(2) 
 retFlag = -1
 � i = 0 � ��(user$)
 sptidx = �<(username$,user$(i),":")
 �B sptidx = 2 �
 sptidx = �<(authname$,authority$(i),":")
 �B sptidx = 2 � 
 �B username$(1) = ~authUserName$ �
 ~loginAuthority = �(authname$(1))
 retFlag = 0
 � 1
 �E  
 �D
 �D
 �D
 �
 �  "retFlag="+ retFlag  
 � retFlag = -1 � � -1  
 �y retVal = -20 �
 ~loginAuthority = 2  
 � 1
 �C
 � -1  
 �D  
 
�F


/***********************************************************

 * Description: Calculates X,Y position based on the screen resolution
 with screen designed resolution
 
 * Created by: Vimala On 2009-03-23 16:28:40
 ***********************************************************/
�h calXYVal() 
 dimf designX ,designY
 dimf ~factorX,~factorY
 designX = 1024
 designY = 650  
 ~factorX = ~menuXRes/designX  
 � ~factorX <= 1 � ~factorX = 1  
 ~factorY = ~menuYRes/designY  
 � ~factorY <= 1 � ~factorY = 1
 � "designX: "; designX; "~menuXRes: "; ~menuXRes; "  ~factorX = " + �$("10.2",~factorX)
 � "designY: "; designY; "~menuYRes: "; ~menuYRes; "  ~factorY = " + �$("10.2",~factorY)
�F

/***********************************************************

 * Description:� this � � animate displayMsg with dots
 
 * Params:

 * dims displayMsg$: String - Message string � be animated
 * Created by:Vimala  On 2010-04-13 18:33:39
 ***********************************************************/
�h animateLabel(dims ctrlName$, dims displayMsg$) 
 dims tempMsg$
 timerCount++
 � timerCount > 4  � timerCount=1
 �B timerCount = 1 � 
 tempMsg$ = displayMsg$ + " . "  
 �y timerCount = 2 �
 tempMsg$ = displayMsg$ + " . ."
 �y timerCount = 3 �  
 tempMsg$ = displayMsg$ + " . . ." 
 �y timerCount = 4 �  
 tempMsg$ = displayMsg$ + " . . . ." 
 �D
 
 #{ctrlName$}$ = tempMsg$
 
 �() 
�F


/***********************************************************

 * Description: 
 * 
 * 
 * Params:
 * dims streamName$: String - 
 * Created by: On 2010-07-06 15:25:29
 * History: Karthi on 04-Oct-10
 ***********************************************************/
� checkForStreamRes(dims streamName$)
 checkForStreamRes = 0
 dimi xRes,yRes
 getCurStreamResolution(streamName$,xRes,yRes)
 
 �B streamName$ = "JPEG(2592x1920)" �
 �B xRes > 2048 or yRes > 2048 �
 checkForStreamRes = 1
 �D
 �D
 
�F

/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Function.inc  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/


/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Keywords.inc  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/



 
� cameraKeywords$(10000)
/*Live Video*/
cameraKeywords$ = ",audioenable|Audio Enable,rotctrl|Rotation,clicksnapfilename|Snap Filename,"_
 ",clicksnapstorage|Snap Storage,democfg|Example,"
/*Network Setting*/
cameraKeywords$ += ",ftpip|FTP Server ,ftpuser|FTP Username,ftppassword|FTP Password,"_
 ",ftppath|File Upload Path,ftpipport|FTP Port,"_
 ",smtpuser|SMTP A/c Name,smtppwd|SMTP Password,smtpsender|SMTP Sender,"_
 ",smtpip|SMTP Server,emailuser|Email,smtpauth|SMTP Server Authentication,"_
 ",sntpip|SNTP Server,"_
 ",httpsport|HTTPS Port,portinput|Port Input,"_
 ",portoutput|Port Output,rs485|RS485,"_
 ",netip|IP Address,netmask|Netmask,gateway|Default Gateway,dnsip|Primary Name,httpport|HTTP Port,"_
 ",multicast|MultiCast,sntpip|SNTP IP,"
/*Storage setting*/
cameraKeywords$ +=",rftpenable|Upload Via FTP,ftpfileformat|FTP File Format,sdrenable|Local Storage,"_
 ",sdfileformat|Local Storage File Format,"_
 ",recordlocalstorage|Storage Format,schedulerepeatenable|Schedule Expires After,"_
 ",schedulenumweeks|Number Of Weeks,scheduleinfiniteenable|Run Infinity Times,"
/*Video Analytics Settings*/
cameraKeywords$ +=",fdetect|Face Detect,fdx|X,fdy|Y,fdw|W,fdh|H,fdconflevel|Face Detection Confidence Level,"_
 ",fddirection|Direction,frecognition|Face Recognition,frconflevel|Face Recognition Confidence Level,"_
 ",frdatabase|Database,privacymask|Privacy mask,maskoptions|Mask Option,"
/*Motion Detction */ 
cameraKeywords$ +=",motionsensitivity|Sensitivity,motioncvalue|Threshold Value,"
/*Camera Setting*/ 
cameraKeywords$ +=",brightness|Brightness,contrast|Contrast,saturation|Saturation,sharpness|Sharpness,"_
 ",blc|BLC,lbce|LBCE,awb|White Balance,colorkiller|Mode,exposurectrl|Exposure Control,"_
 ",priority|Priority,maxexposuretime|Max Exposure Time,"_
 ",maxgain|Max Gain,nfltctrl|Spatial Filter,tnfltctrl|Temporal Filter,"_
 ",vidstb1|Video Stabilization,lensdistortcorrection|Lens Distortion Correction,"_
 ",binning|Image Sensor Mode,img2a|2A Type,histogram|Historgram,"
/*Audio Setting*/ 
cameraKeywords$ +=",audioenable|Enable Audio,audiomode|Audio Mode,audioinvolume|Input Volume,"_
 ",encoding|Encoding,samplerate|Sample Rate,audiobitrate|Bit Rate,"_
 ",alarmlevel|Alarm Level,audiooutvolume|Output volume,"
/*�/� Setting*/
cameraKeywords$ +=",date|Date,time|Time,timezone|Time Zone,daylight|Daylight Saving Time,"_
 ",timeformat|Date Fromat,tstampformat|Time Format,dateposition|Date Position,timeposition|Time Position,"
/*Alarm Setting*/ 
cameraKeywords$ +=",alarmenable|Enable Alarm,alarmduration|Alarm Duration,alarmperiodicity|Alarm Periodicity,"_
 ",motionenable|Motion Detection,lostalarm|Ethernet Lost,darkblankalarm|Dark/Blank Images,"_
 ",extalarm|External Trigger,exttriggerinput|Input,exttriggeroutput|Output,"_
 ",aftpenable|Upload Via FTP,ftpfileformat|FTP File Format,asmtpenable|Upload Via SMTP,"_
 ",attfileformat|SMTP File Format,asmtpattach|No Of Files to attach,"_
 ",sdaenable|Local Storage,sdfileformat|Local Storage File format,alarmlocalstorage|Storage location,"_
 ",alarmaudioplay|Play Audio,alarmaudiofile|Alarm Audio Files,"
/*Video Image Setting*/ 
cameraKeywords$ +=",videocodec|Stream Type,videomode|Codec Combo,videocodecres|Resolution,"_
 ",framerate1|Stream 1 Frame Rate,bitrate1|Stream 1 Bit Rate,ratecontrol1|Stream 1 Rate Control,"_
 ",datestampenable1|Stream 1 Date,timestampenable1|Stream 1 Time,logoenable1|Stream 1 Logo,"_
 ",logoposition1|Stream 1 Logo Position,textenable1|Stream 1 Text Enable,overlaytext1|Stream 1 Text,"_
 ",textposition1|Stream 1 Text Position,"_
 ",encryptvideo|Encrypt Video,localdisplay|Local Display video,rotctrl|Rotate,mirctrl|Mirror,"_
 ",framerate2|Stream 2 Frame Rate,bitrate2|Stream 2 Bit Rate,ratecontrol2|Stream 2 Rate Control,"
cameraKeywords$ +=",datestampenable2|Stream 2 Date,timestampenable2|Stream 2 Time,logoenable2|Stream 2 Logo,"_
 ",logoposition2|Stream 2 Logo Position,textenable2|Stream 2 Text Enable,overlaytext2|Stream 2 Text,"_
 ",textposition2|Stream 2 Text Position,"_
 ",jpegframerate|jpeg Frame Rate,livequality|Quality Factor,"_
 ",datestampenable3|Stream 3 Date,timestampenable3|Stream 3 Time,logoenable3|Stream 3 Logo,"_
 ",logoposition3|Stream 3 Logo Position,textenable3|Stream 3 Text Enable,overlaytext3|Stream 3 Text,"_
 ",textposition3|Stream 3 Text Position,"
cameraKeywords$ +=",detailinfo1|Detailed info ,aviformatname|Stream,aviduration|Video Size,title|Device Name ,"

/*Video Image Setting - Advanced*/ 
cameraKeywords$ +=",ipratio1|Stream 1 IP Ratio,forceiframe1|Stream 1 Force I Frame,qpmin1|Stream 1 QP Min,"_
 ",qpmax1|Stream 1 QP Max,meconfig1|Stream 1 ME Config,packetsize1|Stream 1 Packet Size,umv1|Stream 1 UMV,"_
 ",intrapframe1|Stream 1 Infra in P Frame,regionofinterestenable1|Stream 1 Region of Interest,"_
 ",str1x1|Stream 1 Region1 X,str1y1|Stream 1 Region1 Y,str1w1|Stream 1 Region1 Width,str1h1|Stream 1 Region1 Height,"_
 ",str1x2|Stream 1 Region2 X,str1y2|Stream 1 Region2 Y,str1w2|Stream 1 Region2 Width,str1h2|Stream 1 Region2 Height,"_
 ",str1x3|Stream 1 Region3 X,str1y3|Stream 1 Region3 Y,str1w3|Stream 1 Region3 Width,str1h3|Stream 1 Region3 Height,"
cameraKeywords$ +=",ipratio2|Stream 2 IP Ratio,forceiframe2|Stream 2 Force I Frame,qpmin2|Stream 2 QP Min,"_
 ",qpmax2|Stream 2 QP Max,meconfig2|Stream 2 ME Config,packetsize2|Stream 2 Packet Size,umv2|Stream 2 UMV,"_
 ",intrapframe2|Stream 2 Infra in P Frame,regionofinterestenable2|Stream 2 Region of Interest,"_
 ",str2x1|Stream 2 Region1 X,str2y1|Stream 2 Region1 Y,str2w1|Stream 2 Region1 Width,str2h1|Stream 2 Region1 Height,"_
 ",str2x2|Stream 2 Region2 X,str2y2|Stream 2 Region2 Y,str2w2|Stream 2 Region2 Width,str2h2|Stream 2 Region2 Height,"_
 ",str2x3|Stream 2 Region3 X,str2y3|Stream 2 Region3 Y,str2w3|Stream 2 Region3 Width,str2h3|Stream 2 Region3 Height,"
cameraKeywords$ +=",ipratio3|Stream 3 IP Ratio,forceiframe3|Stream 3 Force I Frame,qpmin3|Stream 3 QP Min,"_
 ",qpmax3|Stream 3 QP Max,meconfig3|Stream 3 ME Config,packetsize3|Stream 3 Packet Size,umv3|Stream 3 UMV,"_
 ",intrapframe3|Stream 3 Infra in P Frame,regionofinterestenable3|Stream 3 Region of Interest,"_
 ",str3x1|Stream 3 Region1 X,str3y1|Stream 3 Region1 Y,str3w1|Stream 3 Region1 Width,str3h1|Stream 3 Region1 Height,"_
 ",str3x2|Stream 3 Region2 X,str3y2|Stream 3 Region2 Y,str3w2|Stream 3 Region2 Width,str3h2|Stream 3 Region2 Height,"_
 ",str3x3|Stream 3 Region3 X,str3y3|Stream 3 Region3 Y,str3w3|Stream 3 Region3 Width,str3h3|Stream 3 Region3 Height,"


/*
varName$() - String array: Holds Variable names which returns fetched value from camera
propName$() - String array: IPNC keyword prefixed with character "g"  
~iniProperties$()- String array: Holds all the camera keywords required � GUI
~iniPropValues$ - String array: Holds keyword values which is fetched from IPNC
~errorKeywords$ - String : holds all the failure keywords


Common Methods :
 * chkRetStatusAndUpdate$(dims responseStaus$,dims propName$(),dims propValue$()) 
 - Parse the response string � identify the failure keywords
 - �B response is not "ok" � any keyword � its a failure keyword
 * � updateLatestValues(propName$,propValue$)
 - � this � � � the modified value in ~iniPropValues$ array  
 
*/
 

/***********************************************************

 * Description: Get drop down values from camera  * 
 * Returns 0 � Success; -1 failure

 * Params:











 * Created by: vimala On 2009-05-08 13:55:29
 ***********************************************************/
� getcameraSettingOptions(byref dims whiteBalance$(), byref dims exposureCtrl$(), _
 byref dims maxExpTime$(), byref dims maxGain$(), _
 byref dims spatialFilter$(), byref dims imgSensor$(),_
 byref dims twoAType$(), byref dims backlightname$(), _
 byref dims twoAMode$(), byref dims priorityName$(),byref dims dynrangename$()) 

 
 dims varName$(11) = ("whiteBalance$","exposureCtrl$","maxExpTime$","maxGain$", _
 "spatialFilter$","imgSensor$","twoAType$","backlightname$","twoAMode$","priorityName$","dynrangename$") 
 
 dims propName$(11) = ("gawbname","gexposurename","gmaxexposuretimename","gmaxgainname", _
 "gnfltctrlname","gbinningname","gimg2aname","gbacklightname","gimg2atypename","gpriorityname","gdynrangename")
 dims tempVal$(11)
 dimi idx, splitidx, retVal,sptCount  
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx= 0 � ��(tempVal$)
 
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount>0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �
 
 �D
 
 � retVal
 
�F

/***********************************************************

 * Description: � this � � get camera name.
 
 * Created by: Vimala On 2009-03-10 12:42:41
 ***********************************************************/
� getTitle$() 
 dims varName$(1) = ("title$")
 dims propName$(1) = ("gtitle")
 dims tempVal$(1) 
 dimi retVal
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 getTitle$ = tempVal$(0)
 �D
 
 � retVal
 
�F

/***********************************************************

 * Description: 
 * Provides the current mode setting values in the camera
 * Returns 0 � Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Camera Settings
 * Params:





















 * Created by: vimala On 2009-05-08 14:31:25
 * History: 
 ***********************************************************/
� getCameraSettings(byref dimi brightness, byref dimi contrast, _
 byref dimi saturation, byref dimi sharpness, _
 byref dimi blc,byref dimi dynrange,byref dimi whiteBal, _
 byref dimi mode, byref dimi expCtrl, _
 byref dimi maxExpTime, byref dimi maxGain, _
 byref dimi spatialfilter, byref dimi temporalfilter, _
 byref dimi videostable, byref dimi lensDistCorr, _
 byref dimi imageSensor, byref dimi TwoAType, _
 byref dimi backlight, byref dimi histogram, byref dimi TwoAMode,byref dimi priority) 
 
 
 
 dims varName$(21) = ("brightness","contrast","saturation","sharpness", _
 "blc","dynrange","whiteBal","mode","expCtrl", _
 "maxExpTime","maxGain", _
 "spatialfilter","temporalfilter", _
 "videostable","lensDistCorr","imageSensor","TwoAType","backlight","histogram", "TwoAMode","priority") 

 
 dims propName$(21) = ("gbrightness","gcontrast","gsaturation","gsharpness", _
 "gblc","gdynrange","gawb","gcolorkiller","gexposurectrl", _
 "gmaxexposuretime","gmaxgain", _
 "gnfltctrl","gtnfltctrl", _
 "gvidstb1","glensdistortcorrection","gbinning","gimg2a","gbacklight","ghistogram", "gimg2atype","gpriority")
 
 dims tempVal$(21)
 dimi i,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �
 
 � i= 0 � ��(tempVal$) 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �
 
 �D
 
 � retVal  
 
�F



/***********************************************************

 * Description: 
 * Sets the Mode Setting values in the camera.
 * Returns 0 � Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Mode Setting 
 * Params:





















 * Created by: vimala On 2009-05-08 14:57:28
 * History: 
 ***********************************************************/
� setCameraSettings(dimi brightness, dimi contrast, _
 dimi saturation, dimi sharpness, _
 dimi blc, dimi dynrange, dimi whiteBal, _
 dimi mode, dimi expCtrl, _
 dimi maxExpTime, dimi maxGain, _
 dimi spatialfilter,dimi temporalfilter, _
 dimi videostable, dimi lensDistCorr, _
 dimi imageSensor, dimi TwoAType,dimi backlight,_
 dimi histogram,dimi twoAMode,dimi priority) 
 dimi ret  
 dims value$
 dims responseData$
 
 value$ = "brightness="+brightness+"&contrast="+contrast+"&saturation="+saturation+"&sharpness="+sharpness+_
 "&blc="+blc+"&dynrange="+dynrange+"&awb="+whiteBal+"&colorkiller="+mode+"&exposurectrl="+expCtrl+_
 "&maxexposuretime="+maxExpTime+"&maxgain="+maxGain+_
 "&nfltctrl="+spatialfilter+"&tnfltctrl="+temporalfilter+"&vidstb1="+videostable+_
 "&lensdistortcorrection="+lensDistCorr+"&binning="+imageSensor+"&img2a="+TwoAType+"&backlight="+backlight+_
 "&histogram="+histogram+"&img2atype="+twoAMode+"&priority="+priority
 
 
 ret = setProperties(value$, responseData$)

 �B ret > 0 �  
 
 dims propName$(21) = ("gbrightness","gcontrast","gsaturation","gsharpness", _
 "gblc","gdynrange","gawb","gcolorkiller","gexposurectrl", _
 "gmaxexposuretime","gmaxgain", _
 "gnfltctrl","gtnfltctrl", _
 "gvidstb1","glensdistortcorrection","gbinning",_
 "gimg2a","gbacklight","ghistogram","gimg2atype","gpriority") 
 
 dims propVal$(21)
 dims retVal$  
 
 propVal$(0) = brightness
 propVal$(1) = contrast
 propVal$(2) = saturation
 propVal$(3) = sharpness
 propVal$(4) = blc
 propVal$(5) = dynrange
 propVal$(6) = whiteBal
 propVal$(7) = mode
 propVal$(8) = expCtrl
 propVal$(9) = maxExpTime
 propVal$(10) = maxGain
 propVal$(11) = spatialfilter
 propVal$(12) = temporalfilter
 propVal$(13) = videostable
 propVal$(14) = lensDistCorr
 propVal$(15) = imageSensor
 propVal$(16) = TwoAType 
 propVal$(17) = backlight 
 propVal$(18) = histogram 
 propVal$(19) = twoAMode 
 propVal$(20) = priority 
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  

�F


/***********************************************************

 * Description: Check all the properties sendto camera are saved or not by parsing response data.
 * 
 * 
 * Params:

 * dims propName$(): String array - All the set Keywords
 * dims propValue$(): String array - value � each keyword , -1 � failure keywords 
 * Created by:Vimala  On 2010-05-03 18:45:45
 * History: 
 ***********************************************************/
� chkRetStatusAndUpdate$(dims responseStaus$,dims propName$(),dims propValue$()) 
 
 dimi retVal,splCount,idx,propidx,retLength,propLength, maxProp
 dims retStatus$,failedKeywords$,retVal$
 dims keyword$
 dimi findPos,nextPos
 dims actualStr$
 dimi sptNo
 dims outputStr$(2)
 dims keywordTemp$,propKey$  
 splCount = �<(retStatus$,responseStaus$,"\n") 
 maxProp = ��(propName$)
 
 � idx = 0 � splCount-1
 
 retLength  = � (retStatus$(idx))
 retVal$  = �#(��(retStatus$(idx),retLength-3)) 
 
 �B retVal$ <> "" �
 � propidx = 0 � maxProp 
 
 propLength = � (propName$(propidx)) 
 propKey$ = �#(��(propName$(propidx),propLength-1)) 
 
 �B retVal$ = propKey$ �  
 
 �B ��(retStatus$(idx),2) <> "OK" �  
 propValue$(propidx) = "-1"
 �B ~keywordDetFlag = 1 �
 keyword$ = propKey$
 findPos = �&(cameraKeywords$,keyword$)
 
 �B findPos >= 0 �
 nextPos = �&(cameraKeywords$,",",findPos)
 actualStr$ = �%(cameraKeywords$,findPos,(nextPos-findPos))
 sptNo = �<(outputStr$,actualStr$,"|")
 
 �B sptNo = 2 �
 keywordTemp$ = outputStr$(1)
 �C 
 keywordTemp$ = outputStr$(0)
 �D
 
 �D  
 failedKeywords$ = failedKeywords$ + keywordTemp$ +","
 � (propidx%5) = 0 � failedKeywords$ += "\n"  
 �C 
 failedKeywords$ = failedKeywords$ + ��(propName$(propidx),propLength-1)+","
 �D  
 �D
 �E
 
 �D
 
 �
 
 �D
 
 �
 
 � updateLatestValues(propName$,propValue$)
 failedKeywords$ = ��(failedKeywords$,(� (failedKeywords$)-1)) 
 chkRetStatusAndUpdate$ = failedKeywords$

�F


/***********************************************************

 * Description: 
 * Gets video analytic screen value from  camera. 
 * Returns 0 � Success; -1 failure  

 * Params:













 * Created by: vimala On 2009-08-25 16:43:30
 ***********************************************************/
� getVideoAnalyticsSettings(byref dimi facedetect, byref dimi regionX, byref dimi regionY, _
 byref dimi regionW, byref dimi regionH, _
 byref dimi confLevel,byref dimi direction, _
 byref dimi faceRecog, byref dimi frLevel, byref dimi database, _
 byref dimi privacyMask, byref dimi maskOptions)
 
 dims varName$(12) = ("facedetect","regionX","regionY",_
 "regionW","regionH", _
 "confLevel","direction",_
 "faceRecog","frLevel","database", _
 "privacyMask","maskOptions")
 dims propName$(12) = ("gfdetect","gfdx","gfdy",_
 "gfdw","gfdh", _
 "gfdconflevel","gfddirection",_
 "gfrecognition","gfrconflevel","gfrdatabase", _
 "gprivacymask","gmaskoptions")
 
 dims tempVal$(12)
 dimi idx,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B  retVal = 0 �
 
 � idx = 0 � ��(tempVal$) 
 
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 
 �  
 
 �D
 
 � retVal  
 
�F

/***********************************************************

 * Description: � this � � set user input values of video analytic screen � camera
 
 * Returns 0 � Success; -1 failure  
 
 * Params:












 
 * Created by: vimala On 2009-08-25 11:54:14
 ***********************************************************/
� setVideoAnalyticsSettings(dimi facedetect, dimi regionX, dimi regionY, _
 dimi regionW, dimi regionH, _
 dimi confLevel, dimi direction, _
 dimi faceRecog, dimi frLevel, dimi database, _
 dimi privacyMask, dimi maskOptions)
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "fdetect="+facedetect+"&fdx="+regionX+"&fdy="+regionY+_
 "&fdw="+regionW+"&fdh="+regionH+_
 "&fdconflevel="+confLevel+"&fddirection="+direction+_
 "&frecognition="+faceRecog+"&frconflevel="+frLevel+"&frdatabase="+database+_
 "&privacymask="+privacyMask+"&maskoptions="+maskOptions
 
 ret = setProperties(value$, responseData$) 
 
 �B ret > 0 �
 
 dims propName$(12) = ("gfdetect","gfdx","gfdy",_
 "gfdw","gfdh", _
 "gfdconflevel","gfddirection",_
 "gfrecognition","gfrconflevel","gfrdatabase", _
 "gprivacymask","gmaskoptions")
 dims propVal$(12)
 
 propVal$(0) = facedetect
 propVal$(1) = regionX
 propVal$(2) = regionY
 propVal$(3) = regionW
 propVal$(4) = regionH
 propVal$(5) = confLevel
 propVal$(6) = direction
 propVal$(7) = faceRecog
 propVal$(8) = frLevel
 propVal$(9) = database
 propVal$(10) = privacyMask
 propVal$(11) = maskOptions
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
 
�F


/***********************************************************

 * Description: 
 * Get video analytic drop down option values from camera *
 * Returns 0 � Success; -1 failure  
 
 * Params: 
 * byref dims direction$(): String array - Hold the available options of direction
 * byref dims maskOptionsName$(): String array - Hold the available options of mask Options 
 * byref dims frecognitionName$(): String array - Hold the available options of face recognition 
 * Created by: vimala On 2009-08-25 11:54:14
 * History: 
 ***********************************************************/
� getVideoAnalyticsOptions(byref dims direction$(), byref dims maskOptionsName$(), byref dims frecognitionName$(),byref dims fdetectname$())
 
 dims varName$(4) = ("direction$","maskOptionsName$","frecognitionName$","fdetectname$")
 dims propName$(4) = ("gfddirectionname","gmaskoptionsname","gfrecognitionname","gfdetectname") 
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx = 0 � ��(tempVal$)
 
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount > 0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �
 
 �D
 
 � retVal
 
�F


/***********************************************************

 * Description: 
 * Provides the Network values � Network settings
 * Returns 0 � Success; -1 failure  

 * Params:




 * byref dimi httpPort: Numeric - Http port
 * Created by: Franklin Jacques On 2009-02-27 12:24:47
 ***********************************************************/
� getNetworkDetails(byref dims ip$, byref dims netmask$, byref dims defaultGWay$, _
 byref dims priNameServer$, byref dimi httpPort, byref dimi dhcpenable)
 dimi ret  
 dims varName$(6) = ("ip$", "netmask$", "defaultGWay$", "priNameServer$", "httpPort", "dhcpenable")
 dims propName$(6) = ("gnetip", "gnetmask", "ggateway", "gdnsip", "ghttpport", "gdhcpenable")
 
 dims tempVal$(6)
 dimi i
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � 5
 �B i=4 or i=5 �
 {varName$(i)} = strtoint(tempVal$(i)) 
 �C
 {varName$(i)} = tempVal$(i) 
 �D
 �  
 �D
 � ret
�F


/***********************************************************

 * Description: Sets the Network details � Network setting
 * Returns 0 � Success; -1 failure  
 
 * Params:






 * Created by: Franklin Jacques On 2009-02-27 12:27:58
 ***********************************************************/
� setNetworkPortDetails(dims ip$,dims netmask$,dims defaultGWay$,dims priNameServer$,dimi httpport,dimi httpsport,dimi portinput, dimi portoutput,dimi rs485,dimi dhcpenable)
 dims NWdetails$, NWPortDetails$
 dims responsedata$
 dimi ret
 
 �B dhcpenable=1 �
 NWdetails$ = ""  
 �C
 NWdetails$ = "netip="+ip$+"&netmask="+netmask$+"&gateway="+defaultGWay$+"&dnsip="+priNameServer$+"&"  
 
 �D
 NWPortDetails$ = NWdetails$+"httpport="+httpport+"&httpsport="+httpsport+"&portinput="+portinput+_
 "&portoutput="+portoutput+"&rs485="+rs485
 � NWPortDetails$
 ret = setProperties(NWPortDetails$, responseData$) 
 
 �B ret >= 0 �
 
 dims propName$(9) = ("gnetip", "gnetmask", "ggateway", "gdnsip", "ghttpport","ghttpsport", "gportinput", "gportoutput", "grs485")
 
 dims propVal$(9)
 propVal$(0) = ip$
 propVal$(1) = netmask$
 propVal$(2) = defaultGWay$
 propVal$(3) = priNameServer$
 propVal$(4) = httpport
 propVal$(5) = httpsport
 propVal$(6) = portinput
 propVal$(7) = portoutput
 propVal$(8) = rs485
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F




/***********************************************************

 * Description: 
 * Get the FTP details � Network setting 
 * Returns 0 � Success; -1 failure  
 
 * Params:




 * byref dimi ftpport: Numeric - Holds ftp port value
: Numeric - 
 * Created by: Franklin Jacques On 2009-02-27 12:32:03
 * History: 
 ***********************************************************/
� getFTPDetails(byref dims ftpServer$, byref dims username$, _
 byref dims pwd$, byref dims fileUpldpath$, byref dimi ftpport)
 dimi ret  
 dims varName$(5) = ("ftpServer$", "username$", "pwd$", "fileUpldpath$", "ftpport")
 dims propName$(5) = ("gftpip", "gftpuser", "gftppassword","gftppath", "gftpipport")
 dims tempVal$(5)
 dimi i
 ret=getiniValues(propName$,tempVal$) 
 �B ret>=0 �
 � i= 0 � 4
 �B i=4 �
 {varName$(i)} = strtoint(tempVal$(i)) 
 �C 
 {varName$(i)} = tempVal$(i) 
 �D
 �  
 �D
 � ret  
�F


/***********************************************************

 * Description: 
 * Sets the FTP details � Network setting
 * Returns 0 � Success; -1 failure  
 
 * Params:



 * dims fileUpldpath: Numeric - File Upload Path
 * Created by: Franklin Jacques On 2009-02-27 12:39:27
 ***********************************************************/
� setFTPDetails(dims ftpServer$, dims username$, dims pwd$, dims fileUpldpath$, dimi ftpport)
 
 Dims FTPdetails$
 dims responsedata$
 dimi ret
 FTPdetails$="ftpip="+ftpServer$+"&ftpuser="+username$+"&ftppassword="+pwd$+"&ftppath="+fileUpldpath$+"&ftpipport="+ftpport+""

 ret = setProperties(FTPdetails$, responseData$) 
 
 �B ret >= 0 �
 
 dims propName$(5) = ("gftpip", "gftpuser", "gftppassword","gftppath", "gftpipport")
 
 dims propVal$(5)
 propVal$(0) = ftpServer$
 propVal$(1) = username$
 propVal$(2) = pwd$
 propVal$(3) = fileUpldpath$
 propVal$(4) = ftpport
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret
�F


/***********************************************************

 * Description: Get the SMTP details � Network setting 
 * Returns 0 � Success; -1 failure  
 
 * Params:





 * byref dimi requiresAuth$: String - My server requires authentication
 * byref dimi smtpPort: Numeric - SMTP Port
 * Created by: Franklin Jacques On 2009-02-27 14:55:22
 * Modified by: Karthi on 28-Sep-10 
 ***********************************************************/
� getSMTPDetails(byref dims accName$, byref dims pwd$, byref dims sender$, _
 byref dims smtpServer$,byref dimi smtpPort,byref dims emailid$, byref dimi requiresAuth)
 
 dimi ret
 dims varName$(7) = ("accName$", "pwd$", "sender$","smtpServer$","smtpPort","emailid$","requiresAuth")
 dims propName$(7) = ("gsmtpuser","gsmtppwd","gsmtpsender","gsmtpip","gsmtpport","gemailuser","gsmtpauth")
 dims tempVal$(7)
 dimi i
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �  
 � i= 0 � 6
 
 �B i=6 or i = 4 �
 {varName$(i)} = strtoint(tempVal$(i)) 
 �C 
 {varName$(i)} = tempVal$(i) 
 �D
 � "{varName$(i)} = tempVal$(i)";varName$(i);tempVal$(i) 
 �
 �D
 � ret 
�F


/***********************************************************

 * Description: Get the SNTP details � Network setting
 * Returns 0 � Success; -1 failure  

 * Params:


 * Created by: Franklin Jacques On 2009-02-27 15:27:40
 ***********************************************************/
� getSNTPRTSPDetails(byref dims sntpServer$,byref dimi multiCast)
 
 dims varName$(2) = ("sntpServer$","multiCast")
 dims propName$(2) = ("gsntpip","gmulticast")
 dims tempVal$(2)
 dimi i,ret
 ret=getiniValues(propName$,tempVal$)
 
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i=1 �
 {varName$(i)} = strtoint(tempVal$(i)) 
 �C 
 {varName$(i)} = tempVal$(i) 
 �D
 
 �
 �D
 � ret 
 
�F


/***********************************************************

 * Description: � this � � set sntp Server and multi Cast values � IPNC
 
 * Params:

 * dimi multiCast: Numeric - Holds MultiCast Value 
 * Created by: Vimala On 2009-11-06 10:49:28
 ***********************************************************/
� setSNTPRTSPDetails(dims sntpServer$,dimi multiCast)
 dimi ret
 dims SNTPRTSPDetails$
 dims responseData$
 
 SNTPRTSPDetails$="sntpip="+sntpServer$+"&multicast="+multiCast  
 
 ret = setProperties(SNTPRTSPDetails$, responseData$)
 
 �B ret >= 0 �
 
 dims propName$(2) = ("gsntpip","gmulticast")

 dims propVal$(2)
 propVal$(0) = sntpServer$
 propVal$(1) = multiCast  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F

/***********************************************************

 * Description: � get the port details (https/http)
 
 * Params:





 * rs485name$: String - get the label � rs485-on/off
 * Created by: Franklin Jacques  On 2009-05-08 14:36:53
 * History: 
 ***********************************************************/
� getPORTDetails(byref dimi httpsport,byref dimi portinput,byref dimi portoutput,_
 byref dimi rs485,byref dims portinputname$,byref dims portoutputname$,byref dims rs485name$)
 
 dims varName$(7) = ("httpsport", "portinput", "portoutput", "rs485", "portinputname$","portoutputname$", "rs485name$")
 dims propName$(7) = ("ghttpsport", "gportinput", "gportoutput", "grs485", "gportinputname", "gportoutputname", "grs485name")
 dims tempVal$(7)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i=4 or i=5 or i=6 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret 
 
�F


/***********************************************************

 * Description: 
 * Get the motion detection setting values from IPNC
 * Returns 0 � Success; -1 failure  

 * Params:



 * byref dimi thresholdValue: Numeric - threshold value � customize 
 * byref dimi minThreshold:Numeric - min customize threshold value
 * byref dimi maxThreshold:Numeric - max customize threshold value

 * Created by: Franklin On 2009-03-02 12:13:49
 ***********************************************************/
� getMotionDetectSettings(byref dimi isCustomvalue, byref dimi sensitivity, byref dimi thresholdValue, _
 byref dimi minThreshold, byref dimi maxThreshold, byref dims motionBlock$)
 
 dims tempVal$
 
 dims varName$(6) = ("isCustomvalue", "sensitivity", "thresholdValue", "minThreshold", "maxThreshold", "motionBlock$")
 dims propName$(6) = ("gmotioncenable", "gmotionsensitivity", "gmotioncvalue", "gminmotionthreshold", "gmaxmotionthreshold", "gmotionblock")
 dims values$(6)
 dimi i, ret
 
 
 ret = getIniValues(propName$, values$)
 
 �B ret = 0 �
 
 � i= 0 � ��(values$)
 �B i = 5 �
 {varName$(i)} = values$(i) 
 �C
 {varName$(i)} = strtoint(values$(i)) 
 �D  
 
 �
 
 �D
 
 � ret
 
�F

/***********************************************************

 * Description: 
 * Set motion detection setting values 
 * Returns 0 � Success; -1 failure  

 * Params:




 * dimi thresholdValue : customized threshold value
 * Created by: Franklin On 2009-03-02 12:17:29
 ***********************************************************/
� setMotionDetectSettings(dimi isCustomvalue, dimi sensitivity, dimi thresholdValue, dims motionBlock$)
 
 dimi ret, i
 dims value$
 dims responseData$
 
 dims propName$(4) = ("motioncenable", "motioncvalue", "motionsensitivity", "motionblock")
 dims propValue$(4)= ("isCustomvalue", "thresholdValue", "sensitivity", "motionBlock$")
 
 value$ = propName$(0) + "=" + {propValue$(0)}
 
 
 � i=1 � 3
 value$ += "&" + propName$(i) + "=" + {propValue$(i)}
 �
 
 
 ret = setProperties(value$, responseData$)

 �B ret >= 0 �
 
 � i=0 � 3
 propName$(i) = "g"+propName$(i)
 propValue$(i) = {propValue$(i)}
 �
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propValue$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret
 
�F

/***********************************************************

 * Description: 
 * Get the Alarm setting module dropdown values 
 * Returns 0 � Success; -1 failure  
 
 * Params:
 * byref dims arrSensitivity$: String - Returns the array containing the predefined sensitivity options.
 * Created by: Partha Sarathi.K On 2009-03-02 12:30:15
 * History: 
 ***********************************************************/
� getMotionDetectOptions(byref dims arrSensitivity$())
 
 dims tempVal$
 
 dims propName$(1) = ("gmotionname")
 dims values$(1)
 dimi ret, i, retVal
 
 retVal = getIniValues(propName$, values$) 
 
 �B retVal = 0 �
 ret = �<(tempVal$, values$(0), ";") 
 
 �B ret >= 1 �
 redim arrSensitivity$(ret) 
 arrSensitivity$ = tempVal$  
 �D
 �D
 
 � retVal
 
�F


/***********************************************************

 * Description: 
 * Load the properties from ini file.
 * Parse the properties & value.

 * Created by: Partha Sarathi.K On 2009-02-23 11:42:22
 * Modified by: vimala 28-05-2008
 ***********************************************************/
� loadIniValues()
 
 dimi index
 dims value$, line$
 dimi ret, retVal
 dimi length
 dims tempProp$,temp$
 
 � keywords$(5000) 
 
 
 
 
 keywords$ = ",title,audioenable,rotctrl,clicksnapfilename,democfgname,clicksnapstorage"_
 ",democfg,ftpip,ftpuser,ftppassword,ftppath,ftpipport,smtpuser,smtppwd,smtpsender"_
 ",smtpip,smtpport,emailuser,smtpauth,sntpip,sntptimezone,daylight,httpsport,portinput"_
 ",portoutput,rs485,portinputname,portoutputname,rs485name,netip,netmask,gateway,dnsip,httpport"_
 ",dhcpenable,rftpenable,ftpfileformat,sdrenable,sdfileformat"_
 ",sdfileformatname,recordlocalstorage,schedulerepeatenable,schedulenumweeks,scheduleinfiniteenable"_
 ",fdetect,fdx,fdy,fdw,fdh,fdconflevel,fddirection,frecognition,fdetectname,frconflevel,frdatabase"_
 ",privacymask,maskoptions,fddirectionname,maskoptionsname,motioncenable,motionsensitivity"_
 ",motioncvalue,minmotionthreshold,maxmotionthreshold,motionname,brightness,contrast"_
 ",saturation,sharpness,blc,lbce,dynrange,dynrangename,awb,colorkiller,exposurectrl,priority,maxexposuretime"_
 ",maxgain,nfltctrl,tnfltctrl,vidstb1,lensdistortcorrection,binning,img2a,awbname,backlight,backlightname"
 
 keywords$ +=",exposurename,priorityname,maxexposuretimename,maxgainname,nfltctrlname,binningname"_
 ",img2aname,audioenable,audiomode,gainvalue,encoding,samplerate,audiobitrate"_
 ",alarmlevel,audioinvolume,audiomodename,encodingname,sampleratename,audiobitratename"_
 ",date,time,sntpip,timezone,daylight,timeformat,tstampformat,dateposition"_
 ",timeposition,dateformatname,tstampformatname,datetimepositionname,datetimepositionname"_
 ",alarmenable,alarmduration,alarmperiodicity,motionenable,lostalarm,darkblankalarm"_
 ",extalarm,exttriggerinput,exttriggeroutput,aftpenable,ftpfileformat,asmtpenable,smtpminattach"_
 ",smtpmaxattach,asmtpattach,sdaenable,sdfileformat,alarmlocalstorage,alarmaudioplay"_
 ",alarmaudiofile,exttriggername,ftpfileformatname,attfileformatname,sdfileformatname"_
 ",recordduration,alarmperiodicityname,alarmaudiofilename,devicename,videocodec,videomode"
 
 keywords$ +=",videocodecname,videocodecmode,videocodecmodename,videocodecres,videocodecresname"_
 ",framerate1,frameratenameall1,framerate2,frameratenameall2,framerate3,frameratenameall3"_
 ",bitrate1,ratecontrol1,ratecontrolname,datestampenable1"_
 ",timestampenable1,logoenable1,logoposition1,logopositionname,textenable1,textposition1"_
 ",textpositionname,encryptvideo,localdisplay,rotctrl,rotctrlname,mirctrl,mirctrlname"_
 ",overlaytext1,bitrate2,ratecontrol2,datestampenable2"_
 ",timestampenable2,logoenable2,logoposition2,textenable2,textposition2,overlaytext2"_
 ",jpegframerate,livequality,datestampenable3,,timestampenable3"_
 ",logoenable3,logoposition3,textenable3,textposition3,overlaytext3,devicename"_
 ",ipratio1,qpmin1,qpmax1,meconfigname,packetsize1,forceiframe1,umv1,intrapframe1"
 
 keywords$ +=",regionofinterestenable1,meconfig1,str1x1,str1y1,str1w1,str1h1,str1x2,str1y2"_
 ",str1w2,str1h2,str1x3,str1y3,str1w3,str1h3,ipratio2,qpmin2,qpmax2,packetsize2"_
 ",forceiframe2,umv2,intrapframe2,regionofinterestenable2,meconfig2,str2x1,str2y1"_
 ",str2w1,str2h1,str2x2,str2y2,str2w2,str2h2,str2x3,str2y3,str2w3,str2h3"_
 ",ipratio3,qpmin3,qpmax3,packetsize3,forceiframe3,umv3,intrapframe3,regionofinterestenable3"_
 ",meconfig3,str3x1,str3y1,str3w1,str3h1,str3x2,str3y2,str3w2,str3h2,str3x3,str3y3"_
 ",str3w3,str3h3,authorityadmin,authorityoperator,authorityviewer,minnamelen,motionblock"_
 ",kernelversion,biosversion,softwareversion,activexversion,guiversion,detailinfo1,detailinfo2"_
 ",detailinfo3,histogram,img2atype,img2atypename,multicast,frecognitionname,audiooutvolume"_
 
 keywords$ +=",aviformat,aviformatname,aviduration,avidurationname,reloadtime,qpinit1,qpinit2,qpinit3"_
 ",videocodeccombo,videocodeccomboname,streamname1,streamname2,streamname3"_
 ",localdisplayname,sdinsert,reloadflag,dmvaenable,minnamelen,maxnamelen,minpwdlen,maxpwdlen,maxaccount"_
 ",bkupfirmware"  
 
 retVal = dwnldIniFile() 
 
 �B retVal > 0 �
 
 length = � (~responseData$)
 line$  = ""
 
 ~maxPropIndex = 0
 
 � index = 0 � length-1
 � ~responseData$(index) = "\r" � continue
 �B ~responseData$(index) = "\n" �  
 
 ret = �<(value$, line$, "=") 
 line$ = ""
 
 � ret <= 1 � continue  
 tempProp$ = �8(value$(0)) 
 
 �B �&(keywords$,tempProp$) >= 0  �  
 ~iniProperties$(~maxPropIndex) = "g"+tempProp$  
 temp$ = value$(1) 
 � ret = 3 � temp$ += "="+value$(2) 
 ~iniPropValues$(~maxPropIndex) = temp$ 
 
 ~maxPropIndex++
 �D  
 
 continue
 
 �D
 line$ += ~responseData$(index) 
 
 �  
 
 �D  
 
 � retVal
 
�F


/***********************************************************

 * Description: 
 * Get the parsed ini value � given keyword.
 * 
 * Params:
 * dims propName$: String array - Holds the keywords � which value � fetched from server
 * byref dims propValue$ : String array - Holds corresponding value � the keyword 
 * Created by: Partha Sarathi.K On 2009-02-27 11:58:25
 ***********************************************************/
� getiniValues(dims propName$(), byref dims propValue$())
 
 dimi i, j
 dims tempVal$
 dimi ret
 dimi maxProperty
 
 maxProperty = ��(propName$)
 
 � i=0 � maxProperty
 
 propValue$(i) = "-1"  
 
 �B �#(propName$(i)) <> "" �  
 
 � j = 0 � ~maxPropIndex-1
 
 �B ~iniProperties$(j) = propName$(i) �  
 propValue$(i) = ~iniPropValues$(j) 
 �E
 �D
 
 �
 
 �D
 
 �
 
 � 0
 
�F


/***********************************************************

 * Description: 
 * Download the ini.htm file contents with user name password in header information.

 * Created by: Partha Sarathi.K  On 2009-02-27 15:17:26
 ***********************************************************/
� dwnldIniFile() 
 dimi ret
 dims tempAuth$
 
 
 tempAuth$ = generateauthHeader$(~authUserName$, ~authPassword$)
 ~authHeader$ = "Authorization: Basic " + tempAuth$ + "\r\n"
 � "header = " + ~authHeader$ 
 
 
 ret = �5(~camAddPath$ + "ini.htm", "","a.txt",2,SUPRESSUI,~authHeader$,,,~responseData$)
 ~responseData$ = ��(~responseData$, "<br>", "\n")
 dwnldIniFile = ret
 
 
�F



/***********************************************************

 * Description: Download the file(.txt) from camera.
 * 
 * Created by: Franklin Jacques.k  On 2009-10-08 10:25:11
 ***********************************************************/
� dwnldFile$(dims fileName$)
 
 dimi ret
 dims tempAuth$
 � textInfo$(30000)
 dims filePath$
 
 
 tempAuth$ = generateauthHeader$(~authUserName$, ~authPassword$)
 ~authHeader$ = "Authorization: Basic " + tempAuth$ + "\r\n"
 
 
 filePath$ = ~camAddPath$ + fileName$
 ret = �5(filePath$, "",fileName$,2,SUPRESSUI,~authHeader$,,,textInfo$)
 SETOSVAR("*FLUSHEVENTS", "") 
 textInfo$ = ��(textInfo$, "<br>", "\n")
 textInfo$ = ��(textInfo$, "\t", "    ")
 textInfo$ = ��(textInfo$, �Q(147), "\"")
 textInfo$ = ��(textInfo$, �Q(148), "\"")
 textInfo$ = ��(textInfo$, �Q(146), "'")
 � textInfo$
 �B ret > 0 �
 dwnldFile$ = textInfo$
 �C 
 dwnldFile$ = "NA"
 �D
 
�F


/***********************************************************

 * Description: � this � � � property value in 
 ~iniPropValues$ array �B property value is not -1

 * Params:
 * dims propertyName$(): String array - Hold camera keywords
 * dims propertyValues$(): String array - Holds updated values � each keyword
 * Created by: Vimala On 2009-03-19 15:45:31
 ***********************************************************/
�h updateLatestValues(dims propertyName$(),dims propertyValues$())
 
 dimi i, j  
 dimi maxVal
 
 maxVal = ��(propertyName$) 
 
 � maxVal <> ��(propertyValues$) � �
 
 � i=0 � maxVal  
 
 � j = 0 � ~maxPropIndex-1  
 
 �B ~iniProperties$(j) = propertyName$(i) �  
 
 � propertyValues$(i) <> "-1" � ~iniPropValues$(j) = propertyValues$(i) 
 �E
 �D  
 
 �  
 
 �
 
�F

/***********************************************************

 * Description: 
 * Get all available users from camera
 * Returns 0 � Success; -1 failure  

 * Params:







 * Created by: On 2009-03-06 16:03:46
 * History: 
 ***********************************************************/
� getUserSetting(byref dimi authorityAdmin, byref dimi authorityOperator, _
 byref dimi authorityViewer,byref dimi minNameLen,byref dimi maxNameLen,byref dimi minPwdLen,_
 byref dimi maxPwdLen,byref dimi maxaccount, byref dims user$(), byref dims authority$())
 dims tempVal$
 
 dims varName$(8) = ("authorityAdmin", "authorityOperator", "authorityViewer",_
 "minNameLen","maxNameLen","minPwdLen","maxPwdLen","maxaccount")
 dims propName$(8) = ("gauthorityadmin", "gauthorityoperator", "gauthorityviewer",_
 "gminnamelen","gmaxnamelen","gminpwdlen","gmaxpwdlen","gmaxaccount")
 dims values$(8)
 dimi retVal
 
 retVal = getIniValues(propName$, values$)
 
 �B retVal = 0 �  
 dimi idx  
 
 � idx= 0 � ��(values$) 
 {varName$(idx)} = strtoint(values$(idx))
 �  
 
 retVal = getPropValue("user", user$)
 retVal = getPropValue("authority", authority$) 
 
 �D
 
 � retVal
 
�F

/***********************************************************

 * Description: 
 * Add user � the camera 
 * Returns 0 � Success; -1 failure  

 * Params:


 * dimi authority: Numeric - Authority of the user Admin=0, Operator=1, Viewer=2
 * Created by: On 2009-03-06 16:19:09
 * History: 
 ***********************************************************/
� addUser(dims username$, dims pwd$, dimi authority)
 dimi ret
 dims value$
 dims responseData$,retStatus$
 
 value$ = "adduser="+username$+":"+pwd$+":"+authority  
 
 ret = setProperties(value$, responseData$)
 
 �B ret > 0 �
 
 �B �#(��(responseData$,3)) = "OK" �
 � 0
 �C 
 � -10
 �D
 
 �D  
 
 � ret  
 
�F

/***********************************************************

 * Description: 
 * Delete an user in the camera 
 * Returns 0 � Success; -10/-11 failure  

 * Params:
 * dims username$: String - user name
 * Created by: On 2009-03-06 18:50:20
 * History: 
 ***********************************************************/
� deleteUser(dims username$)
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "deluser="+username$  

 ret = setProperties(value$, responseData$)

 �B ret > 0 �
 
 �B �#(��(responseData$,3)) = "OK" �
 � 0
 �y �#(��(responseData$,3)) = "NG" � 
 � -11
 �C
 � -10
 �D
 
 �D  
 
 � ret  
 
�F

/***********************************************************

 * Description: 
 * Used � get the values of variables User, Authority, Schedule
 * 
 * Params:
 * dims prop$: String - Camera Keyword
 * byref dims propVal$(): String array - Returns the Camera Keyword value in an array
 * Created by: On 2009-03-06 17:38:33
 * History: 
 ***********************************************************/
� getPropValue(dims prop$, byref dims propVal$())
 dimi pos1, pos2  ,ret
 dims userdetail$
 dims retVal$
 
 ret=�5(~camAddPath$+"vb.htm?paratest="+prop$, "","test1.txt",2,SUPRESSUI,~authHeader$,,,userdetail$)
 SETOSVAR("*FLUSHEVENTS", "") 
 �B ret > 0 �
 retVal$ = �#(��(userdetail$,3))
 
 �B retVal$ = "OK" �
 
 userdetail$ = ��(userdetail$,"OK ","\n")
 
 pos1 = �&(userdetail$, "\n" + prop$ + "=")
 
 �B pos1 > -1 �
 pos1 = � (prop$)+2+pos1
 pos2 = �&(userdetail$, "\n\n", pos1+1)
 �B pos2 > pos1+1 �
 dims tempStr$,arrStr$
 dimi retVal
 tempStr$ = �%(userdetail$, pos1, pos2-pos1)
 retVal = �<(arrStr$, tempStr$, "\n") 
 propVal$ = arrStr$
 � ret
 �C
 � -10
 �D
 �C
 � -10
 �D
 �y retVal$ = "UA" � 
 � -20  
 �C
 � -10
 �D  
 
 �C
 � ret
 �D
 
�F



/***********************************************************

 * Description: 
 * Sets the SMTP details � Network setting
 * Returns 0 � Success; -1 failure  

 * Params:





 * dimi requiresAuth: Numeric - My server requires authentication
 * dimi smtpPort: Numeric - SMTP Port
 * Created by: On 2009-02-27 15:08:21
 * Modified by: karthi on 28-Sep-10
 * History: 
 ***********************************************************/
� setSMTPDetails(dims accName$, dims pwd$, dims sender$, _
 dims smtpServer$,dimi smtpPort,dims emailid$, dimi requiresAuth)
 Dims SMTPDetails$
 dims responseData$
 dimi ret
 
 SMTPDetails$="smtpuser="+accName$+"&smtppwd="+pwd$+"&smtpsender="+sender$+"&smtpip="+smtpServer$+"&smtpport="+smtpPort+"&emailuser="+emailid$+"&smtpauth="+requiresAuth
 
 ret = setProperties(SMTPDetails$, responseData$)
 
 �B ret > 0 �
 
 dims propName$(7) = ("gsmtpuser", "gsmtppwd", "gsmtpsender","gsmtpip","gsmtpport","gemailuser","gsmtpauth")
 dims propVal$(7)
 propVal$(0) = accName$
 propVal$(1) = pwd$
 propVal$(2) = sender$
 propVal$(3) = smtpServer$
 propVal$(4) = smtpPort
 propVal$(5) = emailid$
 propVal$(6) = requiresAuth
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F



/***********************************************************

 * Description: 
 * Sets the SNTP details � Network setting
 * Returns 0 � Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Network Setting  
 * Params:


 * dimi daylight: Numeric - Automatically adjust � Daylight saving � changes
 * Created by:Franklin On 2009-02-27 15:33:09
 * History: 
 ***********************************************************/
� setSNTPDetails(dims sntpServer$, dimi timezone, dimi daylight)
 
 Dims SNTPDetails$
 dims responsedata$
 dimi ret
 
 SNTPDetails$="sntpfqdn="+sntpServer$+"&timezone="+timezone+"&daylight="+daylight+""
 
 ret = setProperties(SNTPDetails$, responseData$)
 
 �B ret > 0 �
 
 dims propName$(3) = ("gsntpip","gtimezone","gdaylight")
 dims propVal$(3)
 propVal$(0) = sntpServer$
 propVal$(1) = timezone
 propVal$(2) = daylight
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F


/***********************************************************

 * Description: 
 * Get the available list of � zones
 * Returns 0 � Success; -1 failure  
 
 * Params:
 * byref dims arrTimezones$(): String array - � � the timezones
 * dims arrTimezones$(): String - file name � be downloaded from camera
 * Created by:Franklin  On 2009-02-27 15:38:52
 ***********************************************************/
� getTimezones(byref dims arrTimezones$(),dims fileName$)
 dimi splitCount,i
 dims tempZoneVal$,timeZones$
 tempZoneVal$ = dwnldFile$(fileName$)
 �B tempZoneVal$ <> "" �
 splitCount = �<(timeZones$,tempZoneVal$,"\n")
 �B splitCount > 0  �
 redim arrTimezones$(splitCount)
 arrTimezones$ = timeZones$
 � 1
 �C 
 � -1
 �D  
 �C 
 � -1
 �D
 
�F

/***********************************************************

 * Description: 
 * Get the storage setting � the camera 
 * Returns 0 � Success; -1 failure  

 * Params:



 * byref dims Timezonename$: String - � zone name
 * byref dimi daylight : Numeric - Check � activate this functionality. 
 * byref dimi dateformat: String - � as in Camera
 * byref dimi timeFormat : Numeric - Possible values are 24h, 12h
 * byref dimi datePosition : Numeric - Possible values are top-��, bottom-��, top-��, bottom-��
 * byref dimi timePosition : Numeric - Possible values are top-��, bottom-��, top-��, bottom-��
 *
 * Created by: vimala On 2009-05-11 12:30:27
 * History: 
 ***********************************************************/
� getDateTime(byref dims dateInCamera$, byref dims timeInCamera$, _
 byref dims sntpServer$, byref dimi sntptimezone,byref dimi daylight, _
 byref dimi dateformat, byref dimi timeFormat, byref dimi datePosition, _
 byref dimi timePosition)
 
 dims varName$(9) = ("dateInCamera$","timeInCamera$","sntpServer$","sntptimezone","daylight",_
 "dateformat","timeFormat","datePosition","timePosition")
 
 dims propName$(9) = ("gdate","gtime","gsntpip","gtimezone","gdaylight",_
 "gdateformat","gtstampformat","gdateposition","gtimeposition")
 
 dims tempVal$(9)
 dimi idx,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �  
 � idx = 0 � ��(tempVal$) 
 
 �B  idx = 0  or idx = 1  or idx = 2 �
 {varName$(idx)} = tempVal$(idx)
 
 �C 
 {varName$(idx)} = strtoint(tempVal$(idx))
 �D  
 
 �  
 
 �D
 
 � retVal
 
�F

/***********************************************************

 * Description: 
 * Get the �/� setting drop dowm values from camera 
 * Returns 0 � Success; -1 failure  

 * Params:




 * 
 * Created by: vimala  On 2009-05-11 12:38:43
 * History: 
 ***********************************************************/
� getDateFormatOptions(byref dims dateformat$(),byref dims timeFormat$(), _
 byref dims datePosition$(),byref dims timePosition$())
 
 
 dims varName$(4) = ("dateformat$","timeFormat$","datePosition$","timePosition$") 
 dims propName$(4) = ("gdateformatname","gtstampformatname","gdatetimepositionname","gdatetimepositionname")
 dims tempVal$(4)
 
 dimi splitidx, retVal, sptCount  ,idx
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$,tempVal$)
 
 �B retVal = 0 �
 
 � idx= 0 � ��(tempVal$)
 
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount>0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �
 
 �D
 
 � retVal
 
�F

/***********************************************************

 * Description: 
 * Set the �,� �$ / new � & �
 * Based on the option selected the values are set � camera
 * �B response � the synchronise is TIMEOUT timefrequency display "SNTP request timed out due to network problem"
 * Returns 0 � Success; -1 failure  

 * Params:







 * Created by: vimala On 2009-05-11 12:52:47
 * History: 
 ***********************************************************/
� setDatetime(dimi setdate, dims newDate$, dims newtime$,_
 dimi dateformat, dimi timeFormat, dimi datePosition,_
 dimi timePosition,dimi timezone, dimi daylight)
 
 dims value$,responseData$
 dimi ret  
 
 �B setdate = 0 �  
 value$ = "dateformat="+dateformat+"&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 �y  setdate  = 1 or  setdate  = 2 �  
 value$ = "newdate="+newDate$+"&newtime="+newtime$+"&dateformat="+dateformat+_
 "&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 �y  setdate  = 3 �  
 value$ = "timefrequency=-1&daylight="+daylight+"&timezone="+timezone+"&dateformat="+dateformat+_
 "&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 
 �D  
 � value$ 
 ret = setProperties(value$, responseData$) 
 
 �B �&(responseData$,"TIMEOUT timefrequency") <> -1 �
 �(0,"")
 �("SNTP request timed out due to network problem") 
 ret = -11
 �(1000,"DisplayDigitalClock")
 �C  
 
 dims propName$(8) = ("gdate","gtime","gdateformat",_
 "gtstampformat","gdateposition","gtimeposition",_
 "gdaylight","gtimezone")
 
 dims propVal$(8)
 
 propVal$(0) = newDate$
 propVal$(1) = newtime$
 propVal$(2) = dateformat  
 propVal$(3) = timeFormat  
 propVal$(4) = datePosition  
 propVal$(5) = timePosition  
 propVal$(6) = daylight  
 propVal$(7) = timezone  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D
 
 � ret
 
�F

/***********************************************************

 * Description: 
 * Get the storage setting values � the camera 
 * Returns 0 � Success; -1 failure  

 * Params:

 byref dimi ftpfileformat: Numeric - Enabled/ Disabled
 byref dims ftpfileformatname$: string - MPEG/JPEG

 byref dimi sdfileformat: Numeric - Enabled/ Disabled
 byref dims sdfileformatname$: string - MPEG/JPEG



 * byref dims recordSchedule$(): String - Existing record schedule
 * Created by:Franklin  On 2009-03-09 12:04:40
 * History: 
 ***********************************************************/
� getStorageSetting(byref dimi uploadbyFTP,byref dimi ftpfileformat,byref dims ftpfileformatname$, byref dimi storeLocally, _
 byref dimi sdfileformat,byref dims sdfileformatname$, byref dimi localStorage, byref dimi repeatSchedule, byref dimi noOfWeeks, _
 byref dims recordSchedule$(),byref dimi scheduleInfinity,byref dimi sdCard)
 
 dimi retVal,ret,i
 
 retVal = getPropValue("schedule", recordSchedule$)
 
 dims varName$(11) = ("uploadbyFTP","ftpfileformat","ftpfileformatname$","storeLocally","sdfileformat","sdfileformatname$","localstorage","repeatSchedule", _
 "noOfWeeks","scheduleInfinity","sdCard")
 dims propName$(11) = ("grftpenable","gftpfileformat","gftpfileformatname","gsdrenable","gsdfileformat","gsdfileformatname","grecordlocalstorage","gschedulerepeatenable", _
 "gschedulenumweeks","gscheduleinfiniteenable","gsdinsert")
 dims tempVal$(11)
 ret=getiniValues(propName$,tempVal$) 
 �B ret>=0 �  
 � i= 0 � ��(tempVal$)
 �B i=2 or i=5 �
 {varName$(i)} = tempVal$(i) 
 �C
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 � ret 
�F


/***********************************************************

 * Description: 
 * Sets the storage setting values � camera 
 * Returns 0 � Success; -1 failure  

 * Params:






 * byref dims recordSchedule$(): String - Existing record schedule
 * Created by:Franklin  On 2009-03-09 14:02:04
 * History: 
 ***********************************************************/
� setStorageSetting(dimi uploadbyFTP,dimi ftpfileformat, dimi storeLocally, _
 dimi sdfileformat, dimi localStorage, dimi repeatSchedule, dimi noOfWeeks, _
 dimi scheduleInfinity, dims recordSchedule$)
 dims storageSetting$
 dims responseData$
 dimi ret
 storageSetting$="rftpenable="+uploadbyFTP+"&ftpfileformat="+ftpfileformat+"&sdrenable="+storeLocally+_
 "&sdfileformat="+sdfileformat+"&recordlocalstorage="+localStorage+"&schedulerepeatenable="+repeatSchedule+"&schedulenumweeks="+noOfWeeks+_
 "&schedule="+recordSchedule$+"&scheduleinfiniteenable="+scheduleInfinity+""
 
 ret = setProperties(storageSetting$, responseData$)
 
 �B ret > 0 �
 
 dims propName$(8) = ("grftpenable","gftpfileformat","gsdrenable","gsdfileformat","grecordlocalstorage","gschedulerepeatenable", _
 "gschedulenumweeks","gscheduleinfiniteenable")

 dims propVal$(8)
 propVal$(0) = uploadbyFTP
 propVal$(1) = ftpfileformat
 propVal$(2) = storeLocally
 propVal$(3) = sdfileformat
 propVal$(4) = localStorage
 propVal$(5) = repeatSchedule
 propVal$(6) = noOfWeeks
 propVal$(7) = scheduleInfinity
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F

/***********************************************************

 * Description: 
 * Get the Alarm setting details
 * Returns 0 � Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:




















 * Created by: vimala On 2009-05-11 17:12:10
 * History: 
 ***********************************************************/
� getAlarmSetting(byref dimi enableAlarm, byref dimi storageDuration, _
 byref dimi motionEnabled, byref dimi ethernetLost, _
 byref dimi darkImages, byref dimi extTriggerEnabled, _
 byref dimi extTriggerInput, byref dimi exttriggeroutput, _
 byref dimi ftpUpload, byref dimi ftpFormat, byref dimi smtpUpload, byref dimi smtpFormat, _
 byref dimi smtpMinFiles,byref dimi smtpMaxFiles,byref dimi noOfFiles, _
 byref dimi localStore, byref dimi localFormat, _
 byref dimi storageLocation, byref dimi playAudio, byref dimi audioFiles,byref dimi sdCard)
 
 dims varName$(21) = ("enableAlarm", "storageDuration", _
 "motionEnabled", "ethernetLost", _
 "darkImages", "extTriggerEnabled", _
 "extTriggerInput", "exttriggeroutput", _
 "ftpUpload", "ftpFormat", "smtpUpload", "smtpFormat", _
 "smtpMinFiles","smtpMaxFiles","noOfFiles", _
 "localStore", "localFormat", _
 "storageLocation", "playAudio", "audioFiles","sdCard")
 
 dims propName$(21) = ("galarmenable", "galarmduration", _
 "gmotionenable", "glostalarm", _
 "gdarkblankalarm", "gextalarm", _
 "gexttriggerinput", "gexttriggeroutput", _
 "gaftpenable", "gftpfileformat", "gasmtpenable", "gattfileformat", _
 "gsmtpminattach", "gsmtpmaxattach", "gasmtpattach", _
 "gsdaenable", "gsdfileformat", _
 "galarmlocalstorage", "galarmaudioplay", "galarmaudiofile","gsdinsert") 
 
 dimi idx,retVal
 dims tempVal$(21)
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �
 
 � idx = 0 � ��(tempVal$) 
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 �
 
 �D
 
 � retVal 
 
�F
 
/***********************************************************

 * Description: 
 * Get the Alarm setting module dropdown values 
 * Returns 0 � Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:







 * byref dimi audioFiles$: String Array - Returns the durations � be saved before alarm.
 * Created by: vimala On 2009-05-11 10:52:31
 * History: 
 ***********************************************************/
� getAlarmSettingOptions(byref dims arrExtInpTriger$(), byref dims arrExtOutTriger$(), _
 byref dims arrFtpFormat$(), byref dims arrSmtpFormat$(), byref dims arrLocalFormat$(), _
 byref dims arrStorageDuration$(), byref dims audioFiles$())
 
 dims varName$(7) = ("arrExtInpTriger$","arrExtOutTriger$", _
 "arrFtpFormat$","arrSmtpFormat$","arrLocalFormat$", _
 "arrStorageDuration$","audioFiles$")
 
 
 dims propName$(7) = ("gexttriggername","gexttriggername",_
 "gftpfileformatname","gattfileformatname","gsdfileformatname",_
 "grecordduration","galarmaudiofilename")
 
 dims tempVal$(7)
 dimi idx, splitidx, retVal,sptCount
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx= 0 � ��(tempVal$)
 
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount>0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �
 
 �D
 
 � retVal
 
�F
 
/***********************************************************

 * Description: 
 * set the Alarm setting details
 * Returns 0 � Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:


















 * Created by: vimala On 2009-05-11 17:12:10
 * History: 
 ***********************************************************/
� setAlarmSetting(dimi enableAlarm, dimi storageDuration, _
 dimi motionEnabled, dimi ethernetLost,_
 dimi darkImage,dimi extTriggerEnabled, _
 dimi extTriggerInput, dimi exttriggeroutput, _
 dimi ftpUpload, dimi ftpFormat, dimi smtpUpload, dimi smtpFormat, _
 dimi noOfFiles, dimi localStore, dimi localFormat, _
 dimi storageLocation, dimi playAudio, dimi audioFiles)
 
 dimi ret
 dims value$
 dims responseData$

 value$ = "alarmenable="+enableAlarm+"&alarmduration="+storageDuration+ _
 "&motionenable="+motionEnabled+"&lostalarm="+ethernetLost+_
 "&darkblankalarm="+darkImage+"&extalarm="+extTriggerEnabled+ _
 "&exttriggerinput="+extTriggerInput+"&exttriggeroutput="+exttriggeroutput+ _
 "&aftpenable="+ftpUpload+"&ftpfileformat="+ftpFormat+ "&asmtpenable="+smtpUpload+ "&attfileformat="+smtpFormat+ _
 "&asmtpattach="+noOfFiles+"&sdaenable="+localStore+"&sdfileformat="+localFormat+ _
 "&alarmlocalstorage="+storageLocation+"&alarmaudioplay="+playAudio+"&alarmaudiofile="+audioFiles

 � value$
 ret = setProperties(value$, responseData$) 

 �B ret > 0 �  

 dims propName$(18) = ("galarmenable", "galarmduration", _
 "gmotionenable", "glostalarm", _
 "gdarkblankalarm","gextalarm", _
 "gexttriggerinput", "gexttriggeroutput", _
 "gaftpenable", "gftpfileformat", "gasmtpenable", "gattfileformat", _
 "gasmtpattach","gsdaenable", "gsdfileformat", _
 "galarmlocalstorage", "galarmaudioplay", "galarmaudiofile")
 
 dims propVal$(18)
 
 propVal$(0) = enableAlarm
 propVal$(1) = storageDuration
 propVal$(2) = motionEnabled
 propVal$(3) = ethernetLost
 propVal$(4) = darkImage  
 propVal$(5) = extTriggerEnabled
 propVal$(6) = extTriggerInput
 propVal$(7) = exttriggeroutput
 propVal$(8) = ftpUpload
 propVal$(9) = ftpFormat
 propVal$(10) = smtpUpload
 propVal$(11) = smtpFormat
 propVal$(12) = noOfFiles
 propVal$(13) = localStore
 propVal$(14) = localFormat
 propVal$(15) = storageLocation
 propVal$(16) = playAudio
 propVal$(17) = audioFiles  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F
 
/***********************************************************

 * Description: 
 * Get the Live video values from camera
 * 
 * Params:
 * byref dims streams$(): String - � get the value of the streams
 * byref dims clicksnapfilename$(): String - � get the filename
 * byref dims democfgname$(): String - 
 * byref dims audioenable: integer - � get the audioenable value
 * byref dims rotation: integer - � get the rotation value
 * byref dims clicksnapstorage: integer - � get the clicksnapstorage value
 * byref dims democfg: integer - � get the democfg value
 * byref dims frecognition: integer - � get the frecognition value
 * Created by:Franklin  On 2009-05-19 12:46:05
 * History: 
 ***********************************************************/
� getLiveVideoOptions(byref dims clicksnapfilename$,byref dims democfgname$, byref dimi audioenable,_
 byref dimi clicksnapstorage,byref dimi democfg,byref dimi audiomode)
 
 dims varName$(6) = ("clicksnapfilename$","democfgname$","audioenable",_
 "clicksnapstorage","democfg","audiomode")
 dims propName$(6) = ("gclicksnapfilename","gdemocfgname","gaudioenable",_
 "gclicksnapstorage","gdemocfg","gaudiomode")
 dims tempVal$(6)
 dimi idx, splitidx, retVal, ret  ,streamIndex
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx=0 � ��(tempVal$)
 �B idx=0 or idx=1 �
 {varName$(idx)} = tempVal$(idx) 
 �C
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 �D  
 �
 
 �D

 � retVal  
�F

/***********************************************************

 * Description: 
 * set audio status(enable/disable)
 * 
 * Params:
 * dimi audiostatus: Numeric - Audio status
 * dimi audiomode: Numeric - Audio mode
 * Created by: On 2009-03-13 15:18:23
 ***********************************************************/
� setAudioStatus(dimi audiostatus,dimi audiomode) 
 Dimi ret
 Dims responseData$, data$ 
 data$ = "audioenable="+audiostatus+"&audiomode="+audiomode
 ret = setProperties(data$, responseData$)
 
 �B ret > 0 �  
 dims propName$(2) = ("gaudioenable","gaudiomode")
 
 dims propVal$(2)
 propVal$(0) = audiostatus
 propVal$(1) = audiomode
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret
 
�F

/***********************************************************

 * Description: 
 * � get the alarm status(On / Off) from camera
 * 
 * Params:
 * dims alarmStatus: Numeric - Alarm status
 * Created by:Franklin  On 2009-03-13 18:49:49
 ***********************************************************/
�h getAlarmstatus(byref dims alarmStatus$) 
 Dims responseData$
 Dimi ret 
 
 ret=�5(~camAddPath$+"vb.htm?getalarmstatus", "","result.txt",2,SUPRESSUI,~authHeader$,1,,responseData$) 
 SETOSVAR("*FLUSHEVENTS", "") 
�F


/***********************************************************

 * Description: � this � � set property value � each property.
 * 
 * 
 * Params:

 * byref dims responseData$: String - � value from the camera
 * Created by: rajan  On 2009-03-18 17:38:12
 * History: 
 ***********************************************************/
� setProperties(dims data$, byref dims responseData$)
 dimi retVal  
 retVal=�5(~camAddPath$+"vb.htm?"+data$, "","result.txt",2,SUPRESSUI,~authHeader$,,,responseData$)
 responseData$ = ��(responseData$, "OK ", "\nOK ")
 responseData$ = ��(responseData$, "UW ", "\nUW ")
 responseData$ = ��(responseData$, "NG ", "\nNG ")
 responseData$ = ��(responseData$, ":", "\n")
 responseData$ = ��(responseData$, "\n\n", "\n")
 setProperties = retVal  
�F


/***********************************************************

 Get video setting value � camera
 * Params: 
 * byref dimi videocodec: Numeric - get the value � the stream type
 * byref dims videocodecname$: String - Holds stream type drop down options

 * byref dims videocodecname$: String - Holds codec combo drop down options
 * byref dimi videocodecres: Numeric - get the value � the resolution type
 * byref dims videocodecresname$: String  - Hold resolution drop down options 
 * Created by: On 2009-05-11 09:44:29
 ***********************************************************/
� getVideoImageSetting(byref dimi videocodec, byref dims videocodecname$, byref dimi videocodecmode, _
 byref dims videocodecmodename$, byref dimi videocodecres, byref dims videocodecresname$) 
 dims varName$(6) = ("videocodec", "videocodecname$", "videocodecmode",_
 "videocodecmodename$", "videocodecres","videocodecresname$")
 dims propName$(6) = ("gvideocodec", "gvideocodecname", "gvideocodeccombo",_
 "gvideocodeccomboname", "gvideocodecres","gvideocodecresname")
 dims tempVal$(6)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i=1 or i=3 or i=5 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret  

�F


/***********************************************************

 Get video stream 1 values from camera
 * Description: 
 * byref dimi framerate1: Numeric - get the framerate � stream1
 * byref dimi frameratename1$: String - get all possible frame rate options � load drop down









 * byref dimi textposition1: Numeric - get the value � textposition of stream1
 * byref dims  textpositionname$: String - get the value � text position drop down option values 


 * byref dimi mirctrl: Numeric - get the option � mirctrl-enable/disable
 * byref dims mirctrlname$: String - get the option � mirror ctrl drop down option values 
 * byref dims overlaytext1$: String - get the overlay text value
 * byref dimi detailinfo1: Numeric - get the  detail info value
 * byref dims localdisplayname$: String - get the local display drop down option values 
 *
 * Created by: On 2009-05-11 09:44:41
 * Histbyref ory: 
 ***********************************************************/
� getVideoStream1(byref dimi framerate1, byref dims frameratename1$, byref dimi bitrate1, _
 byref dimi ratecontrol1, byref dims ratecontrolname$, byref dimi datestampenable1, byref dimi timestampenable1,_
 byref dimi logoenable1, byref dimi logoposition1, byref dims logopositionname$,_
 byref dimi textenable1, byref dimi textposition1, byref dims textpositionname$,_
 byref dimi encryptvideo, byref dimi localdisplay, byref dimi mirctrl,_
 byref dims mirctrlname$, byref dims overlaytext1$,byref dimi detailinfo1,byref dims localdisplayname$) 
 
 dims varName$(20) = ("framerate1", "frameratename1$", "bitrate1", "ratecontrol1", "ratecontrolname$","datestampenable1","timestampenable1",_
 "logoenable1","logoposition1","logopositionname$","textenable1","textposition1","textpositionname$","encryptvideo",_
 "localdisplay","mirctrl","mirctrlname$","overlaytext1$","detailinfo1","localdisplayname$")
 
 dims propName$(20) = ("gframerate1", "gframeratenameall1", "gbitrate1", "gratecontrol1", "gratecontrolname","gdatestampenable1","gtimestampenable1",_
 "glogoenable1","glogoposition1","glogopositionname","gtextenable1","gtextposition1","gtextpositionname","gencryptvideo",_
 "glocaldisplay","gmirctrl","gmirctrlname","goverlaytext1","gdetailinfo1","glocaldisplayname")
 dims tempVal$(20)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$) 
 �B i=1 or i=4 or i=9 or i=12 or i=16 or i=17 or i=19 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret 
 
 
�F


/***********************************************************

 * Description: 
 Get video stream 2 values from camera
 
 * Params:
 * byref dimi framerate2: Numeric - get the framerate � stream2
 * byref dims frameratename2$: String - get all possible frame rate options � load drop down







 * byref dimi textposition2: Numeric - get the value � textposition of stream2
 * byref dims overlaytext2$: String - get the overlay text value
 * byref dimi detailinfo2: Numeric - get the  detail info value
 
 * Created by: On 2009-05-11 09:44:52
 ***********************************************************/
� getVideoStream2(byref dimi framerate2, byref dims frameratename2$, byref dimi bitrate2, byref dimi ratecontrol2, byref dimi datestampenable2,_
 byref dimi timestampenable2, byref dimi logoenable2, byref dimi logoposition2, byref dimi textenable2, byref dimi textposition2,_
 byref dims overlaytext2$,byref dimi detailinfo2) 
 
 dims varName$(12) = ("framerate2", "frameratename2$", "bitrate2", "ratecontrol2", "datestampenable2",_
 "timestampenable2", "logoenable2", "logoposition2", "textenable2", "textposition2","overlaytext2$","detailinfo2")
 
 dims propName$(12) = ("gframerate2", "gframeratenameall2", "gbitrate2", "gratecontrol2", "gdatestampenable2",_
 "gtimestampenable2", "glogoenable2", "glogoposition2", "gtextenable2", "gtextposition2","goverlaytext2","gdetailinfo2")
 
 dims tempVal$(12)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i=1 or i=10 �
 {varName$(i)} = tempVal$(i)
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret 
 
�F


/***********************************************************

 * Description: 
 Get video stream 3 values from camera
 
 * Params:
 * byref dimi framerate3: Numeric - get the framerate � stream3
 * byref dims frameratename3$: String - get all possible frame rate options � load drop down








 * byref dimi textposition3: Numeric - get the value � textposition of stream3
 * byref dims overlaytext3$: String - get the overlay text value
 * byref dimi detailinfo3: Numeric - get the  detail info value
 * Created by: On 2009-05-11 09:45:02
 ***********************************************************/
� getVideoStream3(byref dimi framerate3, byref dims frameratename3$, byref dimi bitrate3, byref dimi ratecontrol3, _
 byref dimi livequality, byref dimi datestampenable3, byref dimi timestampenable3,_
 byref dimi logoenable3, byref dimi logoposition3,_
 byref dimi textenable3, byref dimi textposition3,byref dims overlaytext3$,_
 byref dimi detailinfo3) 
 
 dims varName$(13) = ("framerate3","frameratename3$","livequality","bitrate3","ratecontrol3","datestampenable3", "timestampenable3",_
 "logoenable3", "logoposition3", "textenable3", "textposition3","overlaytext3$",_
 "detailinfo3")
 dims propName$(13) = ("gframerate3","gframeratenameall3","glivequality","gbitrate2", "gratecontrol2", "gdatestampenable3", "gtimestampenable3",_
 "glogoenable3", "glogoposition3","gtextenable3", "gtextposition3","goverlaytext3",_
 "gdetailinfo3")
 
 dims tempVal$(13)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i=1 or i=11 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret  
 
�F

/***********************************************************

 * Description: 
 * � set the values � video Image setting � camera
 * 
 * Params:


 * dimi videocodecres: Numeric - set the value � resolution type
 * dimi mirctrl: Numeric - set the value � mirror control
 * Created by: On 2009-05-11 15:04:26
 ***********************************************************/
� setVideoImageSetting(dimi videocodec,dimi videocodecmode,dimi videocodecres,dimi mirctrl)
 
 dims VideoImageSetting$
 dims responseData$
 dimi ret

 VideoImageSetting$="videocodec="+videocodec+"&videocodeccombo="+videocodecmode+"&videocodecres="+videocodecres+_
 "&mirctrl="+mirctrl
 
 � VideoImageSetting$
 ret = setProperties(VideoImageSetting$, responseData$)

 �B ret > 0 �
 
 dims propName$(4) = ("gvideocodec","gvideocodeccombo", "gvideocodecres","gmirctrl")

 dims propVal$(4)
 propVal$(0) = videocodec
 propVal$(1) = videocodecmode
 propVal$(2) = videocodecres  
 propVal$(3) = mirctrl
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
�F


/***********************************************************

 * Description: 
 * � set the Values � Video Stream1
 * 
 * Params:









 * dimi devicename: Numeric - set the device name  
 * dimi textposition1: Numeric - set the value � textposition of stream1



 * dimi detailinfo1: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 1 stream type(JPEG / other stream(H264,MPEG4))
 * Created by: On 2009-05-11 15:09:54
 * History: 
 ***********************************************************/
� setVideoStream1(dimi framerate1,dimi bitrate1,dimi ratecontrol1,dimi liveQuality,dimi datestampenable1,_
 dimi timestampenable1,dimi logoenable1,dimi logoposition1,dimi textenable1, dims devicename$,_
 dimi textposition1, dimi encryptvideo,dimi localdisplay, dims overlaytext1$,dimi detailinfo1,dims streamType$)
 
 dims VideoStream1$
 dims responseData$
 dimi ret
 �B streamType$ = "JPEG" �
 VideoStream1$="framerate1="+framerate1+"&livequality="+liveQuality+_
 "&datestampenable1="+datestampenable1+"&timestampenable1="+timestampenable1+_
 "&logoenable1="+logoenable1+"&logoposition1="+logoposition1+"&textenable1="+textenable1+"&title="+devicename$+_
 "&textposition1="+textposition1+"&encryptvideo="+encryptvideo+"&localdisplay="+localdisplay+"&overlaytext1="+overlaytext1$+_
 "&detailinfo1="+detailinfo1
 �C 
 VideoStream1$="framerate1="+framerate1+"&bitrate1="+bitrate1+"&ratecontrol1="+ratecontrol1+_
 "&datestampenable1="+datestampenable1+"&timestampenable1="+timestampenable1+_
 "&logoenable1="+logoenable1+"&logoposition1="+logoposition1+"&textenable1="+textenable1+"&title="+devicename$+_
 "&textposition1="+textposition1+"&encryptvideo="+encryptvideo+"&localdisplay="+localdisplay+"&overlaytext1="+overlaytext1$+_
 "&detailinfo1="+detailinfo1
 �D
 � VideoStream1$
 ret = setProperties(VideoStream1$, responseData$)
 
 � �&(responseData$,"OK title")>0 � ~title$ = devicename$
 
 �B ret > 0 �
 
 dims propName$(15) = ("gframerate1","gbitrate1","gratecontrol1","glivequality"_
 "gdatestampenable1","gtimestampenable1",_
 "glogoenable1","glogoposition1","gtextenable1","gtitle",_
 "gtextposition1","gencryptvideo","glocaldisplay","goverlaytext1","gdetailinfo1")
 
 dims propVal$(15)
 propVal$(0) = framerate1
 propVal$(1) = bitrate1
 propVal$(2) = ratecontrol1
 propVal$(3) = liveQuality
 propVal$(4) = datestampenable1
 propVal$(5) = timestampenable1
 propVal$(6) = logoenable1
 propVal$(7) = logoposition1
 propVal$(8) = textenable1
 propVal$(9) = devicename$
 propVal$(10) = textposition1
 propVal$(11) = encryptvideo
 propVal$(12) = localdisplay  
 propVal$(13) = overlaytext1$
 propVal$(14) = detailinfo1  
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
 
�F

/***********************************************************

 * Description: 
 * � set the Values � Video Stream2
 * 
 * Params:
 








 * dimi textposition2: Numeric - set the value � textposition of stream2

 * dimi detailinfo2: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 2 stream type(JPEG / other stream(H264,MPEG4))

 * Created by: On 2009-05-11 15:16:10  
 * History: 
 ***********************************************************/
� setVideoStream2(dimi framerate2,dims bitrate2$,dimi ratecontrol2,dimi liveQuality,dimi datestampenable2,_
 dimi timestampenable2,dimi logoenable2,dimi logoposition2, dimi textenable2,_
 dimi textposition2, dims overlaytext2$,dimi detailinfo2,dims streamType$) 
 
 dims VideoStream2$
 dims responseData$
 dimi ret
 �B streamType$ = "JPEG" �
 VideoStream2$= "framerate2="+framerate2+"&livequality="+liveQuality+_
 "&datestampenable2="+datestampenable2+"&timestampenable2="+timestampenable2+_
 "&logoenable2="+logoenable2+"&logoposition2="+logoposition2+"&textenable2="+textenable2+_
 "&textposition2="+textposition2+"&overlaytext2="+overlaytext2$+"&detailinfo2="+detailinfo2
 �C 
 VideoStream2$= "framerate2="+framerate2+"&bitrate2="+bitrate2$+"&ratecontrol2="+ratecontrol2+_
 "&datestampenable2="+datestampenable2+"&timestampenable2="+timestampenable2+_
 "&logoenable2="+logoenable2+"&logoposition2="+logoposition2+"&textenable2="+textenable2+_
 "&textposition2="+textposition2+"&overlaytext2="+overlaytext2$+"&detailinfo2="+detailinfo2
 �D
 
 ret = setProperties(VideoStream2$, responseData$)
 
 �B ret > 0 �
 
 dims propName$(12) = ("gframerate2","gbitrate2","gratecontrol2","glivequality"_
 "gdatestampenable2","gtimestampenable2",_
 "glogoenable2","glogoposition2","gtextenable2",_
 "gtextposition2","goverlaytext2","gdetailinfo2")

 dims propVal$(12)
 propVal$(0)=framerate2
 propVal$(1)=bitrate2$
 propVal$(2)=ratecontrol2
 propVal$(3)=livequality
 propVal$(4)=datestampenable2
 propVal$(5)=timestampenable2
 propVal$(6)=logoenable2
 propVal$(7)=logoposition2
 propVal$(8)=textenable2
 propVal$(9)=textposition2
 propVal$(10)=overlaytext2$
 propVal$(11)=detailinfo2
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F


/***********************************************************

 * Description: 
 * � set the Values � Video Stream3
 * 
 * Params:
 








 * dimi textposition3: Numeric - set the value � textposition of stream3

 * dimi detailinfo3: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 3 stream type(JPEG / other stream(H364,MPEG4))
 * Created by: On 2009-05-11 15:55:09
 ***********************************************************/
� setVideoStream3(dimi framerate3,dims bitrate3$,dimi ratecontrol3,dimi liveQuality,_
 dimi datestampenable3,dimi timestampenable3,dimi logoenable3,dimi logoposition3,_
 dimi textenable3,dimi textposition3, dims overlaytext3$,dimi detailinfo3,dims streamType$)
 
 dims VideoStream3$
 dims responseData$
 dimi ret
 
 �B streamType$ = "JPEG" �
 VideoStream3$="framerate3="+framerate3+"&livequality="+liveQuality+_
 "&datestampenable3="+datestampenable3+"&timestampenable3="+timestampenable3+"&logoenable3="+logoenable3+_
 "&logoposition3="+logoposition3+"&textenable3="+textenable3+_
 "&textposition3="+textposition3+"&overlaytext3="+overlaytext3$+"&detailinfo3="+detailinfo3
 �C 
 VideoStream3$="framerate3="+framerate3+"&bitrate2="+bitrate3$+"&ratecontrol2="+ratecontrol3+_
 "&datestampenable3="+datestampenable3+"&timestampenable3="+timestampenable3+"&logoenable3="+logoenable3+_
 "&logoposition3="+logoposition3+"&textenable3="+textenable3+_
 "&textposition3="+textposition3+"&overlaytext3="+overlaytext3$+"&detailinfo3="+detailinfo3
 �D  
 
 � VideoStream3$
 
 ret = setProperties(VideoStream3$, responseData$)
 
 �B ret > 0 �
 
 dims propName$(12) = ("gframerate3","gbitrate2","gratecontrol2","glivequality"_
 "gdatestampenable3","gtimestampenable3",_
 "glogoenable3","glogoposition3","gtextenable3",_
 "gtextposition3","goverlaytext3","gdetailinfo3")

 dims propVal$(12)
 propVal$(0)=framerate3
 propVal$(1)=bitrate3$
 propVal$(2)=ratecontrol3
 propVal$(3)=liveQuality
 propVal$(4)=datestampenable3
 propVal$(5)=timestampenable3
 propVal$(6)=logoenable3
 propVal$(7)=logoposition3
 propVal$(8)=textenable3
 propVal$(9)=textposition3
 propVal$(10)=overlaytext3$  
 propVal$(11)=detailinfo3  
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
�F


/***********************************************************

 * Description: 
 * � get the Values � Video - Advanced setting from camera
 * Params:



















 * byref dimi str1h3: Numeric - Region parameters value � Height
 * byref dimi qpinit1: Numeric - Get QP init value
 
 * Created by: On 2009-05-11 17:35:48
 * History: 
 ***********************************************************/
� getVideoImageAdvanced1(byref dims ipratio1$, byref dimi forceiframe1, byref dims qpmin1$,_
 byref dims qpmax1$, byref dimi meconfig1, byref dims meconfigname$, byref dims packetsize1$,_
 byref dimi regionofinterestenable1,_
 byref dimi str1x1, byref dimi str1y1, byref dimi str1w1, byref dimi str1h1,_
 byref dimi str1x2, byref dimi str1y2, byref dimi str1w2, byref dimi str1h2,_
 byref dimi str1x3, byref dimi str1y3, byref dimi str1w3, byref dimi str1h3,_
 byref dimi qpinit1) 
 
 
 dims varName$(21)=("ipratio1$","qpmin1$","qpmax1$","meconfigname$","packetsize1$",_
 "forceiframe1","regionofinterestenable1","meconfig1",_
 "str1x1","str1y1","str1w1","str1h1",_
 "str1x2","str1y2","str1w2","str1h2",_
 "str1x3","str1y3","str1w3","str1h3","qpinit1")
 
 dims propName$(21)=("gipratio1","gqpmin1","gqpmax1","gmeconfigname","gpacketsize1",_
 "gforceiframe1","gregionofinterestenable1","gmeconfig1",_
 "gstr1x1","gstr1y1","gstr1w1","gstr1h1",_
 "gstr1x2","gstr1y2","gstr1w2","gstr1h2",_
 "gstr1x3","gstr1y3","gstr1w3","gstr1h3","gqpinit1")
 dims tempVal$(21)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i<=4 �  
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i))
 �D
 �
 �D

 � ret 
 
�F

/***********************************************************

 * Description: 
 * � get the Values � VideoImageAdvanced2 setting
 * 
 * Params:


















 * byref dimi str2h3: Numeric - Region parameters value � Height
 * byref dimi qpinit2: Numeric - Get QP init value
 * Created by: On 2009-05-11 17:43:36
 * History: 
 ***********************************************************/
� getVideoImageAdvanced2(byref dims ipratio2$, byref dimi forceiframe2, byref dims qpmin2$, byref dims qpmax2$,_
 byref dimi meconfig2, byref dims packetsize2$, byref dimi regionofinterestenable2,_
 byref dimi str2x1, byref dimi str2y1, byref dimi str2w1, byref dimi str2h1,_
 byref dimi str2x2, byref dimi str2y2, byref dimi str2w2, byref dimi str2h2,_
 byref dimi str2x3, byref dimi str2y3, byref dimi str2w3, byref dimi str2h3, byref dimi qpinit2) 
 
 dims varName$(20)=("ipratio2$","qpmin2$","qpmax2$","packetsize2$",_
 "forceiframe2","regionofinterestenable2","meconfig2",_
 "str2x1","str2y1","str2w1","str2h1",_
 "str2x2","str2y2","str2w2","str2h2",_
 "str2x3","str2y3","str2w3","str2h3","qpinit2")
 
 dims propName$(20)=("gipratio2","gqpmin2","gqpmax2","gpacketsize2",_
 "gforceiframe2","gregionofinterestenable2","gmeconfig2",_
 "gstr2x1","gstr2y1","gstr2w1","gstr2h1",_
 "gstr2x2","gstr2y2","gstr2w2","gstr2h2",_
 "gstr2x3","gstr2y3","gstr2w3","gstr2h3","gqpinit2")
 
 dims tempVal$(20)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i<=3 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret 
 
�F

/***********************************************************

 * Description: 
 * � get the Values � VideoImageAdvanced3 setting
 * 
 * Params:




















 * byref dimi str3h3: Numeric - Region parameters value � Height
 * byref dimi qpinit3: Numeric - Get QP init value
 * Created by: On 2009-05-11 17:47:28
 * History: 
 ***********************************************************/
� getVideoImageAdvanced3(byref dimS ipratio3$, byref dimi forceiframe3, byref dimS qpmin3$, byref dimS qpmax3$, byref dimi meconfig3,_
 byref dims packetsize3$, byref dimi regionofinterestenable3,_
 byref dimi str3x1, byref dimi str3y1, byref dimi str3w1, byref dimi str3h1,_
 byref dimi str3x2, byref dimi str3y2, byref dimi str3w2, byref dimi str3h2,_
 byref dimi str3x3, byref dimi str3y3, byref dimi str3w3, byref dimi str3h3, byref dimi qpinit3) 
 
 dims varName$(20)=("ipratio3$","qpmin3$","qpmax3$","packetsize3$",_
 "forceiframe3","regionofinterestenable3","meconfig3",_
 "str3x1","str3y1","str3w1","str3h1",_
 "str3x2","str3y2","str3w2","str3h2",_
 "str3x3","str3y3","str3w3","str3h3","qpinit3")
 
 dims propName$(20)=("gipratio3","gqpmin3","gqpmax3","gpacketsize3",_
 "gforceiframe3","gregionofinterestenable3","gmeconfig3",_
 "gstr3x1","gstr3y1","gstr3w1","gstr3h1",_
 "gstr3x2","gstr3y2","gstr3w2","gstr3h2",_
 "gstr3x3","gstr3y3","gstr3w3","gstr3h3","gqpinit3")
 
 dims tempVal$(20)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 �B ret>=0 �
 � i= 0 � ��(tempVal$)
 �B i<=3 �
 {varName$(i)} = tempVal$(i) 
 �C 
 {varName$(i)} = strtoint(tempVal$(i)) 
 �D
 �
 �D
 
 � ret  
 
�F

/***********************************************************

 * Description: 
 * � set the Values � Video Advanced 1 setting
 * 
 * Params:



















 * dimi str1h3: Numeric - Region parameters value � Height
 * Created by: On 2009-05-11 20:05:42
 * History: 
 ***********************************************************/
� setVideoImageAdvanced1(dims ipratio1$, dimi forceiframe1, dims qpmin1$, dims qpmax1$, dims  qpinit1$,_
 dimi meconfig1, dims packetsize1$, dimi regionofinterestenable1,_
 dimi str1x1, dimi str1y1, dimi str1w1, dimi str1h1,_
 dimi str1x2, dimi str1y2, dimi str1w2, dimi str1h2,_
 dimi str1x3, dimi str1y3, dimi str1w3, dimi str1h3) 

 dims VideoImageAdvanced1$
 dims responseData$
 dimi ret
 VideoImageAdvanced1$="ipratio1="+ipratio1$+"&forceiframe1="+forceiframe1+"&qpmin1="+qpmin1$+"&qpmax1="+qpmax1$+"&qpinit1="+qpinit1$+_
 "&meconfig1="+meconfig1+"&packetsize1="+packetsize1$+"&regionofinterestenable1="+regionofinterestenable1+_
 "&str1x1="+str1x1+"&str1y1="+str1y1+"&str1w1="+str1w1+"&str1h1="+str1h1+_
 "&str1x2="+str1x2+"&str1y2="+str1y2+"&str1w2="+str1w2+"&str1h2="+str1h2+_
 "&str1x3="+str1x3+"&str1y3="+str1y3+"&str1w3="+str1w3+"&str1h3="+str1h3+""
 � VideoImageAdvanced1$
 
 ret = setProperties(VideoImageAdvanced1$, responseData$)

 �B ret > 0 �
 
 dims propName$(20) = ("gipratio1","gforceiframe1","gqpmin1","gqpmax1","gqpinit1"_
 "gmeconfig1","gpacketsize1","gregionofinterestenable1",_
 "gstr1x1","gstr1y1","gstr1w1","gstr1h1",_
 "gstr1x2","gstr1y2","gstr1w2","gstr1h2",_
 "gstr1x3","gstr1y3","gstr1w3","gstr1h3")

 dims propVal$(20)
 propVal$(0)=ipratio1$  
 propVal$(1)=forceiframe1  
 propVal$(2)=qpmin1$  
 propVal$(3)=qpmax1$  
 propVal$(4)=qpinit1$  
 propVal$(5)=meconfig1  
 propVal$(6)=packetsize1$  
 propVal$(7)=regionofinterestenable1 
 propVal$(8)=str1x1  
 propVal$(9)=str1y1  
 propVal$(10)=str1w1  
 propVal$(11)=str1h1  
 propVal$(12)=str1x2  
 propVal$(13)=str1y2  
 propVal$(14)=str1w2  
 propVal$(15)=str1h2  
 propVal$(16)=str1x3  
 propVal$(17)=str1y3  
 propVal$(18)=str1w3  
 propVal$(19)=str1h3 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F
/***********************************************************

 * Description: 
 * � set the Values � Video Advanced 2 setting
 * 
 * Params:



















 * dimi str2h3: Numeric - Region parameters value � Height
 * Created by: On 2009-05-11 20:05:42
 * History: 
 ***********************************************************/
� setVideoImageAdvanced2(dims ipratio2$, dimi forceiframe2, dims qpmin2$, dims qpmax2$, dims qpinit2$,_
 dimi meconfig2, dims packetsize2$, dimi regionofinterestenable2,_
 dimi str2x1, dimi str2y1, dimi str2w1, dimi str2h1,_
 dimi str2x2, dimi str2y2, dimi str2w2, dimi str2h2,_
 dimi str2x3, dimi str2y3, dimi str2w3, dimi str2h3) 
 dims VideoImageAdvanced2$
 dims responseData$
 dimi ret
 VideoImageAdvanced2$="ipratio2="+ipratio2$+"&forceiframe2="+forceiframe2+"&qpmin2="+qpmin2$+"&qpmax2="+qpmax2$+"&qpinit2="+qpinit2$+_
 "&meconfig2="+meconfig2+"&packetsize2="+packetsize2$+"&regionofinterestenable2="+regionofinterestenable2+_
 "&str2x1="+str2x1+"&str2y1="+str2y1+"&str2w1="+str2w1+"&str2h1="+str2h1+_
 "&str2x2="+str2x2+"&str2y2="+str2y2+"&str2w2="+str2w2+"&str2h2="+str2h2+_
 "&str2x3="+str2x3+"&str2y3="+str2y3+"&str2w3="+str2w3+"&str2h3="+str2h3+""
 
 � VideoImageAdvanced2$  
 
 ret = setProperties(VideoImageAdvanced2$, responseData$)

 �B ret > 0 �
 
 dims propName$(20) = ("gipratio2","gforceiframe2","gqpmin2","gqpmax2","gqpinit2"_
 "gmeconfig2","gpacketsize2","gregionofinterestenable2",_
 "gstr2x1","gstr2y1","gstr2w1","gstr2h1",_
 "gstr2x2","gstr2y2","gstr2w2","gstr2h2",_
 "gstr2x3","gstr2y3","gstr2w3","gstr2h3")

 dims propVal$(20)
 propVal$(0)=ipratio2$  
 propVal$(1)=forceiframe2  
 propVal$(2)=qpmin2$  
 propVal$(3)=qpmax2$  
 propVal$(4)=qpinit2$  
 propVal$(5)=meconfig2  
 propVal$(6)=packetsize2$ 
 propVal$(7)=regionofinterestenable2 
 propVal$(8)=str2x1  
 propVal$(9)=str2y1  
 propVal$(10)=str2w1  
 propVal$(11)=str2h1  
 propVal$(12)=str2x2  
 propVal$(13)=str2y2  
 propVal$(14)=str2w2  
 propVal$(15)=str2h2  
 propVal$(16)=str2x3  
 propVal$(17)=str2y3  
 propVal$(18)=str2w3  
 propVal$(19)=str2h3  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F 

/***********************************************************

 * Description: 
 * � set the Values � VideoImageAdvanced3 setting
 * 
 * Params:



















 * dimi str3h3: Numeric - Region parameters value � Height
 * Created by: On 2009-05-19 12:08:27
 ***********************************************************/

� setVideoImageAdvanced3(dims ipratio3$, dimi forceiframe3, dims qpmin3$, dims qpmax3$,dims qpinit3$, _
 dimi meconfig3, dims packetsize3$, dimi regionofinterestenable3,_
 dimi str3x1, dimi str3y1, dimi str3w1, dimi str3h1,_
 dimi str3x2, dimi str3y2, dimi str3w2, dimi str3h2,_
 dimi str3x3, dimi str3y3, dimi str3w3, dimi str3h3) 
 
 dims VideoImageAdvanced3$
 dims responseData$
 dimi ret
 VideoImageAdvanced3$="ipratio3="+ipratio3$+"&forceiframe3="+forceiframe3+"&qpmin3="+qpmin3$+"&qpmax3="+qpmax3$+"&qpinit3="+qpinit3$+_
 "&meconfig3="+meconfig3+"&packetsize3="+packetsize3$+"&regionofinterestenable3="+regionofinterestenable3+_
 "&str3x1="+str3x1+"&str3y1="+str3y1+"&str3w1="+str3w1+"&str3h1="+str3h1+_
 "&str3x2="+str3x2+"&str3y2="+str3y2+"&str3w2="+str3w2+"&str3h2="+str3h2+_
 "&str3x3="+str3x3+"&str3y3="+str3y3+"&str3w3="+str3w3+"&str3h3="+str3h3+""
 � VideoImageAdvanced3$
 
 
 ret = setProperties(VideoImageAdvanced3$, responseData$)

 �B ret > 0 �
 
 dims propName$(20) = ("gipratio3","gforceiframe3","gqpmin3","gqpmax3","gqpinit3"_
 "gmeconfig3","gpacketsize3","gregionofinterestenable3",_
 "gstr3x1","gstr3y1","gstr3w1","gstr3h1",_
 "gstr3x2","gstr3y2","gstr3w2","gstr3h2",_
 "gstr3x3","gstr3y3","gstr3w3","gstr3h3")
 dims propVal$(20)
 propVal$(0)=ipratio3$  
 propVal$(1)=forceiframe3  
 propVal$(2)=qpmin3$  
 propVal$(3)=qpmax3$  
 propVal$(4)=qpinit3$  
 propVal$(5)=meconfig3  
 propVal$(6)=packetsize3$  
 propVal$(7)=regionofinterestenable3 
 propVal$(8)=str3x1  
 propVal$(9)=str3y1  
 propVal$(10)=str3w1  
 propVal$(11)=str3h1  
 propVal$(12)=str3x2  
 propVal$(13)=str3y2  
 propVal$(14)=str3w2  
 propVal$(15)=str3h2  
 propVal$(16)=str3x3  
 propVal$(17)=str3y3  
 propVal$(18)=str3w3  
 propVal$(19)=str3h3  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F 




/***********************************************************

 * Description: � get audio setting screen values
 * 
 * 
 * Params:





 * byref dimi bitRate: Numeric - Bit Rate
 * byref dimi alarmLevel: Numeric - Value ranges between 1 and 100
 * byref dimi outputVolume Numeric - Value ranges between 1 and 100.
 * Created by: vimala On 2009-05-11 21:59:09
 ***********************************************************/
� getAudioSetting(byref dimi enableAudio, byref dimi audioMode, byref dimi inputVolume, _
 byref dimi encoding, byref dimi sampleRate, byref dimi bitRate, _
 byref dimi alarmLevel, byref dimi outputVolume)
 
 dims varName$(8) = ("enableAudio","audioMode","inputVolume", _
 "encoding","sampleRate","bitRate", _
 "alarmLevel","outputVolume") 

 
 dims propName$(8) = ("gaudioenable","gaudiomode","gaudioinvolume", _
 "gencoding","gsamplerate","gaudiobitrate", _
 "galarmlevel","gaudiooutvolume")
 
 dims tempVal$(8)
 dimi i,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �
 
 � i= 0 � ��(tempVal$) 
 
 {varName$(i)} = strtoint(tempVal$(i)) 
 
 �
 
 �D
 
 � retVal  
 
�F



/***********************************************************

 * Description: 
 * Get drop down values � audio setting
 * 
 * Params:
 * byref dims audioMode$: String array - Audio mode drop down option
 * byref dims encoding$: String array - Encoding drop down option
 * byref dims sampleRate$: String array - Sample Rate drop down option
 * byref dims bitRate$: String array- Bit Rate drop down option *
 * Created by: vimala On 2009-05-11 22:03:36
 ***********************************************************/
� getAudioOptions( byref dims audioMode$(), byref dims encoding$(), _
 byref dims sampleRate$(), byref dims bitRate$())
 
 dims varName$(4) = ("audioMode$","encoding$","sampleRate$","bitRate$")
 dims propName$(4) = ("gaudiomodename","gencodingname","gsampleratename","gaudiobitratename")
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx = 0 � ��(tempVal$)
 
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount > 0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �
 
 �D
 
 � retVal
 
�F


/***********************************************************

 * Description: 
 * � set the values � Audio Setting � camera
 * 
 * Params:







 * dimi outputVolume Numeric - Value ranges between 1 and 100.
 * Created by: vimala On 2009-05-11 06:55:30
 ***********************************************************/
� setAudioSetting(dimi enableAudio, dimi audioMode, dimi inputVolume, _
 dimi encoding, dimi sampleRate, dimi bitRate, _
 dimi alarmLevel, dimi outputVolume) 
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "audioenable="+enableAudio+"&audiomode="+audioMode+"&audioinvolume="+inputVolume+_
 "&encoding="+encoding+"&samplerate="+sampleRate+"&audiobitrate="+bitRate+_
 "&alarmlevel="+alarmLevel+"&audiooutvolume="+outputVolume
 � value$  
 ret = setProperties(value$, responseData$) 
 
 �B ret > 0 �
 
 dims propName$(8) = ("gaudioenable","gaudiomode","gaudioinvolume", _
 "gencoding","gsamplerate","gaudiobitrate", _
 "galarmlevel","gaudiooutvolume")
 dims propVal$(8)
 
 propVal$(0) = enableAudio
 propVal$(1) = audioMode
 propVal$(2) = inputVolume
 propVal$(3) = encoding
 propVal$(4) = sampleRate
 propVal$(5) = bitRate
 propVal$(6) = alarmLevel
 propVal$(7) = outputVolume
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F


/***********************************************************

 * Description: 
 * � set the Values � click snap user input controls
 * 
 * Params:

 * dimi clicksnapstorage: Numeric - click snap storage option value
 * Created by: On 2009-05-20 11:07:09
 ***********************************************************/
� setLiveVideoOptions(dims clicksnapfilename$, dimi clicksnapstorage)
 
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "clicksnapfilename="+clicksnapfilename$+"&clicksnapstorage="+clicksnapstorage+""

 ret = setProperties(value$, responseData$)

 �B ret > 0 �
 
 dims propName$(2) = ("gclicksnapfilename","gclicksnapstorage")
 
 dims propVal$(8)
 
 propVal$(0) = clicksnapfilename$
 propVal$(1) = clicksnapstorage
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret  
 
�F



/***********************************************************

 * Description: Get stream avaiable stream name feom camera
 * 
 * Params:




 * Created by: Vimala On 2010-01-13 02:21:31
 ***********************************************************/
� getStreamDisplayOrder(byref dimi videocodec,byref dims streamName1$,_
 byref dims streamName2$, byref dims streamName3$) 
 dims varName$(4) = ("videocodec","streamName1$","streamName2$","streamName3$") 
 dims propName$(4) = ("gvideocodec","gstreamname1","gstreamname2","gstreamname3")
 
 dims tempVal$(4)
 dimi i,retVal  
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �
 
 � i= 0 � ��(tempVal$)
 �B i = 0 �
 {varName$(i)} = strtoint(tempVal$(i))
 �C 
 {varName$(i)} = tempVal$(i) 
 �D
 �
 
 
 �D
 
 � retVal  
 
�F


/***********************************************************

 * Description: 
 * � get the Version Number � the params from the ini.htm
 * 
 * Params:




 * byref Dims GUIVersion: Numeric - retrieve the Version Number
 * Created by: Franklin Jacques.k On 2009-10-08 11:28:28
 ***********************************************************/
� getSupportData(byref Dims kernelVersion$, byref Dims UbootVersion$, byref Dims SoftwareVersion$)
 
 dims varName$(3)=("kernelVersion$", "UbootVersion$", "SoftwareVersion$")
 dims propName$(3)=("gkernelversion", "gbiosversion", "gsoftwareversion")
 dims tempVal$(3)
 dimi i,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 �B retVal = 0 �
 
 � i= 0 � ��(tempVal$)
 {varName$(i)} = tempVal$(i)
 �
 
 �D
 
 � retVal
 
�F


/***********************************************************

 * Description: Get SD card insert status from camera
 0: SD card is not inserted.
 1: SD card is inserted, but not mounted
 3: SD card is inserted & mounted
 * Params:
 * byref Dims sdInsertVal$: String - SD card inserted value 
 * Created by: On 2009-10-19 12:25:29
 * History: 
 ***********************************************************/
� getSDCardValue(byref Dims sdInsertVal$)
 dimi ret 
 
 ret=�5(~camAddPath$+"vb.htm?paratest=sdinsert", "","test1.txt",2,SUPRESSUI,~authHeader$,,,sdInsertVal$)
 
 
 �B ret > 0 �
 � ret
 �C
 � -10  
 �D 
 
 
�F


/***********************************************************

 * Description: Set example value � camera
 * 
 * Params:
 * byref Dimi democfg: Numeric - Example drop down selected value  
 * Created by: Vimala On 2009-12-15 00:26:47
 ***********************************************************/
� setExampleValue(dimi democfg)
 dimi ret
 dims responseData$, data$ 
 data$ = "democfg="+democfg
 ret = setProperties(data$, responseData$)
 
 �B ret > 0 �  
 dims propName$(1) = ("gdemocfg")
 
 dims propVal$(1)
 propVal$(0) = democfg
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret
 
�F

/***********************************************************

 * Description: � this � � get the values of video file section
 
 * Params:



 * VideoSize$: String - Video size drop down
 * Created by: vimala On 2009-12-15 03:11:55
 * History: 
 ***********************************************************/
� getVideoFile(byref dimi videoStream,byref dims videoStreamName$(),byref dimi videoSize,byref dims VideoSize$()) 
 dims varName$(4) = ("videoStreamName$","VideoSize$","videoStream","videoSize")
 dims propName$(4) = ("gaviformatname","gavidurationname","gaviformat","gaviduration")
 
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount  
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 
 � idx= 0 � ��(tempVal$)
 
 �B idx = 0 or idx =1 �
 splitChar$ = ";"
 sptCount = �<(optionValue$, tempVal$(idx), splitChar$)
 � sptCount>0 � redim {varName$(idx)}(sptCount)
 
 � splitidx = 0 � sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 �
 
 �C 
 {varName$(idx)} = strtoint(tempVal$(idx))
 �D
 
 �
 
 �D
 
 � retVal
�F



/***********************************************************

 * Description: � this � � Set the values of video file section
 * 
 * 
 * Params:

 * dimi videoSize: Numeric - video size selected value
 * Created by: Vimala On 2010-05-04 14:51:03
 * History: 
 ***********************************************************/
� setVideoFile(dimi videoStream, dimi videoSize) 
 dimi ret
 dims responseData$, data$ 
 data$ = "aviformat="+videoStream+"&aviduration="+videoSize
 � data$
 ret = setProperties(data$, responseData$)
 
 �B ret > 0 �  
 dims propName$(2) = ("gaviformatname","gaviduration")
 
 dims propVal$(2)
 propVal$(0) = videoStream
 propVal$(1) = videoSize
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 �B � (~errorKeywords$) > 0 �
 � -10
 �C
 � ret
 �D  
 
 �D 
 
 � ret
 
�F


/***********************************************************

 * Description: � this � � get the reload � from IPNC
 * 
 * 
 * Params:
 * reloadTime: Numeric - IPNC reload �
 * Created by: Vimala On 2010-01-05 06:20:36
 * History: 
 ***********************************************************/
� getLoadingTime(byref dimi reloadTime) 
 dims propName$(1) = ("greloadtime")
 dims tempVal$(1) 
 dimi retVal
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 reloadTime = strtoint(tempVal$(0))
 �D

 
 � retVal
�F


/***********************************************************

 * Description: � this � � delete all the schedules
 * 
 * Created by: Vimala On 2010-05-04 14:52:13
 ***********************************************************/
�h setDeleteSchedule$() 
 dimi ret
 dims responseData$, data$ 
 data$ = "delschedule=1"
 � data$
 ret = setProperties(data$, responseData$) 
�F



/***********************************************************

 * Description: � this � � fetch reloadflag from IPNC
 
 * Created by: Vimala On 2010-04-13 18:32:14
 ***********************************************************/
� getReloadFlag() 
 getReloadFlag = -1
 dimi retVal
 dims responseData$
 
 retVal=�5(~camAddPath$+"vb.htm?paratest=reloadflag", "","test1.txt",2,SUPRESSUI,~authHeader$,,,responseData$)
 
 
 �B retVal >= 0 �
 � responseData$
 getReloadFlag = �(��(responseData$,"OK reloadflag=",""))
 �D
 
 � "getReloadFlag = " + getReloadFlag
 
�F



/***********************************************************

 * Description: � this � � get dmva enable value from camera
 * Enable Smart Analytics in the �� menu only �B the flag "dmvaenable" = 1 
 * Created by:Vimala  On 2010-05-24 10:53:08
 * History: 
 ***********************************************************/
� getDMVAEnableValue() 
 getDMVAEnableValue = -1
 dimi retVal
 dims responseData$
 
 retVal=�5(~camAddPath$+"vb.htm?paratest=dmvaenable", "","test1.txt",2,SUPRESSUI,~authHeader$,,,responseData$) 
 �B retVal >= 0 �
 � responseData$
 getDMVAEnableValue = �(��(responseData$,"OK dmvaenable=",""))
 �D
 
 
 � "dmvaenable = " + getDMVAEnableValue
 
�F

/***********************************************************

 * Description: 
 * 
 * 
 * Params:



 * maxPwdLen: Numeric - 
 * Created by: On 2010-07-16 12:46:39
 * History: 
 ***********************************************************/
� getCtrlMaxMinValues(byref dimi minNameLen,byref dimi maxNameLen,byref dimi minPwdLen,byref dimi maxPwdLen) 
 SETOSVAR("*FLUSHEVENTS", "") 
 dims varName$(4) = ("minNameLen","maxNameLen","minPwdLen","maxPwdLen")
 dims propName$(4) = ("gminnamelen","gmaxnamelen","gminpwdlen","gmaxpwdlen")
 dims tempVal$(4) 
 dimi retVal,i
 
 retVal = getIniValues(propName$, tempVal$)
 
 �B retVal = 0 �
 � i = 0 � ��(tempVal$)
 � tempVal$(i)
 {varName$(i)} = �(tempVal$(i))
 �
 �D
 
 � retVal
�F



/***********************************************************

 * Description: � debug and �& the runtime values
 * Created by: On 2009-12-22 00:22:13
 ***********************************************************/
�h writeToFile(dims XMLString$)
 dimi h1,b,ret
 h1=�K("setString.txt",1,3)
 XMLString$ = XMLString$ + "\n"
 b=�M(h1,XMLString$)
 ret=�O(h1)
 
�F


/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : �� Menu  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS � A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE � ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES � LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY � USE THE SOFTWARE, EVEN �B GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/
Functioni extern "user32" SetCursor(Dimi hCursor)
�F

Functioni extern "user32" LoadCursorA(Dimi Instance, Dimi lpCursorName)
�F


dims ~menuArray$(MAXMAINMENU+MAXSUBMENU+3)
dims menuOffImg$(MAXMAINMENU) = ("!camera_Off.bin","!users_Off.bin","!settings_Off.bin","!maintanance_off.bin","!support_off.bin")
dims ~menuOnImg$(MAXMAINMENU) = ("!camera_On.bin","!users_On.bin","!settings_On.bin","!maintanance_on.bin","!support_on.bin")
dims ~urlMainArray$(MAXMAINMENU) = ("!liveVideo.frm", "!addusers.frm","!videoImageSettings.frm","!maintenance.frm","!supportScreen.frm")
dims ~urlSubArray$(MAXSUBMENU) = ("!videoImageSettings.frm","!videoAnalyticsSetting.frm","!DMVAeventMonitor.frm","!cameraSettings.frm", "!audioSetting.frm","!setDateTime.frm", "!NetworkSettings.frm", "!alarmSettings.frm", "!storageSetting.frm")

dimi dmvaEnable

#imgselected.hidden = 1  
loadMenuCaptions()
#imgselected.desth = #rosubmenu.h +20  

dimi canReload = 1  


dimi wait = 0  

dimi noLeftMenuCtrls 
dimi arrMousePos(14, 4)

� alginBGImage  
� buildLeftTree()

/***********************************************************

 * Description: Lock mouse scroll
 * Created by: Franklin On 2009-05-15 15:21:15
 * History: 
 ***********************************************************/
�h scroll_Keypressed(key)
 dimi k1=26 
 dimi k2=25
 
 �B k1=key or k2=key �
 �-(2)
 �D  
 
�F

/***********************************************************

 * Description: Resize back ground images based on screen resolution.
 * Created by: vimala  On 2009-05-15 06:07:30
 * History: 
 ***********************************************************/
�h alginBGImage()
 dmvaEnable = getDMVAEnableValue()
 
 dimi START_YVALUE,MENU_GAP,SUBMENU_GAP  
 
 START_YVALUE=80
 MENU_GAP=50
 SUBMENU_GAP=30  
 
 dimi i
 dimi xResVal,yResVal
 yResVal = ~menuYRes
 dims ctrlName$  
 #imgmainbg.x =243
 #imgmainbg.y =0  
 #imgmainbg.DESTW = ~menuXRes - 233
 #imgmainbg.DESTH = yResVal
 #imgleftmenu.DESTW = 248
 #imgleftmenu.DESTH = yResVal
 #imglogout.x = ~menuXRes - #imglogout.w - 20
 #imglogout.y = 35 * ~factorY
 #lblheading.x = 256
 #lblheading.y = 23 * ~factorY
 
 
 
 dimi yVal
 yVal = START_YVALUE * ~factorY
 �B ~menuYRes = 650 �
 yVal = START_YVALUE * ~factorY
 MENU_GAP=40 * ~factorY
 SUBMENU_GAP=28 * ~factorY
 �D
 
 � i = 0 � 2
 � ~loginAuthority = 1  and i = 1 �  continue
 ctrlName$ = "imgmenu["+i+"]"  
 #{ctrlName$}.y = yVal
 
 arrMousePos(noLeftMenuCtrls,0) = #{ctrlName$}.x
 arrMousePos(noLeftMenuCtrls,1) = yVal
 arrMousePos(noLeftMenuCtrls,2) = #{ctrlName$}.x + #{ctrlName$}.destw
 arrMousePos(noLeftMenuCtrls,3) = yVal + 35
 noLeftMenuCtrls++
 
 ctrlName$ = "lblmenuval["+i+"]"  
 #{ctrlName$}.y = yVal+7
 yVal += MENU_GAP
 
 �  
 
 SUBMENU_GAP = SUBMENU_GAP * ~factorY  
 yVal = #lblmenuval[2].y + #imgmenu[2].desth + SUBMENU_GAP  
 
 � i = 0 � MAXSUBMENU-1  
 ctrlName$ = "rosubmenu["+i+"]"
 #{ctrlName$}.y = yVal
 arrMousePos(noLeftMenuCtrls,0) = #{ctrlName$}.x
 arrMousePos(noLeftMenuCtrls,1) = yVal
 arrMousePos(noLeftMenuCtrls,2) = #{ctrlName$}.x + #{ctrlName$}.w
 arrMousePos(noLeftMenuCtrls,3) = yVal + #{ctrlName$}.h
 noLeftMenuCtrls++ 
 
 �B dmvaEnable <= 0 and i = 2 �  
 #{ctrlName$}.hidden = 1 
 �C
 yVal += SUBMENU_GAP
 �D  
 �
 
 � i = 3 � 4
 ctrlName$ = "imgmenu["+i+"]"  
 #{ctrlName$}.y = yVal
 
 arrMousePos(noLeftMenuCtrls,0) = #{ctrlName$}.x
 arrMousePos(noLeftMenuCtrls,1) = yVal
 arrMousePos(noLeftMenuCtrls,2) = #{ctrlName$}.x + #{ctrlName$}.destw
 arrMousePos(noLeftMenuCtrls,3) = yVal + 35  
 noLeftMenuCtrls++
 
 ctrlName$ = "lblmenuval["+i+"]"  
 #{ctrlName$}.y = yVal+7
 yVal += MENU_GAP  
 �  
 
 noLeftMenuCtrls--
 � i = 0 � noLeftMenuCtrls
 � arrMousePos(i,0);arrMousePos(i,1);arrMousePos(i,2);arrMousePos(i,3) 
 �

�F


/***********************************************************

 * Description: Assign selected image � the selected image
 * Created by:Vimala On 2009-05-19 11:53:33
 * History: 
 ***********************************************************/
�h imgmenu_focus
 
 

 dims ctrlName$
 ctrlName$ = �(()
 
 �B ~changeFlag = 0  � 
 
 #imgselected.hidden = 0  
 #imgselected.x = #{ctrlName$}.x
 � #imgselected.x
 #imgselected.y = #{ctrlName$}.y  
 � #imgselected.y
 #imgselected.destw = #{ctrlName$}.destw+10
 � ctrlName$
 � #imgselected.destw
 #imgselected.desth = #rosubmenu.h +20
 � #imgselected.desth
 �D
 ��(0)
�F  

/***********************************************************

 * Description: Assign selected image � the selected readonly box
 * Created by: Vimala On 2009-05-19 11:56:05
 * History: 
 ***********************************************************/
�h rosubmenu_Focus  
 
 dims ctrlName$
 ctrlName$ = �(()
 
 �B ~changeFlag = 0  �  
 #imgselected.hidden = 0
 #imgselected.x = #{ctrlName$}.x
 #imgselected.y = #{ctrlName$}.y-10
 #imgselected.destw = #{ctrlName$}.w+17
 #imgselected.desth = #rosubmenu.h +20
 �D
 ��(0)
�F

/***********************************************************

 * Description: � this � � load the menu captions
 * from menuCaptions.lan
 
 * Created by: vimala On 2009-05-19 12:02:04
 ***********************************************************/
�h loadMenuCaptions() 
 dimi i,j
 dims ctrlName$
 loadarray(~menuArray$,"menuCaptions.lan")
 
 � i = 0 � MAXMAINMENU-1
 ctrlName$ = "lblmenuval["+i+"]"
 #{ctrlName$}$ = ~menuArray$(i)
 � "~menuArray$(i)";~menuArray$(i)
 �
 
 � j = 0 � MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 #{ctrlName$}$ = ~menuArray$(i)
 i++
 �  
 
�F




/***********************************************************

 * Description: Loads the selected screen
 * Created by: vimala On 2009-05-19 12:03:02
 * History: 
 ***********************************************************/
�h imgmenu_Click
 
 
 
 �B canReload = 1 �  
 dims ctrlName$
 dimi arrPos
 
 ctrlName$ = �(()
 arrPos = getctrlNo(ctrlName$) 
 � �+() = ~urlMainArray$(arrPos) � �
 � chkValueMismatch()
 �B ~changeFlag = 1  � 
 ~mousemoveflag=1
 �("Do you want to save the changes",3)
 ~mousemoveflag=0
 �B �u()=1 �  
 ��(0) 
 ~UrlToLoad$ = ~urlMainArray$(arrPos)
 savePage() 
 � ~changeFlag = 0  � �_(~urlMainArray$(arrPos)) 
 �C 
 ~changeFlag = 0
 �_(~urlMainArray$(arrPos))
 �D 
 �C
 �_(~urlMainArray$(arrPos))
 �D
 �D
 
�F


/***********************************************************

 * Description: � assignOffImages � � assign OFF image.
 * Assign selected image � the control.
 * 
 * Params:
 * dims ctrlName$: String - Name of the control.
 * Created by: vimala On 2009-05-19 12:03:33
 * History: 
 ***********************************************************/
�h assignSelectedImage(dims ctrlName$) 
 dimi arrPos
 
 assignOffImages()

 arrPos = getctrlNo(ctrlName$)
 #{ctrlName$}.src$ = ~menuOnImg$(arrPos)
 
 �B arrPos = 2 �
 showSubMenu(0,1)
 �d("rosubmenu")
 rosubmenu_Click
 �C 
 showSubMenu(1,0) 
 �D 
 
 #lblheading$=~menuArray$(arrPos)
 
�F


/***********************************************************

 * Description: � this � � get the control array index.
 * Params:
 * dims ctrlName$: String - Name of the control
 * Created by: vimala On 2009-05-19 12:11:34
 * History: 
 ***********************************************************/
� getctrlNo(dims ctrlName$)
 
 dimi pos
 pos = �&(ctrlName$,"[")
 � pos = -1 � � 0
 ctrlName$ = ��(ctrlName$,"]","")
 pos = �(��(ctrlName$,1))
 � pos  
 
�F


/***********************************************************

 * Description: � this � � assign OFF image � all 
 * the image control.
 * Created by: vimala On 2009-05-19 12:12:31
 * History: 
 ***********************************************************/
�h assignOffImages()
 
 dimi i
 dims ctrlName$
 
 � i = 0 � MAXMAINMENU-1
 ctrlName$ = "imgmenu["+i+"]"  
 #{ctrlName$}.src$ = menuOffImg$(i)
 �
 
�F

/***********************************************************

 * Description: � this � � show or hide the settings �h menu.
 * Params:

 * 1 - Hide �h menu  
 * dimi selFlag: Numeric - �B set � 1, sets focus � setting image.
 * Created by: vimala On 2009-05-19 12:13:30
 * History: 
 ***********************************************************/
�h showSubMenu(dimi showFlag,dimi selFlag)
 
 dimi j
 dims ctrlName$
 
 � j = 0 � MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 � dmvaEnable <= 0 and j = 2 � continue  
 #{ctrlName$}.hidden = showFlag  
 �  
 
 � selFlag = 1 � #imgmenu[2].src$ = ~menuOnImg$(2);�d("imgmenu[2]")
 
�F



/***********************************************************

 * Description: Load the selected setting screen
 * Created by: vimala On 2009-05-19 12:17:38
 * History: 
 ***********************************************************/
�h rosubmenu_Click
 ��(0)
 
 
 �B canReload = 1 �  
 dims ctrlName$
 dimi arrPos
 
 ctrlName$ = �(()
 arrPos = getctrlNo(ctrlName$)
 
 � �+() = ~urlSubArray$(arrPos) � �
 � chkValueMismatch()
 �B ~changeFlag = 1 � 
 ~mousemoveflag=1
 �("Do you want to save the changes",3)
 ~mousemoveflag=0
 �B �u()=1 �  
 ��(0) 
 ~UrlToLoad$ = ~urlSubArray$(arrPos)
 savePage() 
 � ~changeFlag = 0  � �_(~urlSubArray$(arrPos)) 
 �C 
 ~changeFlag = 0
 �_(~urlSubArray$(arrPos)) 
 �D 
 �C
 �_(~urlSubArray$(arrPos)) 
 �D
 �D
�F



/***********************************************************

 * Description: set ��
 * Created by: Franklin On 2009-05-19 12:17:38
 * History: 
 ***********************************************************/
�h rosubmenu_blur
 ��(3)
�F

/***********************************************************

 * Description: � assignFGcolor � � set default FG color
 * and change the FG color � the selected setting
 * Created by: vimala On 2009-05-19 12:18:04
 * History: 
 ***********************************************************/
�h selectSubMenu()
 
 dims ctrlName$
 dimi arrPos
 
 assignFGcolor()
 
 ctrlName$ = �(()
 
 arrPos = getctrlNo(ctrlName$)
 
 #{ctrlName$}.fg = 64512
 #{ctrlName$}.selfg = 64512
 #lblheading$=~menuArray$(MAXMAINMENU+arrPos)
 
�F

/***********************************************************

 * Description: � this � � set default FG color.
 * Created by: vimala On 2009-05-19 12:19:30
 * History: 
 ***********************************************************/
�h assignFGcolor()
 
 dimi j
 dims ctrlName$
 
 � j = 0 � MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 #{ctrlName$}.fg = 42228
 #{ctrlName$}.selfg = 42228
 �  
 
�F


/***********************************************************

 * Description: Click on the image label loads the selected screen
 * Created by: vimala On 2009-05-19 12:21:16
 * History: 
 ***********************************************************/
�h lblmenuval_Click  
 � imgmenu_Click
�F



/***********************************************************

 * Description: Hitting ESC key sets focus � � main menu control
 * Params:

 * dimi menuNo: Numeric - currently selected menu number
 * Created by: vimala On 2009-05-19 12:22:24
 * History: 
 ***********************************************************/
�h setLeftMenuFocus(dimi key,dimi menuNo) 
 
 dims ctrlName$
 
 �B key = 15 �
 menuNo++
 ctrlName$ = "imgmenu["+menuNo+"]"
 �d(ctrlName$) 
 ��(0)
 �D

�F



/***********************************************************

 * Description: Hitting ESC key sets focus � � �h menu control
 * Params:

 * dimi menuNo: Numeric - currently selected menu number
 * Created by: vimala On 2009-05-19 12:23:17
 * History: 
 ***********************************************************/
�h setSubMenuFocus(dimi key,dimi menuNo)
 
 
 dims ctrlName$
 
 �B key = 15 �
 
 �B menuNo = 7 � 
 setLeftMenuFocus(key,2) 
 �C
 menuNo++
 ctrlName$ = "rosubmenu["+menuNo+"]"
 �d(ctrlName$) 
 �D
 ��(0)
 �D
 
�F


/***********************************************************

 * Description: � this � � hide and show 
 * �� menu controls based on user's authority
 * Created by: On 2009-05-17 23:50:13
 * History: 
 ***********************************************************/
�h buildLeftTree  
 
 �B ~loginAuthority = 1 �
 #imgmenu[1].hidden = 1
 #lblmenuval[1].hidden = 1  
 
 �y ~loginAuthority = 2 �
 #imgmenu[1].hidden = 1
 #imgmenu[2].hidden = 1
 #lblmenuval[1].hidden = 1
 #lblmenuval[2].hidden = 1
 #imgmenu[3].hidden = 1
 #imgmenu[4].hidden = 1
 #lblmenuval[3].hidden = 1
 #lblmenuval[4].hidden = 1
 showSubMenu(1,0) 
 noLeftMenuCtrls = 0  
 �C
 #imgmenu[1].hidden = 0
 #imgmenu[2].hidden = 0
 #lblmenuval[1].hidden = 0
 #lblmenuval[2].hidden = 0
 showSubMenu(0,0) 
 �D  
 
 #imgLogo.x = #imgmenu[1].x + 5 
 #imgLogo.y = #imgleftmenu.desth - (70 * ~factorY )
�F


/***********************************************************

 * Description: � this � � re algin control positions
 * Created by: Vimala On 2009-05-18 00:32:20
 * History: 
 ***********************************************************/
�h reAlignMenu()
 dimi j,yVal,SUBMENU_GAP
 dims ctrlName$,prevCtrl$
 #lblmenuval[2].y = #lblmenuval[1].y
 #imgmenu[2].y = #imgmenu[1].y
 SUBMENU_GAP = 35 * ~factorY  
 yVal = #lblmenuval[2].y + #imgmenu[2].desth + SUBMENU_GAP 

 � j = 0  � MAXSUBMENU-1 
 ctrlName$ = "rosubmenu["+j+"]"  
 #{ctrlName$}.y  = yVal
 yVal += SUBMENU_GAP  
 �  

 
 
�F



/***********************************************************

 * Description: Loads the login screen
 * Created by: vimala On 2009-05-19 12:27:07
 * History: 
 ***********************************************************/
�h imgLogout_Click
 �_("!auth.frm") 
�F


/***********************************************************

 * Description: � this � � check whether the control values are modified or not.
 * set ~changeFlag = 1 �B control value modified.
 * 
 * 
 * Params:
 * key: Numeric - Key value
 * Created by: On 2009-06-10 10:32:11
 * History: 
 ***********************************************************/
�h checkForModification(dims ctrlValues$(), dims LabelName$()) 
 ~changeFlag = 0
 dimi i
 � i = 0 � ��(ctrlValues$) 
 � LabelName$(i) = "" or LabelName$(i) = "lblSuccessMessage" � continue
 � LabelName$(i);ctrlValues$(i);#{LabelName$(i)}$ 
 �B ctrlValues$(i) <> #{LabelName$(i)}$ �
 ~changeFlag = 1  
 �E
 �D
 �
�F


/***********************************************************

 * Description: � this � � � control window handle 
 
 * key: Numeric - Key value
 * Created by: vimala  On 2009-06-10 10:32:11
 * History: 
 ***********************************************************/
�h getFocus() 
 dimi focusHandle  
 dimi hwnd  
 focusHandle = �V("user32.dll") 
 hwnd = �(��("*hwnd")) 
 CallLibFuncPas(focusHandle,"SetFocus",hwnd) 
 �W(focusHandle) 
�F  


�h ChangeMouseCursor(X, Y)
 dimi Cnt, lHandle, blnChnageCursor
 � Cnt = 0 � noLeftMenuCtrls
 �B (X >= arrMousePos(Cnt, 0) and X <= arrMousePos(Cnt, 2)) and (Y >= arrMousePos(Cnt, 1) and Y <= arrMousePos(Cnt, 3)) �
 blnChnageCursor = 1
 �
 �D
 �
 �B blnChnageCursor = 1 �
 lHandle = LoadCursorA(0, IDC_HAND)
 �C
 lHandle = LoadCursorA(0, IDC_ARROW) 
 �D
 �B (lHandle > 0) � 
 SetCursor(lHandle)
 �D
�F







 
 

option(4+1)

Dims stream$(3),rtspUrl$(3)
Dimi flagAudio=1  
dimi flagSnap=0  
Dims alarmstatus$ = "0000"  
dims oldAlarmStaus$  
�(1000) 

dimi noofctrl  
noofctrl = �~()-25  
dims LabelName$(noofctrl) 
dimi XPos(noofctrl) 
dimi YPos(noofctrl) 
dimi Wdh(noofctrl) 
dimi height(noofctrl) 
dimi displayallstreams = 0  
dimi sleeptime = 1000  
dimi stream = 0  
dimi rule

LabelName$(0) = "ddStream" : XPos(0) = 372: YPos(0) = 70: Wdh(0) = 111: Height(0) = -1
LabelName$(1) = "chkDispallstreams" : XPos(1) = 259: YPos(1) = 141: Wdh(1) = 146: Height(1) = 14
LabelName$(2) = "ddExample" : XPos(2) = 856: YPos(2) = 70: Wdh(2) = 111: Height(2) = -1
LabelName$(3) = "imgsnap" : XPos(3) = 524: YPos(3) = 68: Wdh(3) = 40: Height(3) = 40
LabelName$(4) = "imgalarm" : XPos(4) = 575: YPos(4) = 68: Wdh(4) = 40: Height(4) = 40
LabelName$(5) = "imgrecord" : XPos(5) = 628: YPos(5) = 68: Wdh(5) = 40: Height(5) = 40
LabelName$(6) = "imgaudio" : XPos(6) = 682: YPos(6) = 68: Wdh(6) = 40: Height(6) = 40
LabelName$(7) = "gdobg1" : XPos(7) = 252: YPos(7) = 255: Wdh(7) = 480: Height(7) = 270
LabelName$(8) = "gdobg1[1]" : XPos(8) = 750: YPos(8) = 397: Wdh(8) = 240: Height(8) = 135
LabelName$(9) = "gdobg1[2]" : XPos(9) = 750: YPos(9) = 240: Wdh(9) = 240: Height(9) = 135
LabelName$(10) = "lblvideo3" : XPos(10) = 394: YPos(10) = 397: Wdh(10) = 164: Height(10) = 21
LabelName$(11) = "lblvideo2" : XPos(11) = 830: YPos(11) = 308: Wdh(11) = 80: Height(11) = 21
LabelName$(12) = "lblvideo1" : XPos(12) = 830: YPos(12) = 450: Wdh(12) = 80: Height(12) = 21
LabelName$(13) = "lblSelectStream" : XPos(13) = 259: YPos(13) = 70: Wdh(13) = 105: Height(13) = 14
LabelName$(14) = "lblExample" : XPos(14) = 785: YPos(14) = 70: Wdh(14) = 63: Height(14) = 14
LabelName$(15) = "frmSnap" : XPos(15) = 451: YPos(15) = 114: Wdh(15) = 398: Height(15) = 70
LabelName$(16) = "lblCurStream3" : XPos(16) = 750: YPos(16) = 397: Wdh(16) = 150: Height(16) = 14
LabelName$(17) = "lblCurStream2" : XPos(17) = 750: YPos(17) = 222: Wdh(17) = 150: Height(17) = 14
LabelName$(18) = "lblCurStream1" : XPos(18) = 259: YPos(18) = 228: Wdh(18) = 150: Height(18) = 14
LabelName$(19) = "imgsdCard" : XPos(19) = 734: YPos(19) = 68: Wdh(19) = 40: Height(19) = 40
LabelName$(20) = "lblSnapText" : XPos(20) = 467: YPos(20) = 127: Wdh(20) = 107: Height(20) = 14
LabelName$(21) = "txtSnapText" : XPos(21) = 564: YPos(21) = 128: Wdh(21) = 197: Height(21) = -1
LabelName$(22) = "optStorage" : XPos(22) = 564: YPos(22) = 158: Wdh(22) = 77: Height(22) = 14
LabelName$(23) = "optStorage[1]" : XPos(23) = 645: YPos(23) = 158: Wdh(23) = 56: Height(23) = 14
LabelName$(24) = "optStorage[2]" : XPos(24) = 708: YPos(24) = 158: Wdh(24) = 68: Height(24) = 14
LabelName$(25) = "btnOk" : XPos(25) = 778: YPos(25) = 126: Wdh(25) = 57: Height(25) = 20
LabelName$(26) = "btnCancel" : XPos(26) = 778: YPos(26) = 157: Wdh(26) = 57: Height(26) = 20
LabelName$(27) = "lblSaveTo" : XPos(27) = 467: YPos(27) = 158: Wdh(27) = 80: Height(27) = 14
dimi democfg  
dimi audiomode  
� loadStreamValues() 
��(3)
assignSelectedImage("imgmenu")
�d("imgmenu")
�d("chkdispallstreams")
#chkdispallstreams.disabled = 1
dimi totActiveGDO  
Dims prvscreen1$,prvscreen2$,prvscreen3$,prvscreen4$,prvScreen5$  
dimi toolTipPaintFlag = 0
dimi blnCanGetAlarmStatus
dimi selExampleVal
dimi saveSuccess = 0  
dimi animateCount = 0  
dims error$ = ""  
dimi isAdvancedClicked = 0  
dimi tempY,tempX  
dimi audiostatusflag = 0  
dims dispstr$  
�

/***********************************************************

 * Description: Fetch values � keyword from ini.htm.
 * Adjust all the controls based on screen resolution.
 * Fetch stream names and rtsp urls.
 * Create three video player � display all streams based on the aspect ratio
 
 * Created by: Franklin  On 2009-05-15 05:54:01
 ***********************************************************/
�h form_load
 dimi retVal
 retVal = loadIniValues()
 
 �B ~maxPropIndex = 0 � 
 �("Unable to load initial values.")
 �_("!auth.frm")
 �D
 
 dimi gdoCurWidth, gdoCurHeight, gdoCurX, gdoCurY
 dimi drpCount
 dimi availableW
 
 � displayControls(LabelName$,XPos,YPos,Wdh,height)
 
 � loadStreamValues() 
 
 #frmSnap.w = (#btncancel.x+#btncancel.w) - #frmsnap.x + 10
 #frmSnap.h = (#btncancel.y +#btncancel.h)- #frmsnap.y + 10
 
 #lblheading$ = "Live Video > All Streams"
 
 dimi xRatio1,yRatio1,xRatio2,yRatio2,xRatio3,yRatio3
 
 loadStreamDetails(stream$,rtspUrl$) 
 � addItemsToDropDown("ddstream", stream$, -1) 
 
 drpCount = #ddstream.itemcount
 
 �B drpCount = 1 �
 �(0)
 �_("!liveVideo.frm&isINIValue=1")
 �D  
 
 calVideoDisplayRatio(#ddstream.itemlabel$(0),xRatio1,yRatio1) 
 
 availableW = ~menuXRes - #imgleftmenu.w - 40
 
 gdoCurX = GDO_X1 
 gdoCurY = GDO_Y1 * ~factorY  
 availableW /= 2  
 
 gdoCurWidth = availableW 
 gdoCurHeight = (#imgmainbg.DESTH -25) - gdoCurY  
 checkAspectRatio(gdoCurWidth, gdoCurHeight,xRatio1,yRatio1) 
 createGDOControl("gdoVideo1", gdoCurX, gdoCurY, gdoCurWidth, gdoCurHeight)
 #lblcurstream1.x=gdoCurX
 #lblcurstream1.y=gdoCurY-(#lblcurstream1.h)-10  
 #gdobg1[0].x = gdoCurX-1
 #gdobg1[0].w = gdoCurWidth 
 #gdobg1[0].h = gdoCurHeight  
 gdoCurX = GDO_X2 * ~factorX
 gdoCurY = GDO_Y2 * ~factorY
 gdoCurWidth  = GDO_W2 * ~factorX
 gdoCurHeight = GDO_H2 * ~factorY
 � drpCount>=2 � calVideoDisplayRatio(#ddstream.itemlabel$(1),xRatio2,yRatio2) 
 checkAspectRatio(gdoCurWidth,gdoCurHeight,xRatio2,yRatio2)
 createGDOControl("gdoVideo2", gdoCurX, gdoCurY, gdoCurWidth, gdoCurHeight) 
 #gdobg1[2].x = gdoCurX-1
 #gdobg1[2].w = gdoCurWidth 
 #gdobg1[2].h = gdoCurHeight  
 #lblcurstream2.x=gdoCurX
 #lblcurstream2.y=gdoCurY-(#lblcurstream2.h)-10
 
 gdoCurX = GDO_X3 * ~factorX
 gdoCurY = GDO_Y3 * ~factorY
 gdoCurWidth  = 240 * ~factorX
 gdoCurHeight = GDO_H3 * ~factorY
 � drpCount=3 � calVideoDisplayRatio(#ddstream.itemlabel$(2),xRatio3,yRatio3) 
 checkAspectRatio(gdoCurWidth, gdoCurHeight,xRatio3,yRatio3)
 gdoCurY=gdoCurY+10
 #gdobg1[1].y=gdoCurY-1
 createGDOControl("gdoVideo3", gdoCurX, gdoCurY, gdoCurWidth, gdoCurHeight)
 #gdobg1[1].x = gdoCurX-1
 #gdobg1[1].w = gdoCurWidth 
 #gdobg1[1].h = gdoCurHeight  
 #lblcurstream3.x=gdoCurX
 #lblcurstream3.y=gdoCurY-(#lblcurstream3.h)-10
 �B ~loginAuthority = 0 or ~loginAuthority = 1 �  
 showSubMenu(0,0) 
 �D
 
 �B flagAudio=1 � 
 #imgaudio.src$="!audio_on.jpg"
 �C
 #imgaudio.src$="!audio_off.jpg"
 �D
 
 
 �B drpCount = 2 �  
 dimi startPos,endPos
 dims streamRes1$,streamRes2$,streamVal$
 streamVal$ = #ddstream.itemlabel$(0)
 startPos = �&(streamVal$,"(")
 endPos = �&(streamVal$,")")
 streamRes1$ = �%(streamVal$,startPos+1,endPos-startPos-1)
 streamVal$ = #ddstream.itemlabel$(1)
 startPos = �&(streamVal$,"(")
 endPos = �&(streamVal$,")")
 streamRes2$ = �%(streamVal$,startPos+1,endPos-startPos-1)
 � streamRes1$;streamRes2$
 �B streamRes1$ = streamRes2$ �  
 #gdoVideo2.w = #gdobg1[0].w
 #gdoVideo2.h = #gdobg1[0].h
 #gdoVideo2.y = #gdobg1[0].y
 #gdoVideo2.x = #gdobg1[0].x + #gdobg1[0].w + 20
 #gdobg1[2].w = #gdobg1[0].w
 #gdobg1[2].h = #gdobg1[0].h
 #gdobg1[2].y = #gdobg1[0].y
 #gdobg1[2].x = #gdobg1[0].x + #gdobg1[0].w + 20
 #lblcurstream2.x=#gdobg1[2].x
 #lblcurstream2.y=#gdobg1[2].y -(#lblcurstream2.h)-10  
 #lblvideo1.x = #gdobg1[1].x  
 #lblvideo2.x = #gdobg1[2].x  
 �D 
 �D
 
 dims sdInsertVal$
 dimi findPos,sdInsert
 
 
 retVal = getSDCardValue(sdInsertVal$)
 
 �B retVal > 0  �
 findPos = �&(sdInsertVal$,"sdinsert=")
 findPos += � ("sdinsert=")
 sdInsert = �(�%(sdInsertVal$,findPos)) 
 �D
 
 �B sdInsert = 0 �
 #imgsdcard.hidden = 1
 �D
 
 blnCanGetAlarmStatus = 1  
�F

/***********************************************************

 * Description: �1 Gray image � storage options �B click snap is selected.

 * Created by: Franklin On 2009-05-14 11:43:56
 ***********************************************************/
�h form_paint()
 �B #frmSnap.hidden=0  �
 putimage2(~optImage$,#optStorage[1].x,#optStorage[1].y,5,0,0) 
 putimage2(~optImage$,#optStorage[2].x,#optStorage[2].y,5,0,0) 
 �D
�F


/***********************************************************

 * Description: Play all the rtsp urls in video player 
 
 * Created by:Jacques Franklin  On 2009-03-13 13:02:28

 ***********************************************************/
�h Form_complete
 ~wait = 0  
 � disp_streams()
 � getPreviousScreen()
 toolTipPaintFlag = 1
 
 SETOSVAR("*FLUSHEVENTS", "") // Added By Rajan
�F

/***********************************************************

 * Description: � store the previous screen and repaint the screen after showing 
 the tooltip

 * Created by: Franklin Jacques.K  On 2009-09-23 12:59:03
 ***********************************************************/
�h getPreviousScreen
 ��(prvScreen1$, #imgsnap.x+10, #imgsnap.y+TOOLTIP_HEIGHT+30, TOOLTIP_WIDTH1+10, TOOLTIP_HEIGHT+10)
 ��(prvScreen2$, #imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2+10,TOOLTIP_HEIGHT+10)
 ��(prvScreen3$, #imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3+10,TOOLTIP_HEIGHT+10)
 ��(prvScreen4$, #imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3+10,TOOLTIP_HEIGHT+10)
 ��(prvScreen5$, #imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4+10,TOOLTIP_HEIGHT+10)
�F


/***********************************************************

 * Description: � set the URL � the video player GDO Control
 rtspUrl$() - array : Hold all available rtsp stream values
 
 * Created by: Franklin Jacques  On 2009-07-31 19:01:44
 ***********************************************************/
�h disp_streams()
 ~wait = 1
 dims value$
 dimi ret,a
 totActiveGDO = #ddstream.itemcount
 ret = totActiveGDO
 
 �B ret = 1 �
 
 �B stream = 1 �
 displayallstreams = 1
 a = #gdovideo1.stop(1)
 value$ = rtspUrl$(0) 
 a = #gdovideo1.play(value$)
 � hideControl(0,1,1) 
 #lblcurstream1$=#ddstream.itemlabel$(0) 
 �D
 #lblcurstream1.hidden=0
 #lblcurstream2.hidden=1
 #lblcurstream3.hidden=1  
 �y ret = 2 �
 
 �B stream = 1 �
 value$ = rtspUrl$(0) 
 a = #gdovideo1.play(value$)
 � hideControl(0,1,1) 
 �y stream = 2 �
 displayallstreams = 1
 value$ = rtspUrl$(1) 
 a = #gdovideo2.play(value$)
 � hideControl(0,0,1)
 �D
 #lblcurstream1$=#ddstream.itemlabel$(0)
 #lblcurstream2$=#ddstream.itemlabel$(1)
 #lblcurstream1.hidden=0
 #lblcurstream2.hidden=0
 #lblcurstream3.hidden=1
 �y ret = 3 �
 
 �B stream = 1 �
 value$ = rtspUrl$(0) 
 a = #gdovideo1.play(value$)
 � hideControl(0,1,1) 
 �y stream = 2 �
 value$ = rtspUrl$(1) 
 a = #gdovideo2.play(value$)
 � hideControl(0,0,1)
 �y stream = 3 �
 displayallstreams = 1
 value$ = rtspUrl$(2) 
 a = #gdovideo3.play(value$)
 � hideControl(0,0,0)
 �D  
 
 #lblcurstream1$=#ddstream.itemlabel$(0)
 #lblcurstream2$=#ddstream.itemlabel$(1)
 #lblcurstream3$=#ddstream.itemlabel$(2)
 #lblcurstream1.hidden=0
 #lblcurstream2.hidden=0
 #lblcurstream3.hidden=0
 �D
�F


/***********************************************************

 * Description: � hide the GDO controls 
 
 * Params:


 * dimi ctrl3 : Numeric - value � be assigned � the 
 * Created by: On 2009-07-30 17:34:52
 ***********************************************************/
�h hideControl(dimi ctrl1, dimi ctrl2, dimi ctrl3 ) 
 #gdovideo1.hidden = ctrl1
 #gdovideo2.hidden = ctrl2
 #gdovideo3.hidden = ctrl3
 #gdobg1.hidden = ctrl1
 #gdobg1[1].hidden = ctrl3
 #gdobg1[2].hidden = ctrl2
 #lblvideo1.hidden = ctrl3
 #lblvideo2.hidden = ctrl2
 #lblvideo3.hidden = ctrl1  
�F

/***********************************************************

 * Description: Enable / Disable audio based on audio flag

 * Created by: Franklin On 2009-04-09 15:28:30
 ***********************************************************/
�h setAudioControl()
 �B flagAudio=1 �
 #gdoVideo1.Audio = 1
 �y flagAudio=0 �
 #gdoVideo1.Audio = 0
 �D
�F


/***********************************************************

 * Description: 
 * � load the liveVideo form when the check box is unchecked


 * Created by: Franklin On 2009-03-17 20:05:08
 ***********************************************************/
�h chkDispallstreams_Click  
 �B canReload = 1 �
 � ~wait <1 � � 
 �_("!liveVideo.frm&isINIValue=1") 
 �C 
 #chkDispallstreams.checked = 1
 �D
�F


/***********************************************************

 * Description: Load the stream name/Example into drop down box.
 * Load click snap user input values
 
 * Created by: Partha Sarathi.K On 2009-03-17 18:43:53
 ***********************************************************/
�h loadStreamValues()
 
 dims clicksnapfilename$,democfgname$,ddValue$
 Dimi audioenable,clicksnapstorage,frecognition
 dimi ret  
 
 
 
 ret = getLiveVideoOptions(clicksnapfilename$,democfgname$,audioenable,_
 clicksnapstorage,democfg,audiomode)
 
 �B ret = -1 �
 �("unable to fetch values")
 �
 �D
 
 flagAudio=audioenable
 � flagAudio < 0 � flagAudio = 0
 
 
 �<(ddValue$,democfgname$,";")
 � addItemsToDropDown("ddExample", ddValue$, democfg)
 #txtSnapText$=clicksnapfilename$
 #optStorage$=clicksnapstorage
�F


/***********************************************************

 * Description:� this � � � control window handle 
 * 
 * Params:

 * y: Numeric - Y Position
 * Created by:Jacques Franklin  On 2009-03-11 18:17:58
 * History: 
 ***********************************************************/
�h form_Mouseclick(x,y)
 �B audioStatusFlag = 1 �  
 �0(2)
 �D
 � getFocus() 
�F

/**************************************************************************

 * Description: Display Tool tip �B click snap is not enabled
 * 
 * Params:

 * y: Numeric - Y Position
 * Created by:Jacques Franklin  On 2009-03-13 14:58:09

 ***************************************************************************/
�h form_mousemove(x,y)
 � flagSnap=0 � � toolTip_mouseOver(x,y)
 ChangeMouseCursor(x, y)
 �0(2)
�F


/***********************************************************

 * Description: Displays tool tip � the header icons
 * 
 * Params:

 * y: Numeric - Mouse move y value
 * Created by:Jacques Franklin  On 2009-09-23 11:45:37
 ***********************************************************/
�h toolTip_mouseOver(x,y)
 �B x>=#imgsnap.x and x<=(#imgsnap.x+#imgsnap.w) and y>=#imgsnap.y and y<=(#imgsnap.y+#imgsnap.h) �  
 �[(#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH1,TOOLTIP_HEIGHT,1,1,DISPLAY_REGION_BG,DISPLAY_REGION_BG)
 �^(#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,"Snapshot",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT) 
 �1(#imgsnap.x+10, #imgsnap.y+TOOLTIP_HEIGHT+30, TOOLTIP_WIDTH1, TOOLTIP_HEIGHT)
 �y x>=#imgalarm.x and x<=(#imgalarm.x+#imgalarm.w) and y>=#imgalarm.y and y<=(#imgalarm.y+#imgalarm.h) � 
 �[(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2,TOOLTIP_HEIGHT,1,1,DISPLAY_REGION_BG,DISPLAY_REGION_BG)
 �^(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,"Alarm Status",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
 �1(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2,TOOLTIP_HEIGHT)
 �y x>=#imgrecord.x and x<=(#imgrecord.x+#imgrecord.w) and y>=#imgrecord.y and y<=(#imgrecord.y+#imgrecord.h) �
 �[(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT,1,1,DISPLAY_REGION_BG,DISPLAY_REGION_BG)
 �^(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,"Recording Status",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
 �1(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT)
 �y x>=#imgaudio.x and x<=(#imgaudio.x+#imgaudio.w) and y>=#imgaudio.y and y<=(#imgaudio.y+#imgaudio.h) �
 �[(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT,1,1,DISPLAY_REGION_BG,DISPLAY_REGION_BG)
 �^(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,"Toggle Audio",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
 �1(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT)
 �y #imgsdcard.hidden = 0 and x>=#imgsdcard.x and x<=(#imgsdcard.x+#imgsdcard.w) and y>=#imgsdcard.y and y<=(#imgsdcard.y+#imgsdcard.h) �  
 �[(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4,TOOLTIP_HEIGHT,1,1,DISPLAY_REGION_BG,DISPLAY_REGION_BG)
 �^(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,"SD Card",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
 �1(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4,TOOLTIP_HEIGHT)
 �C
 �B toolTipPaintFlag = 1 �  
 ��(prvScreen1$,#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,5,1)
 ��(prvScreen2$,#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,5,1)
 ��(prvScreen3$,#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,5,1)
 ��(prvScreen4$,#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,5,1)
 ��(prvScreen5$,#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,5,1)
 �1()
 �D
 �D 

�F

/***********************************************************

 * Description: � get the alarmstatus and display the 
 alarm status
 � set wait flag when switching between forms
 
 * Method: getAlarmStatus()
 displayAlarmStatus()

 * Created by: Franklin  On 2009-03-13 17:03:05
 ***********************************************************/
�h form_timer
 �B displayallstreams = 0 �
 stream++
 � disp_streams()
 �()
 �C
 ~wait = 2
 �D
 
 �B ~wait >= 2 �
 � ~wait
 #chkdispallstreams.disabled = 0  
 �D
 
 �B blnCanGetAlarmStatus = 1 �
 oldAlarmStaus$ = alarmstatus$
 getAlarmStatus(alarmstatus$)
 blnCanGetAlarmStatus = 0
 �D
 
 �B canReload = 0 �
 �B animateCount <= ~reLoadTime �
 animateCount ++
 �B audioStatusFlag = 1 �
 dispstr$ = "Updating"
 �C 
 dispstr$ = "Loading"
 �D  
 animateLabel("lblvideo3",dispstr$) 
 �C
 � displaySaveStatus(saveSuccess)
 �D
 �D
�F

/***********************************************************

 * Description: Based on the alarm status display the record and alarm status.

 * Created by: Franklin On 2009-03-18 17:17:17
 * History: Modified by Partha Sarathi.K
 ***********************************************************/
�h displayAlarmStatus() 
 dims Tempstatus$
 dimi AlarmData
 tempStatus$ = "0x" + alarmstatus$
 alarmData = StrToInt(tempStatus$)
 
 
 
 �B ANDB(alarmData,0x000F) = 0 �
 #imgalarm.src$ = "!alarm_off.jpg"
 �C
 #imgalarm.src$ = "!alarm_on.jpg"
 �D
 
 �B  alarmData >15  �
 #imgrecord.src$ = "!record_1.jpg"
 �C
 #imgrecord.src$ = "!record_2.jpg"
 �D
 
 #imgrecord.paint(1)
 #imgalarm.paint(1)
 
�F


/***********************************************************

 * Description: 
 * � set wait flag before switching between forms  
 Checks entered key value based on the rule set � that user input control
 * 
 * Params:

 * FromMouse : Numeric - char code of the mouse pressed
 * Created by: On 2009-07-16 14:13:53
 * History: 
 ***********************************************************/
�h Form_KeyPress( Key, FromMouse ) 
 �B key = 26 or key = 25 �
 �-(2)
 �C
 �-(0)
 �D
 
 �B Key = 15 �
 � ~wait<=1 � �
 ~wait = 2
 �D
 
 scroll_keypressed(key) 
 dims keypressed$
 keypressed$ = �Q(�,()) 
 � (CheckKey(Key,rule,keypressed$))=1 � �-(2) 
 setLeftMenuFocus(Key,0) 
�F



/***********************************************************

 * Description: 
 * � set the snap image � the image control subsequent
 � the snap flag
 * 
 * Params:
 * Created by: Franklin On 2009-07-16 14:15:31
 * History: 
 ***********************************************************/
�h imgsnap_Click  
 �B canReload = 1 �
 �B flagSnap=1 �
 flagSnap=0
 #frmSnap.hidden=1
 #imgsnap.src$ = "!snap_on.jpg"  
 �d("imgalarm")
 �y flagSnap=0 �
 flagSnap=1  
 #frmSnap.hidden=0  
 #imgsnap.src$ = "!snap_off.jpg"  
 #optStorage[1].disabled = 1  
 #optStorage[2].disabled = 1  
 #optStorage[1].fg=17004  
 #optStorage[1].selfg=17004  
 #optStorage[2].fg=17004  
 #optStorage[2].selfg=17004  
 �d("txtsnaptext")
 �D
 showimages("imgsnap","!snap_on.jpg","!snap_off.jpg")
 �D
�F



/***********************************************************

 * Description: 
 * � set the Audio image � the image control subsequent
 � the audio flag  

 * Created by: Franklin Jacques On 2009-07-16 14:17:18

 ***********************************************************/
�h imgaudio_Click
 
 �B canReload = 1 �
 dimi a  
 � stopPlaying
 audioStatusFlag = 1  
 
 � audiomode
 �B flagAudio=1 �
 flagAudio=0
 setAudioStatus(flagAudio,audiomode)
 � flagAudio;
 �y flagAudio=0 �
 flagAudio=1  
 setAudioStatus(flagAudio,audiomode) 
 �D  
 �B getReloadFlag() = 1 �  
 canReload = 0
 animateCount = 1
 dispstr$ = "Updating"  
 � animateLabel("lblvideo3",dispstr$)
 �C // �B Reload animation is not required
 canReload = 1
 �D  
 showimages("imgaudio","!audio_on.jpg","!audio_off.jpg")
 �B canReload = 1 � 
 saveSuccess = audioStatusFlag
 displaysavestatus(saveSuccess)
 �D
 �D
�F

/***********************************************************

 * Description: � stop all video in video player

 * Created by:Franklin  On 2009-08-04 19:22:57
 ***********************************************************/
�h stopPlaying
 dimi a
 �B totActiveGDO = 1 �
 a = #gdoVideo1.stop(1)
 #gdoVideo1.hidden = 1
 #gdobg1.hidden = 1  
 #gdobg1.hidden = 1
 #gdobg1[1].hidden = 1
 #gdobg1[2].hidden = 1  
 
 �y totActiveGDO = 2 �
 a = #gdoVideo1.stop(1)
 #gdoVideo1.hidden = 1
 a = #gdoVideo2.stop(1)
 #gdoVideo2.hidden = 1
 #gdobg1.hidden = 1
 #gdobg1[1].hidden = 1
 #gdobg1[2].hidden = 1  

 �y totActiveGDO = 3 �
 a = #gdoVideo1.stop(1)
 #gdoVideo1.hidden = 1
 a = #gdoVideo2.stop(1)
 #gdoVideo2.hidden = 1
 a = #gdoVideo3.stop(1)
 #gdoVideo3.hidden = 1
 #gdobg1.hidden = 1
 #gdobg1[1].hidden = 1
 #gdobg1[2].hidden = 1  
 �D
 #gdobg1.hidden = 1
 #lblvideo1.hidden =1
 #lblvideo2.hidden =1
 #lblcurstream3.hidden =1
 #lblcurstream2.hidden =1
 #lblcurstream1.hidden =1
 #lblvideo3.hidden = 0  
 #lblvideo3.x = #imgsnap.x
 #lblvideo3.y = #gdobg1.y 
�F




�h chkDispallstreams_Focus
 ��(1)
�F

�h chkDispallstreams_Blur
 ��(3)
�F

�h optStorage_Focus
 � �(() = "optStorage" � ��(1) 
�F

�h optStorage_Blur
 ��(3)
�F


/***********************************************************

 * Description: 
 * � hide the frame(frmsnap) and set the snap flag � zero
 * 
 * Created by: Franklin Jacques.K  On 2009-07-16 14:19:37
 ***********************************************************/
�h btnCancel_Click
 flagSnap=0
 #frmSnap.hidden=1
 �d("imgalarm")
 #imgsnap.src$ = "!snap_off.jpg"  
�F



/***********************************************************

 * Description: saves the values enter in snap frame controls.
 * Created by: On 2009-05-20 11:12:33
 * History: 
 ***********************************************************/
�h btnOk_Click
 dimi ret 
 ret = setLiveVideoOptions(#txtSnapText$, #optStorage)
 � imgsnap_Click  
�F


/***********************************************************

 * Description: Server Event Listeners are Notified here.
 * Continuously checks � Alarm and record status.

 * Created by: On 2010-04-30 16:07:59
 ***********************************************************/
�h Form_Notify  
 dimi NotifySrc, NotifyData, ret
 dims Message$, MsgType$, optionValue$(2)
 NotifySrc=getmessage(NotifyData, MsgType$, Message$,"") 
 �B NotifySrc = 41 �  
 � "GNOTIFY_HTTP_DNLD_SUCCESS" + Message$
 ret = �<(optionValue$, Message$ , "=")
 �B ret > 1 �
 alarmStatus$ = �#(optionValue$(1))
 �B �8(oldAlarmStaus$) <> �8(alarmstatus$) �
 � displayAlarmStatus()
 �D
 �D
 blnCanGetAlarmStatus = 1
 �y NotifySrc = 40 or NotifySrc = 45 �
 blnCanGetAlarmStatus = 1
 �D
�F


/***********************************************************

 * Description: Get selected example value

 * Created by: Vimala  On 2010-04-30 16:08:03

 ***********************************************************/
�h ddExample_Click
 selExampleVal = #ddexample.selidx
�F




/***********************************************************

 * Description: On changing the value selected, 
 * display a message and on confirmation should 
 * set the selected value  in the IPNC.
 
 * Created by: Vimala  On 2009-12-15 00:30:25
 ***********************************************************/
�h ddExample_Change  
 �B canReload = 1 �
 � selExampleVal = #ddexample.selidx � �
 dimi a
 � hideControl(1,1,1) 
 #lblcurstream1.hidden = 1
 #lblcurstream2.hidden = 1
 #lblcurstream3.hidden = 1  
 �
 �("This will change the configuration to demo modes selected.\n Do you want to continue?",3)
 
 �B �u() = 1 �
 a = #gdovideo1.stop(1)
 a = #gdovideo2.stop(1)
 a = #gdovideo3.stop(1)
 
 dimi retVal ,i
 retVal = setExampleValue(#ddexample)
 
 tempX = #lblvideo3.x
 tempY = #lblvideo3.y
 saveSuccess = retVal
 
 �B getReloadFlag() = 1 �  
 #lblvideo3.x = #imgsnap.x
 #lblvideo3.y = #gdobg1.y 
 #lblvideo3.hidden = 0 
 canReload = 0
 animateCount = 1
 dispstr$ = "Loading"
 � animateLabel("lblvideo3",dispstr$)
 �C // �B Reload animation is not required
 canReload = 1
 �D
 
 �B canReload = 1 �  //Do the remaining actions after reload animation is done
 � displaySaveStatus(saveSuccess) 
 �D  
 
 �C  
 #ddexample$ = democfg
 �_("!allStreamsVideo.frm&flagaudio="+flagaudio)
 �D  
 �D
 
�F


/***********************************************************

 * Description: � this � � display save status message
 
 * Params:
 * saveStatus: Numeric - Greater � 1 � success ,0 � failure message 
 * Created by: Vimala On 2010-06-25 12:00:34
 * History: 
 ***********************************************************/
�h displaySaveStatus(saveStatus)
 �B audioStatusFlag = 1 �
 audioStatusFlag = 0
 displayallstreams = 0  
 stream = 0  
 � setAudioControl
 � disp_streams
 canReload = 1
 �
 �D  
 �B saveStatus > 0 and audioStatusFlag = 0 �
 �("Modified Demo Mode for camera "+~title$) 
 �y audioStatusFlag = 0 �  
 �("Demo Mode failed for the camera "+~title$) 
 �D  
 �_("!allStreamsVideo.frm&flagaudio="+flagaudio)
�F

/***********************************************************

 * Description: � set focus � the control
 
 * Created by:Franklin On 2010-04-30 16:09:23

 ***********************************************************/
�h txtsnaptext_focus  
 rule = 3
 ��(3)
�F


�h savePage()
 
�F

�h chkValueMismatch() 
 
�F


/***********************************************************

 * Description: Load SD Card explorer screen
 
 * Created by:Vimala On 2010-05-13 10:46:04
 ***********************************************************/
�h imgsdCard_Click
 �B canReload = 1 �
 �_("!SDExplorer.frm") 
 �D
�F
