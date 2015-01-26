/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Ä \ Ä Setting  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/
/*
Ä this page Ä view and set Ä and Ä setting
*/

Ä(1000)
option(4+1)
dimi timerCount

/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Macro Defines Ä menu display and settings page  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/














SETOSVAR("*FLUSHEVENTS", "")




/****************************************************************************
 * gTI IPNC - Common Ä
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights
 * reserved.
 *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT 
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER 
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, 
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) 
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB 
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
Ä generateauthHeader$(dims userName$, dims password$) 
 dims Src$,Dest$ 
 dimi ret
 dims temp$,destTemp$
 
 Src$=userName$+":"+password$  
 Ä "Before encode: " + Src$ + " : " + Dest$
 ret = Encode(Src$,Dest$,1) 
 Ä "Encode ret = "+ret
 temp$ = Src$+":"+~rememberPwd
 ret = Encode(temp$,destTemp$,1) 
 Ä "Write Profile = " + destTemp$
 writeprofile("IPNC",destTemp$)
 generateauthHeader$ = Dest$
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä 
 * calculate width and height Ä the stream aspect ratio

 * Params:
 * byref dimi gdoCurWidth: Numeric - Video Width
 * byref dimi gdoCurHeight: Numeric - Video Height
 * dimi xRatio: Numeric - Stream x ratio
 * dimi yRatio : Numeric - Stream y ratio
 * Created by: On 2009-06-30 14:37:28
 ***********************************************************/
Ä checkAspectRatio(byref dimi gdoCurWidth, byref dimi gdoCurHeight,dimi xRatio,dimi yRatio)
 Ä "gdoCurWidth = " + gdoCurWidth
 Ä "gdoCurHeight = " + gdoCurHeight

 Ä xRatio = 0 Ä xRatio = 1
 Ä yRatio = 0 Ä yRatio = 1

 Dimi TempW, TempH
 TempW = gdoCurHeight * xRatio/yRatio
 ÄB TempW > gdoCurWidth Ä
 TempH = gdoCurWidth * yRatio/xRatio
 gdoCurHeight = TempH
 ÄC
 gdoCurWidth = TempW
 ÄD
 
 gdoCurWidth = gdoCurWidth/16
 gdoCurWidth = gdoCurWidth*16
 
 Ä "gdoCurWidth = " + gdoCurWidth
 Ä "gdoCurHeight = " + gdoCurHeight
ÄF

/***********************************************************

 * Description: Ä this Ä Ä create GDO control(Video player)
 
 * Params:




 * dimi gdoH: Numeric - control h value
 * Created by: On 2009-06-19 12:31:55
 ***********************************************************/
Ä createGDOControl(dims ctrlname$, dimi gdoCurX, dimi gdoCurY, dimi gdoCurWidth, dimi gdoCurHeight)
 createobject("GDO", ctrlname$, " x='" + gdoCurX + "' y='" + gdoCurY + "' w='" + gdoCurWidth + "' h='" + gdoCurHeight +"' ProgID='Gffx.GFFMpeg.1'" )
 #{ctrlName$}.scrollable=0  
ÄF

/***********************************************************

 * Description: 
 * Load data into arraystring and check each key value Ä Validaion 

 * Params:


 * keypressed$: String - Keypressed value
 * Created by: Franklin Jacques On 2009-03-03 17:25:00
 ***********************************************************/
Ä CheckKey(Key,rule,keypressed$)
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
 num=Ä<(charset$,strsplit$,"~")
 
 ÄB Key > 31 and rule > 0 Ä
 Ä Ä&(charset$(rule-1),Ä7(keypressed$))=-1 Ä CheckKey=1
 ÄD
 
ÄF


/***********************************************************

 * Description: 
 * Add the option values into the drop down box.
 * 
 * Params:

 * dims items$: String - Items Ä added Ä the drop down
 * dimi selIndex: Numeric - Drop down selected item.
 * Created by: Partha Sarathi.K  On 2009-02-26 19:20:58
 * Modified by: Vimala On 2009-08-05 11:22:45
 ***********************************************************/
Äh addItemsToDropDown(dims controlName$, dims items$(), dimi selItem)
 
 dimi ret
 dimi index
 dims tempVal$
 
 
 #{controlName$}.removeall()
 
 
 ret = ÄÇ(items$)
 Ä ret < 0 Ä Ä
 Ä index = 0 Ä ret
 ÄB Ä#(items$(index)) <> "" Ä 
 #{controlName$}.additem(index, items$(index))
 ÄD
 Ä
 
 
 Ä selItem == -1 or selItem > ret Ä selItem = 0
 #{controlName$}$ = selItem
 
ÄF



/***********************************************************

 * Description: 
 * Display the controls based on the screen resolution.
 * Set the X and Y pos Ä form controls and it's properties.  

 * Created by:vimala  On 2009-04-03 11:21:04
 ***********************************************************/
Äh displayControls(dims LabelName$(),dimi XPos(),dimi YPos(),dimi Wdh(),dimi height()) 
 dimi i
 
 ÄB  ~menuXRes > 1024 Ä  
 Ä i = 0 Ä ÄÇ(LabelName$) 
 ÄB XPos(i)> 70 Ä 
 XPos(i) = XPos(i) - 20  
 ÄC
 XPos(i) = XPos(i) - 5 
 ÄD 
 Ä
 ÄD
 
 Ä i = 0 Ä ÄÇ(LabelName$) 
 #{LabelName$(i)}.x = XPos(i)* ~factorX  
 #{LabelName$(i)}.y = YPos(i)* ~factorY

 ÄB Ä&(LabelName$(i),"img")= -1 Ä
 #{LabelName$(i)}.w = Wdh(i)* ~factorX
 ÄD
 
 Ä  
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä assign image
 * 
 * Params:


 * dims imageNameOff$: String - OFF image name
 * Created by:Vimala  On 2009-05-19 10:26:24
 * History: 
 ***********************************************************/
Äh showimages(dims ctrlName$,dims imageNameOn$,dims imageNameOff$) 
 ÄB #{ctrlName$}.src$ = imageNameOn$ Ä 
 #{ctrlName$}.src$ = imageNameOff$
 ÄC
 #{ctrlName$}.src$ = imageNameOn$
 ÄD
ÄF


/***********************************************************

 * Description: Ä this Ä Ä add hour,minute and 
 * seconds values Ä drop down
 * Params:

 * dimi maxValue: Numeric - Maximum value Ä be add Ä the drop down.
 * Created by: vimala On 2009-03-17 17:47:16
 * History: 
 ***********************************************************/
Äh loadTimeValues(dims ctrlName$,dimi maxValue) 
 dimi idx
 dims itemVal$
 
 Ä idx = 0 Ä maxValue
 itemVal$ = idx
 Ä idx < 10 Ä itemVal$ = "0" + idx  
 #{ctrlName$}.additem(itemVal$,itemVal$) 
 Ä  
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä calculate aspect ratio Ä the 
 * selected stream
 * Params:


 * dimi byref yRatio: Numeric - returns the calculated Y ratio
 * Created by: On 2009-09-07 12:45:34
 * History: 
 ***********************************************************/
Äh calVideoDisplayRatio(dims selectedStream$,byref dimi xRatio,byref dimi yRatio) 
 dimi gcdValue,startPos,endPos,splitCount,xResVal,yResVal
 dims streamRes$,splitArray$  
 startPos = Ä&(selectedStream$,"(")
 endPos = Ä&(selectedStream$,")")
 streamRes$ = Ä%(selectedStream$,startPos+1,endPos-startPos)
 splitCount = Ä<(splitArray$,streamRes$,"x")
 
 ÄB splitCount = 2 Ä
 xResVal = strtoint(splitArray$(0))
 yResVal = strtoint(splitArray$(1))
 gcdValue = GCD(xResVal,yResVal)
 Ä xResVal/gcdValue
 Ä yResVal/gcdValue  
 xRatio = xResVal/gcdValue
 yRatio = yResVal/gcdValue  
 Ä xRatio
 Ä yRatio
 Ä 1
 ÄD  
 
 Ä 0
ÄF


/***********************************************************

 * Description: Ä this Ä Ä get the selected stream resolution
 * 
 * Params:


 * byref dimi yRes: Numeric - Y Resolution
 * Created by: On 2009-09-23 17:08:49
***********************************************************/
Äh getCurStreamResolution(dims selectedStream$,byref dimi xRes,byref dimi yRes)
 ÄB selectedStream$ <> "" Ä
 dimi startPos,endPos,splitCount,xResVal,yResVal
 dims streamRes$,splitArray$  
 startPos = Ä&(selectedStream$,"(")
 endPos = Ä&(selectedStream$,")")
 streamRes$ = Ä%(selectedStream$,startPos+1,endPos-startPos)
 splitCount = Ä<(splitArray$,streamRes$,"x")
 
 ÄB splitCount = 2 Ä
 xRes = strtoint(splitArray$(0))
 yRes = strtoint(splitArray$(1))
 ÄD
 ÄC 
 xRes = 0
 yRes = 0
 ÄD
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä Ä& GCD of two numbers  
 * 
 * Params:

 * num2: Numeric - Y resolution
 * Created by:S.Vimala On 2009-09-07 10:45:09
 ***********************************************************/
Ä GCD(num1,num2) 
 Ä num1=0 and num2=0 Ä Ä 1
 Ä num2=0 Ä Ä num1
 Ä GCD(num2,num1%num2) 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä get user typein URL from 
 * CommandLine Parameters Passed Ä the GoDB VM
 * 
 * Created by: On 2010-12-20 10:16:33
***********************************************************/
Äh ModifyStreamUrl(byref dims stream$())
 dimi location
 dims tmpvalue$,fin$
 location = Ä&(stream$(1),":",7)
 tmpvalue$ = Ä%(stream$(1),location,Ä (stream$(1))) 
 fin$ = "rtsp://"+Ä%(~camAddPath$,Ä&(~camAddPath$,"//")+2,Ä (~camAddPath$)-8)+tmpvalue$
 stream$(1)=fin$
ÄF

/***********************************************************

 * Description: Ä this Ä Ä get stream names and its rtsp urls
 * 
 * Created by:Vimala  On 2009-09-08 16:02:29
 ***********************************************************/
Äh loadStreamDetails(byref dims stream$(),byref dims rtspUrl$()) 
 
 dims streamName1$,streamName2$,streamName3$
 dims tempStream1$,tempStream2$,tempStream3$
 dimi videocodec,sptCount1,sptCount2,sptCount3
 dimi retVal,i
 
 
 retVal = getStreamDisplayOrder(videocodec,streamName1$,streamName2$,streamName3$)
 Ä streamName1$;streamName2$;streamName3$
 
 ÄB retVal>=0 Ä
 
 sptCount1 = Ä<(tempStream1$,streamName1$,"@")
 sptCount2 = Ä<(tempStream2$,streamName2$,"@")
 sptCount3 = Ä<(tempStream3$,streamName3$,"@")
 Ä ModifyStreamUrl(tempStream1$) 
 Ä ModifyStreamUrl(tempStream2$)
 Ä ModifyStreamUrl(tempStream3$) 
 ÄB videocodec = 0 Ä  
 ÄB sptCount1 = 2 Ä
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 ÄD
 Äy videocodec = 1 Ä
 ÄB sptCount1 = 2 Ä
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 ÄD
 ÄB sptCount2 = 2 Ä
 stream$(1) = tempStream2$(0)
 rtspUrl$(1) = tempStream2$(1)
 ÄD
 Äy videocodec = 2 Ä
 ÄB sptCount1 = 2 Ä
 stream$(0) = tempStream1$(0)
 rtspUrl$(0) = tempStream1$(1)
 ÄD
 ÄB sptCount2 = 2 Ä
 stream$(1) = tempStream2$(0)
 rtspUrl$(1) = tempStream2$(1)
 ÄD
 ÄB sptCount3 = 2 Ä
 stream$(2) = tempStream3$(0)
 rtspUrl$(2) = tempStream3$(1)
 ÄD
 ÄD
 ÄC 
 Ä("Valid stream not available")
 Ä_("!auth.frm")
 ÄD  
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä get camera IP address from 
 * CommandLine Parameters Passed Ä the GoDB VM
 * 
 * Created by: On 2009-09-23 10:16:33
***********************************************************/
Äh GetIPAddress()
 dims cmdline$
 dimi file
 cmdline$ = Äº("*CMDLINE")
 ÄB Ä&(cmdline$, "http:") = 0 Ä
 ~uiType = 2  
 dimi pos1
 pos1 = Ä&(cmdline$, "/", 0, 1)
 ÄB pos1 > 0 Ä
 ~camAddPath$ = Ä%(cmdline$, 0, pos1+1)
 ÄC
 ~camAddPath$ = cmdline$
 ÄD
 ÄC  
 dims ipAddress$
 file = ÄK("ip.txt", 1, 1)
 
 ÄB file <> -1 Ä
 ipAddress$ = ÄL(file)
 ~camAddPath$ = "http://"+Ä#(ipAddress$)+"/"
 ÄO(file)
 ÄD
 
 ÄD
ÄF

/***********************************************************

 * Description: Ä this Ä Ä get user authourity Ä logged in 
 user name.
 
 * Created by: Vimala On 2009-05-17 22:55:12
 ***********************************************************/
Ä getUserAuthority
 dims user$(10)
 dims authority$(10)
 dimi retVal,retVal1,i,sptidx
 dimi retFlag
 
 retVal = getPropValue("user", user$)
 retVal1 = getPropValue("authority", authority$) 
 
 ÄB retVal >= 0  and retVal1 >= 0 Ä  
 dims username$(2)
 dims authname$(2) 
 retFlag = -1
 Ä i = 0 Ä ÄÇ(user$)
 sptidx = Ä<(username$,user$(i),":")
 ÄB sptidx = 2 Ä
 sptidx = Ä<(authname$,authority$(i),":")
 ÄB sptidx = 2 Ä 
 ÄB username$(1) = ~authUserName$ Ä
 ~loginAuthority = Ä(authname$(1))
 retFlag = 0
 Ä 1
 ÄE  
 ÄD
 ÄD
 ÄD
 Ä
 Ä  "retFlag="+ retFlag  
 Ä retFlag = -1 Ä Ä -1  
 Äy retVal = -20 Ä
 ~loginAuthority = 2  
 Ä 1
 ÄC
 Ä -1  
 ÄD  
 
ÄF


/***********************************************************

 * Description: Calculates X,Y position based on the screen resolution
 with screen designed resolution
 
 * Created by: Vimala On 2009-03-23 16:28:40
 ***********************************************************/
Äh calXYVal() 
 dimf designX ,designY
 dimf ~factorX,~factorY
 designX = 1024
 designY = 650  
 ~factorX = ~menuXRes/designX  
 Ä ~factorX <= 1 Ä ~factorX = 1  
 ~factorY = ~menuYRes/designY  
 Ä ~factorY <= 1 Ä ~factorY = 1
 Ä "designX: "; designX; "~menuXRes: "; ~menuXRes; "  ~factorX = " + Ä$("10.2",~factorX)
 Ä "designY: "; designY; "~menuYRes: "; ~menuYRes; "  ~factorY = " + Ä$("10.2",~factorY)
ÄF

/***********************************************************

 * Description:Ä this Ä Ä animate displayMsg with dots
 
 * Params:

 * dims displayMsg$: String - Message string Ä be animated
 * Created by:Vimala  On 2010-04-13 18:33:39
 ***********************************************************/
Äh animateLabel(dims ctrlName$, dims displayMsg$) 
 dims tempMsg$
 timerCount++
 Ä timerCount > 4  Ä timerCount=1
 ÄB timerCount = 1 Ä 
 tempMsg$ = displayMsg$ + " . "  
 Äy timerCount = 2 Ä
 tempMsg$ = displayMsg$ + " . ."
 Äy timerCount = 3 Ä  
 tempMsg$ = displayMsg$ + " . . ." 
 Äy timerCount = 4 Ä  
 tempMsg$ = displayMsg$ + " . . . ." 
 ÄD
 
 #{ctrlName$}$ = tempMsg$
 
 Ä() 
ÄF


/***********************************************************

 * Description: 
 * 
 * 
 * Params:
 * dims streamName$: String - 
 * Created by: On 2010-07-06 15:25:29
 * History: Karthi on 04-Oct-10
 ***********************************************************/
Ä checkForStreamRes(dims streamName$)
 checkForStreamRes = 0
 dimi xRes,yRes
 getCurStreamResolution(streamName$,xRes,yRes)
 
 ÄB streamName$ = "JPEG(2592x1920)" Ä
 ÄB xRes > 2048 or yRes > 2048 Ä
 checkForStreamRes = 1
 ÄD
 ÄD
 
ÄF

/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Function.inc  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB  *
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
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/



 
Ä cameraKeywords$(10000)
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
/*Ä/Ä Setting*/
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
~iniProperties$()- String array: Holds all the camera keywords required Ä GUI
~iniPropValues$ - String array: Holds keyword values which is fetched from IPNC
~errorKeywords$ - String : holds all the failure keywords


Common Methods :
 * chkRetStatusAndUpdate$(dims responseStaus$,dims propName$(),dims propValue$()) 
 - Parse the response string Ä identify the failure keywords
 - ÄB response is not "ok" Ä any keyword Ä its a failure keyword
 * Ä updateLatestValues(propName$,propValue$)
 - Ä this Ä Ä Ä the modified value in ~iniPropValues$ array  
 
*/
 

/***********************************************************

 * Description: Get drop down values from camera  * 
 * Returns 0 Ä Success; -1 failure

 * Params:











 * Created by: vimala On 2009-05-08 13:55:29
 ***********************************************************/
Ä getcameraSettingOptions(byref dims whiteBalance$(), byref dims exposureCtrl$(), _
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
 
 ÄB retVal = 0 Ä
 
 Ä idx= 0 Ä ÄÇ(tempVal$)
 
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount>0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä get camera name.
 
 * Created by: Vimala On 2009-03-10 12:42:41
 ***********************************************************/
Ä getTitle$() 
 dims varName$(1) = ("title$")
 dims propName$(1) = ("gtitle")
 dims tempVal$(1) 
 dimi retVal
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 getTitle$ = tempVal$(0)
 ÄD
 
 Ä retVal
 
ÄF

/***********************************************************

 * Description: 
 * Provides the current mode setting values in the camera
 * Returns 0 Ä Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Camera Settings
 * Params:





















 * Created by: vimala On 2009-05-08 14:31:25
 * History: 
 ***********************************************************/
Ä getCameraSettings(byref dimi brightness, byref dimi contrast, _
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
 
 ÄB retVal = 0 Ä
 
 Ä i= 0 Ä ÄÇ(tempVal$) 
 {varName$(i)} = strtoint(tempVal$(i)) 
 Ä
 
 ÄD
 
 Ä retVal  
 
ÄF



/***********************************************************

 * Description: 
 * Sets the Mode Setting values in the camera.
 * Returns 0 Ä Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Mode Setting 
 * Params:





















 * Created by: vimala On 2009-05-08 14:57:28
 * History: 
 ***********************************************************/
Ä setCameraSettings(dimi brightness, dimi contrast, _
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

 ÄB ret > 0 Ä  
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  

ÄF


/***********************************************************

 * Description: Check all the properties sendto camera are saved or not by parsing response data.
 * 
 * 
 * Params:

 * dims propName$(): String array - All the set Keywords
 * dims propValue$(): String array - value Ä each keyword , -1 Ä failure keywords 
 * Created by:Vimala  On 2010-05-03 18:45:45
 * History: 
 ***********************************************************/
Ä chkRetStatusAndUpdate$(dims responseStaus$,dims propName$(),dims propValue$()) 
 
 dimi retVal,splCount,idx,propidx,retLength,propLength, maxProp
 dims retStatus$,failedKeywords$,retVal$
 dims keyword$
 dimi findPos,nextPos
 dims actualStr$
 dimi sptNo
 dims outputStr$(2)
 dims keywordTemp$,propKey$  
 splCount = Ä<(retStatus$,responseStaus$,"\n") 
 maxProp = ÄÇ(propName$)
 
 Ä idx = 0 Ä splCount-1
 
 retLength  = Ä (retStatus$(idx))
 retVal$  = Ä#(Äç(retStatus$(idx),retLength-3)) 
 
 ÄB retVal$ <> "" Ä
 Ä propidx = 0 Ä maxProp 
 
 propLength = Ä (propName$(propidx)) 
 propKey$ = Ä#(Äç(propName$(propidx),propLength-1)) 
 
 ÄB retVal$ = propKey$ Ä  
 
 ÄB Äå(retStatus$(idx),2) <> "OK" Ä  
 propValue$(propidx) = "-1"
 ÄB ~keywordDetFlag = 1 Ä
 keyword$ = propKey$
 findPos = Ä&(cameraKeywords$,keyword$)
 
 ÄB findPos >= 0 Ä
 nextPos = Ä&(cameraKeywords$,",",findPos)
 actualStr$ = Ä%(cameraKeywords$,findPos,(nextPos-findPos))
 sptNo = Ä<(outputStr$,actualStr$,"|")
 
 ÄB sptNo = 2 Ä
 keywordTemp$ = outputStr$(1)
 ÄC 
 keywordTemp$ = outputStr$(0)
 ÄD
 
 ÄD  
 failedKeywords$ = failedKeywords$ + keywordTemp$ +","
 Ä (propidx%5) = 0 Ä failedKeywords$ += "\n"  
 ÄC 
 failedKeywords$ = failedKeywords$ + Äç(propName$(propidx),propLength-1)+","
 ÄD  
 ÄD
 ÄE
 
 ÄD
 
 Ä
 
 ÄD
 
 Ä
 
 Ä updateLatestValues(propName$,propValue$)
 failedKeywords$ = Äå(failedKeywords$,(Ä (failedKeywords$)-1)) 
 chkRetStatusAndUpdate$ = failedKeywords$

ÄF


/***********************************************************

 * Description: 
 * Gets video analytic screen value from  camera. 
 * Returns 0 Ä Success; -1 failure  

 * Params:













 * Created by: vimala On 2009-08-25 16:43:30
 ***********************************************************/
Ä getVideoAnalyticsSettings(byref dimi facedetect, byref dimi regionX, byref dimi regionY, _
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
 
 ÄB  retVal = 0 Ä
 
 Ä idx = 0 Ä ÄÇ(tempVal$) 
 
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 
 Ä  
 
 ÄD
 
 Ä retVal  
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä set user input values of video analytic screen Ä camera
 
 * Returns 0 Ä Success; -1 failure  
 
 * Params:












 
 * Created by: vimala On 2009-08-25 11:54:14
 ***********************************************************/
Ä setVideoAnalyticsSettings(dimi facedetect, dimi regionX, dimi regionY, _
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
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
 
ÄF


/***********************************************************

 * Description: 
 * Get video analytic drop down option values from camera *
 * Returns 0 Ä Success; -1 failure  
 
 * Params: 
 * byref dims direction$(): String array - Hold the available options of direction
 * byref dims maskOptionsName$(): String array - Hold the available options of mask Options 
 * byref dims frecognitionName$(): String array - Hold the available options of face recognition 
 * Created by: vimala On 2009-08-25 11:54:14
 * History: 
 ***********************************************************/
Ä getVideoAnalyticsOptions(byref dims direction$(), byref dims maskOptionsName$(), byref dims frecognitionName$(),byref dims fdetectname$())
 
 dims varName$(4) = ("direction$","maskOptionsName$","frecognitionName$","fdetectname$")
 dims propName$(4) = ("gfddirectionname","gmaskoptionsname","gfrecognitionname","gfdetectname") 
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 
 Ä idx = 0 Ä ÄÇ(tempVal$)
 
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount > 0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF


/***********************************************************

 * Description: 
 * Provides the Network values Ä Network settings
 * Returns 0 Ä Success; -1 failure  

 * Params:




 * byref dimi httpPort: Numeric - Http port
 * Created by: Franklin Jacques On 2009-02-27 12:24:47
 ***********************************************************/
Ä getNetworkDetails(byref dims ip$, byref dims netmask$, byref dims defaultGWay$, _
 byref dims priNameServer$, byref dimi httpPort, byref dimi dhcpenable)
 dimi ret  
 dims varName$(6) = ("ip$", "netmask$", "defaultGWay$", "priNameServer$", "httpPort", "dhcpenable")
 dims propName$(6) = ("gnetip", "gnetmask", "ggateway", "gdnsip", "ghttpport", "gdhcpenable")
 
 dims tempVal$(6)
 dimi i
 ret=getiniValues(propName$,tempVal$)
 ÄB ret>=0 Ä
 Ä i= 0 Ä 5
 ÄB i=4 or i=5 Ä
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄC
 {varName$(i)} = tempVal$(i) 
 ÄD
 Ä  
 ÄD
 Ä ret
ÄF


/***********************************************************

 * Description: Sets the Network details Ä Network setting
 * Returns 0 Ä Success; -1 failure  
 
 * Params:






 * Created by: Franklin Jacques On 2009-02-27 12:27:58
 ***********************************************************/
Ä setNetworkPortDetails(dims ip$,dims netmask$,dims defaultGWay$,dims priNameServer$,dimi httpport,dimi httpsport,dimi portinput, dimi portoutput,dimi rs485,dimi dhcpenable)
 dims NWdetails$, NWPortDetails$
 dims responsedata$
 dimi ret
 
 ÄB dhcpenable=1 Ä
 NWdetails$ = ""  
 ÄC
 NWdetails$ = "netip="+ip$+"&netmask="+netmask$+"&gateway="+defaultGWay$+"&dnsip="+priNameServer$+"&"  
 
 ÄD
 NWPortDetails$ = NWdetails$+"httpport="+httpport+"&httpsport="+httpsport+"&portinput="+portinput+_
 "&portoutput="+portoutput+"&rs485="+rs485
 Ä NWPortDetails$
 ret = setProperties(NWPortDetails$, responseData$) 
 
 ÄB ret >= 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF




/***********************************************************

 * Description: 
 * Get the FTP details Ä Network setting 
 * Returns 0 Ä Success; -1 failure  
 
 * Params:




 * byref dimi ftpport: Numeric - Holds ftp port value
: Numeric - 
 * Created by: Franklin Jacques On 2009-02-27 12:32:03
 * History: 
 ***********************************************************/
Ä getFTPDetails(byref dims ftpServer$, byref dims username$, _
 byref dims pwd$, byref dims fileUpldpath$, byref dimi ftpport)
 dimi ret  
 dims varName$(5) = ("ftpServer$", "username$", "pwd$", "fileUpldpath$", "ftpport")
 dims propName$(5) = ("gftpip", "gftpuser", "gftppassword","gftppath", "gftpipport")
 dims tempVal$(5)
 dimi i
 ret=getiniValues(propName$,tempVal$) 
 ÄB ret>=0 Ä
 Ä i= 0 Ä 4
 ÄB i=4 Ä
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄC 
 {varName$(i)} = tempVal$(i) 
 ÄD
 Ä  
 ÄD
 Ä ret  
ÄF


/***********************************************************

 * Description: 
 * Sets the FTP details Ä Network setting
 * Returns 0 Ä Success; -1 failure  
 
 * Params:



 * dims fileUpldpath: Numeric - File Upload Path
 * Created by: Franklin Jacques On 2009-02-27 12:39:27
 ***********************************************************/
Ä setFTPDetails(dims ftpServer$, dims username$, dims pwd$, dims fileUpldpath$, dimi ftpport)
 
 Dims FTPdetails$
 dims responsedata$
 dimi ret
 FTPdetails$="ftpip="+ftpServer$+"&ftpuser="+username$+"&ftppassword="+pwd$+"&ftppath="+fileUpldpath$+"&ftpipport="+ftpport+""

 ret = setProperties(FTPdetails$, responseData$) 
 
 ÄB ret >= 0 Ä
 
 dims propName$(5) = ("gftpip", "gftpuser", "gftppassword","gftppath", "gftpipport")
 
 dims propVal$(5)
 propVal$(0) = ftpServer$
 propVal$(1) = username$
 propVal$(2) = pwd$
 propVal$(3) = fileUpldpath$
 propVal$(4) = ftpport
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret
ÄF


/***********************************************************

 * Description: Get the SMTP details Ä Network setting 
 * Returns 0 Ä Success; -1 failure  
 
 * Params:





 * byref dimi requiresAuth$: String - My server requires authentication
 * byref dimi smtpPort: Numeric - SMTP Port
 * Created by: Franklin Jacques On 2009-02-27 14:55:22
 * Modified by: Karthi on 28-Sep-10 
 ***********************************************************/
Ä getSMTPDetails(byref dims accName$, byref dims pwd$, byref dims sender$, _
 byref dims smtpServer$,byref dimi smtpPort,byref dims emailid$, byref dimi requiresAuth)
 
 dimi ret
 dims varName$(7) = ("accName$", "pwd$", "sender$","smtpServer$","smtpPort","emailid$","requiresAuth")
 dims propName$(7) = ("gsmtpuser","gsmtppwd","gsmtpsender","gsmtpip","gsmtpport","gemailuser","gsmtpauth")
 dims tempVal$(7)
 dimi i
 ret=getiniValues(propName$,tempVal$)
 ÄB ret>=0 Ä  
 Ä i= 0 Ä 6
 
 ÄB i=6 or i = 4 Ä
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄC 
 {varName$(i)} = tempVal$(i) 
 ÄD
 Ä "{varName$(i)} = tempVal$(i)";varName$(i);tempVal$(i) 
 Ä
 ÄD
 Ä ret 
ÄF


/***********************************************************

 * Description: Get the SNTP details Ä Network setting
 * Returns 0 Ä Success; -1 failure  

 * Params:


 * Created by: Franklin Jacques On 2009-02-27 15:27:40
 ***********************************************************/
Ä getSNTPRTSPDetails(byref dims sntpServer$,byref dimi multiCast)
 
 dims varName$(2) = ("sntpServer$","multiCast")
 dims propName$(2) = ("gsntpip","gmulticast")
 dims tempVal$(2)
 dimi i,ret
 ret=getiniValues(propName$,tempVal$)
 
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=1 Ä
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄC 
 {varName$(i)} = tempVal$(i) 
 ÄD
 
 Ä
 ÄD
 Ä ret 
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä set sntp Server and multi Cast values Ä IPNC
 
 * Params:

 * dimi multiCast: Numeric - Holds MultiCast Value 
 * Created by: Vimala On 2009-11-06 10:49:28
 ***********************************************************/
Ä setSNTPRTSPDetails(dims sntpServer$,dimi multiCast)
 dimi ret
 dims SNTPRTSPDetails$
 dims responseData$
 
 SNTPRTSPDetails$="sntpip="+sntpServer$+"&multicast="+multiCast  
 
 ret = setProperties(SNTPRTSPDetails$, responseData$)
 
 ÄB ret >= 0 Ä
 
 dims propName$(2) = ("gsntpip","gmulticast")

 dims propVal$(2)
 propVal$(0) = sntpServer$
 propVal$(1) = multiCast  
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: Ä get the port details (https/http)
 
 * Params:





 * rs485name$: String - get the label Ä rs485-on/off
 * Created by: Franklin Jacques  On 2009-05-08 14:36:53
 * History: 
 ***********************************************************/
Ä getPORTDetails(byref dimi httpsport,byref dimi portinput,byref dimi portoutput,_
 byref dimi rs485,byref dims portinputname$,byref dims portoutputname$,byref dims rs485name$)
 
 dims varName$(7) = ("httpsport", "portinput", "portoutput", "rs485", "portinputname$","portoutputname$", "rs485name$")
 dims propName$(7) = ("ghttpsport", "gportinput", "gportoutput", "grs485", "gportinputname", "gportoutputname", "grs485name")
 dims tempVal$(7)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=4 or i=5 or i=6 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret 
 
ÄF


/***********************************************************

 * Description: 
 * Get the motion detection setting values from IPNC
 * Returns 0 Ä Success; -1 failure  

 * Params:



 * byref dimi thresholdValue: Numeric - threshold value Ä customize 
 * byref dimi minThreshold:Numeric - min customize threshold value
 * byref dimi maxThreshold:Numeric - max customize threshold value

 * Created by: Franklin On 2009-03-02 12:13:49
 ***********************************************************/
Ä getMotionDetectSettings(byref dimi isCustomvalue, byref dimi sensitivity, byref dimi thresholdValue, _
 byref dimi minThreshold, byref dimi maxThreshold, byref dims motionBlock$)
 
 dims tempVal$
 
 dims varName$(6) = ("isCustomvalue", "sensitivity", "thresholdValue", "minThreshold", "maxThreshold", "motionBlock$")
 dims propName$(6) = ("gmotioncenable", "gmotionsensitivity", "gmotioncvalue", "gminmotionthreshold", "gmaxmotionthreshold", "gmotionblock")
 dims values$(6)
 dimi i, ret
 
 
 ret = getIniValues(propName$, values$)
 
 ÄB ret = 0 Ä
 
 Ä i= 0 Ä ÄÇ(values$)
 ÄB i = 5 Ä
 {varName$(i)} = values$(i) 
 ÄC
 {varName$(i)} = strtoint(values$(i)) 
 ÄD  
 
 Ä
 
 ÄD
 
 Ä ret
 
ÄF

/***********************************************************

 * Description: 
 * Set motion detection setting values 
 * Returns 0 Ä Success; -1 failure  

 * Params:




 * dimi thresholdValue : customized threshold value
 * Created by: Franklin On 2009-03-02 12:17:29
 ***********************************************************/
Ä setMotionDetectSettings(dimi isCustomvalue, dimi sensitivity, dimi thresholdValue, dims motionBlock$)
 
 dimi ret, i
 dims value$
 dims responseData$
 
 dims propName$(4) = ("motioncenable", "motioncvalue", "motionsensitivity", "motionblock")
 dims propValue$(4)= ("isCustomvalue", "thresholdValue", "sensitivity", "motionBlock$")
 
 value$ = propName$(0) + "=" + {propValue$(0)}
 
 
 Ä i=1 Ä 3
 value$ += "&" + propName$(i) + "=" + {propValue$(i)}
 Ä
 
 
 ret = setProperties(value$, responseData$)

 ÄB ret >= 0 Ä
 
 Ä i=0 Ä 3
 propName$(i) = "g"+propName$(i)
 propValue$(i) = {propValue$(i)}
 Ä
 
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propValue$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret
 
ÄF

/***********************************************************

 * Description: 
 * Get the Alarm setting module dropdown values 
 * Returns 0 Ä Success; -1 failure  
 
 * Params:
 * byref dims arrSensitivity$: String - Returns the array containing the predefined sensitivity options.
 * Created by: Partha Sarathi.K On 2009-03-02 12:30:15
 * History: 
 ***********************************************************/
Ä getMotionDetectOptions(byref dims arrSensitivity$())
 
 dims tempVal$
 
 dims propName$(1) = ("gmotionname")
 dims values$(1)
 dimi ret, i, retVal
 
 retVal = getIniValues(propName$, values$) 
 
 ÄB retVal = 0 Ä
 ret = Ä<(tempVal$, values$(0), ";") 
 
 ÄB ret >= 1 Ä
 redim arrSensitivity$(ret) 
 arrSensitivity$ = tempVal$  
 ÄD
 ÄD
 
 Ä retVal
 
ÄF


/***********************************************************

 * Description: 
 * Load the properties from ini file.
 * Parse the properties & value.

 * Created by: Partha Sarathi.K On 2009-02-23 11:42:22
 * Modified by: vimala 28-05-2008
 ***********************************************************/
Ä loadIniValues()
 
 dimi index
 dims value$, line$
 dimi ret, retVal
 dimi length
 dims tempProp$,temp$
 
 Ä keywords$(5000) 
 
 
 
 
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
 
 ÄB retVal > 0 Ä
 
 length = Ä (~responseData$)
 line$  = ""
 
 ~maxPropIndex = 0
 
 Ä index = 0 Ä length-1
 Ä ~responseData$(index) = "\r" Ä continue
 ÄB ~responseData$(index) = "\n" Ä  
 
 ret = Ä<(value$, line$, "=") 
 line$ = ""
 
 Ä ret <= 1 Ä continue  
 tempProp$ = Ä8(value$(0)) 
 
 ÄB Ä&(keywords$,tempProp$) >= 0  Ä  
 ~iniProperties$(~maxPropIndex) = "g"+tempProp$  
 temp$ = value$(1) 
 Ä ret = 3 Ä temp$ += "="+value$(2) 
 ~iniPropValues$(~maxPropIndex) = temp$ 
 
 ~maxPropIndex++
 ÄD  
 
 continue
 
 ÄD
 line$ += ~responseData$(index) 
 
 Ä  
 
 ÄD  
 
 Ä retVal
 
ÄF


/***********************************************************

 * Description: 
 * Get the parsed ini value Ä given keyword.
 * 
 * Params:
 * dims propName$: String array - Holds the keywords Ä which value Ä fetched from server
 * byref dims propValue$ : String array - Holds corresponding value Ä the keyword 
 * Created by: Partha Sarathi.K On 2009-02-27 11:58:25
 ***********************************************************/
Ä getiniValues(dims propName$(), byref dims propValue$())
 
 dimi i, j
 dims tempVal$
 dimi ret
 dimi maxProperty
 
 maxProperty = ÄÇ(propName$)
 
 Ä i=0 Ä maxProperty
 
 propValue$(i) = "-1"  
 
 ÄB Ä#(propName$(i)) <> "" Ä  
 
 Ä j = 0 Ä ~maxPropIndex-1
 
 ÄB ~iniProperties$(j) = propName$(i) Ä  
 propValue$(i) = ~iniPropValues$(j) 
 ÄE
 ÄD
 
 Ä
 
 ÄD
 
 Ä
 
 Ä 0
 
ÄF


/***********************************************************

 * Description: 
 * Download the ini.htm file contents with user name password in header information.

 * Created by: Partha Sarathi.K  On 2009-02-27 15:17:26
 ***********************************************************/
Ä dwnldIniFile() 
 dimi ret
 dims tempAuth$
 
 
 tempAuth$ = generateauthHeader$(~authUserName$, ~authPassword$)
 ~authHeader$ = "Authorization: Basic " + tempAuth$ + "\r\n"
 Ä "header = " + ~authHeader$ 
 
 
 ret = Ä5(~camAddPath$ + "ini.htm", "","a.txt",2,SUPRESSUI,~authHeader$,,,~responseData$)
 ~responseData$ = Äà(~responseData$, "<br>", "\n")
 dwnldIniFile = ret
 
 
ÄF



/***********************************************************

 * Description: Download the file(.txt) from camera.
 * 
 * Created by: Franklin Jacques.k  On 2009-10-08 10:25:11
 ***********************************************************/
Ä dwnldFile$(dims fileName$)
 
 dimi ret
 dims tempAuth$
 Ä textInfo$(30000)
 dims filePath$
 
 
 tempAuth$ = generateauthHeader$(~authUserName$, ~authPassword$)
 ~authHeader$ = "Authorization: Basic " + tempAuth$ + "\r\n"
 
 
 filePath$ = ~camAddPath$ + fileName$
 ret = Ä5(filePath$, "",fileName$,2,SUPRESSUI,~authHeader$,,,textInfo$)
 SETOSVAR("*FLUSHEVENTS", "") 
 textInfo$ = Äà(textInfo$, "<br>", "\n")
 textInfo$ = Äà(textInfo$, "\t", "    ")
 textInfo$ = Äà(textInfo$, ÄQ(147), "\"")
 textInfo$ = Äà(textInfo$, ÄQ(148), "\"")
 textInfo$ = Äà(textInfo$, ÄQ(146), "'")
 Ä textInfo$
 ÄB ret > 0 Ä
 dwnldFile$ = textInfo$
 ÄC 
 dwnldFile$ = "NA"
 ÄD
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä Ä property value in 
 ~iniPropValues$ array ÄB property value is not -1

 * Params:
 * dims propertyName$(): String array - Hold camera keywords
 * dims propertyValues$(): String array - Holds updated values Ä each keyword
 * Created by: Vimala On 2009-03-19 15:45:31
 ***********************************************************/
Äh updateLatestValues(dims propertyName$(),dims propertyValues$())
 
 dimi i, j  
 dimi maxVal
 
 maxVal = ÄÇ(propertyName$) 
 
 Ä maxVal <> ÄÇ(propertyValues$) Ä Ä
 
 Ä i=0 Ä maxVal  
 
 Ä j = 0 Ä ~maxPropIndex-1  
 
 ÄB ~iniProperties$(j) = propertyName$(i) Ä  
 
 Ä propertyValues$(i) <> "-1" Ä ~iniPropValues$(j) = propertyValues$(i) 
 ÄE
 ÄD  
 
 Ä  
 
 Ä
 
ÄF

/***********************************************************

 * Description: 
 * Get all available users from camera
 * Returns 0 Ä Success; -1 failure  

 * Params:







 * Created by: On 2009-03-06 16:03:46
 * History: 
 ***********************************************************/
Ä getUserSetting(byref dimi authorityAdmin, byref dimi authorityOperator, _
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
 
 ÄB retVal = 0 Ä  
 dimi idx  
 
 Ä idx= 0 Ä ÄÇ(values$) 
 {varName$(idx)} = strtoint(values$(idx))
 Ä  
 
 retVal = getPropValue("user", user$)
 retVal = getPropValue("authority", authority$) 
 
 ÄD
 
 Ä retVal
 
ÄF

/***********************************************************

 * Description: 
 * Add user Ä the camera 
 * Returns 0 Ä Success; -1 failure  

 * Params:


 * dimi authority: Numeric - Authority of the user Admin=0, Operator=1, Viewer=2
 * Created by: On 2009-03-06 16:19:09
 * History: 
 ***********************************************************/
Ä addUser(dims username$, dims pwd$, dimi authority)
 dimi ret
 dims value$
 dims responseData$,retStatus$
 
 value$ = "adduser="+username$+":"+pwd$+":"+authority  
 
 ret = setProperties(value$, responseData$)
 
 ÄB ret > 0 Ä
 
 ÄB Ä#(Äå(responseData$,3)) = "OK" Ä
 Ä 0
 ÄC 
 Ä -10
 ÄD
 
 ÄD  
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: 
 * Delete an user in the camera 
 * Returns 0 Ä Success; -10/-11 failure  

 * Params:
 * dims username$: String - user name
 * Created by: On 2009-03-06 18:50:20
 * History: 
 ***********************************************************/
Ä deleteUser(dims username$)
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "deluser="+username$  

 ret = setProperties(value$, responseData$)

 ÄB ret > 0 Ä
 
 ÄB Ä#(Äå(responseData$,3)) = "OK" Ä
 Ä 0
 Äy Ä#(Äå(responseData$,3)) = "NG" Ä 
 Ä -11
 ÄC
 Ä -10
 ÄD
 
 ÄD  
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: 
 * Used Ä get the values of variables User, Authority, Schedule
 * 
 * Params:
 * dims prop$: String - Camera Keyword
 * byref dims propVal$(): String array - Returns the Camera Keyword value in an array
 * Created by: On 2009-03-06 17:38:33
 * History: 
 ***********************************************************/
Ä getPropValue(dims prop$, byref dims propVal$())
 dimi pos1, pos2  ,ret
 dims userdetail$
 dims retVal$
 
 ret=Ä5(~camAddPath$+"vb.htm?paratest="+prop$, "","test1.txt",2,SUPRESSUI,~authHeader$,,,userdetail$)
 SETOSVAR("*FLUSHEVENTS", "") 
 ÄB ret > 0 Ä
 retVal$ = Ä#(Äå(userdetail$,3))
 
 ÄB retVal$ = "OK" Ä
 
 userdetail$ = Äà(userdetail$,"OK ","\n")
 
 pos1 = Ä&(userdetail$, "\n" + prop$ + "=")
 
 ÄB pos1 > -1 Ä
 pos1 = Ä (prop$)+2+pos1
 pos2 = Ä&(userdetail$, "\n\n", pos1+1)
 ÄB pos2 > pos1+1 Ä
 dims tempStr$,arrStr$
 dimi retVal
 tempStr$ = Ä%(userdetail$, pos1, pos2-pos1)
 retVal = Ä<(arrStr$, tempStr$, "\n") 
 propVal$ = arrStr$
 Ä ret
 ÄC
 Ä -10
 ÄD
 ÄC
 Ä -10
 ÄD
 Äy retVal$ = "UA" Ä 
 Ä -20  
 ÄC
 Ä -10
 ÄD  
 
 ÄC
 Ä ret
 ÄD
 
ÄF



/***********************************************************

 * Description: 
 * Sets the SMTP details Ä Network setting
 * Returns 0 Ä Success; -1 failure  

 * Params:





 * dimi requiresAuth: Numeric - My server requires authentication
 * dimi smtpPort: Numeric - SMTP Port
 * Created by: On 2009-02-27 15:08:21
 * Modified by: karthi on 28-Sep-10
 * History: 
 ***********************************************************/
Ä setSMTPDetails(dims accName$, dims pwd$, dims sender$, _
 dims smtpServer$,dimi smtpPort,dims emailid$, dimi requiresAuth)
 Dims SMTPDetails$
 dims responseData$
 dimi ret
 
 SMTPDetails$="smtpuser="+accName$+"&smtppwd="+pwd$+"&smtpsender="+sender$+"&smtpip="+smtpServer$+"&smtpport="+smtpPort+"&emailuser="+emailid$+"&smtpauth="+requiresAuth
 
 ret = setProperties(SMTPDetails$, responseData$)
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF



/***********************************************************

 * Description: 
 * Sets the SNTP details Ä Network setting
 * Returns 0 Ä Success; -1 failure  
 * SRS Reference: Software Requirements> Modules> Settings> Network Setting  
 * Params:


 * dimi daylight: Numeric - Automatically adjust Ä Daylight saving Ä changes
 * Created by:Franklin On 2009-02-27 15:33:09
 * History: 
 ***********************************************************/
Ä setSNTPDetails(dims sntpServer$, dimi timezone, dimi daylight)
 
 Dims SNTPDetails$
 dims responsedata$
 dimi ret
 
 SNTPDetails$="sntpfqdn="+sntpServer$+"&timezone="+timezone+"&daylight="+daylight+""
 
 ret = setProperties(SNTPDetails$, responseData$)
 
 ÄB ret > 0 Ä
 
 dims propName$(3) = ("gsntpip","gtimezone","gdaylight")
 dims propVal$(3)
 propVal$(0) = sntpServer$
 propVal$(1) = timezone
 propVal$(2) = daylight
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF


/***********************************************************

 * Description: 
 * Get the available list of Ä zones
 * Returns 0 Ä Success; -1 failure  
 
 * Params:
 * byref dims arrTimezones$(): String array - Ä Ä the timezones
 * dims arrTimezones$(): String - file name Ä be downloaded from camera
 * Created by:Franklin  On 2009-02-27 15:38:52
 ***********************************************************/
Ä getTimezones(byref dims arrTimezones$(),dims fileName$)
 dimi splitCount,i
 dims tempZoneVal$,timeZones$
 tempZoneVal$ = dwnldFile$(fileName$)
 ÄB tempZoneVal$ <> "" Ä
 splitCount = Ä<(timeZones$,tempZoneVal$,"\n")
 ÄB splitCount > 0  Ä
 redim arrTimezones$(splitCount)
 arrTimezones$ = timeZones$
 Ä 1
 ÄC 
 Ä -1
 ÄD  
 ÄC 
 Ä -1
 ÄD
 
ÄF

/***********************************************************

 * Description: 
 * Get the storage setting Ä the camera 
 * Returns 0 Ä Success; -1 failure  

 * Params:



 * byref dims Timezonename$: String - Ä zone name
 * byref dimi daylight : Numeric - Check Ä activate this functionality. 
 * byref dimi dateformat: String - Ä as in Camera
 * byref dimi timeFormat : Numeric - Possible values are 24h, 12h
 * byref dimi datePosition : Numeric - Possible values are top-Äå, bottom-Äå, top-Äç, bottom-Äç
 * byref dimi timePosition : Numeric - Possible values are top-Äå, bottom-Äå, top-Äç, bottom-Äç
 *
 * Created by: vimala On 2009-05-11 12:30:27
 * History: 
 ***********************************************************/
Ä getDateTime(byref dims dateInCamera$, byref dims timeInCamera$, _
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
 
 ÄB retVal = 0 Ä  
 Ä idx = 0 Ä ÄÇ(tempVal$) 
 
 ÄB  idx = 0  or idx = 1  or idx = 2 Ä
 {varName$(idx)} = tempVal$(idx)
 
 ÄC 
 {varName$(idx)} = strtoint(tempVal$(idx))
 ÄD  
 
 Ä  
 
 ÄD
 
 Ä retVal
 
ÄF

/***********************************************************

 * Description: 
 * Get the Ä/Ä setting drop dowm values from camera 
 * Returns 0 Ä Success; -1 failure  

 * Params:




 * 
 * Created by: vimala  On 2009-05-11 12:38:43
 * History: 
 ***********************************************************/
Ä getDateFormatOptions(byref dims dateformat$(),byref dims timeFormat$(), _
 byref dims datePosition$(),byref dims timePosition$())
 
 
 dims varName$(4) = ("dateformat$","timeFormat$","datePosition$","timePosition$") 
 dims propName$(4) = ("gdateformatname","gtstampformatname","gdatetimepositionname","gdatetimepositionname")
 dims tempVal$(4)
 
 dimi splitidx, retVal, sptCount  ,idx
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$,tempVal$)
 
 ÄB retVal = 0 Ä
 
 Ä idx= 0 Ä ÄÇ(tempVal$)
 
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount>0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF

/***********************************************************

 * Description: 
 * Set the Ä,Ä Ä$ / new Ä & Ä
 * Based on the option selected the values are set Ä camera
 * ÄB response Ä the synchronise is TIMEOUT timefrequency display "SNTP request timed out due to network problem"
 * Returns 0 Ä Success; -1 failure  

 * Params:







 * Created by: vimala On 2009-05-11 12:52:47
 * History: 
 ***********************************************************/
Ä setDatetime(dimi setdate, dims newDate$, dims newtime$,_
 dimi dateformat, dimi timeFormat, dimi datePosition,_
 dimi timePosition,dimi timezone, dimi daylight)
 
 dims value$,responseData$
 dimi ret  
 
 ÄB setdate = 0 Ä  
 value$ = "dateformat="+dateformat+"&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 Äy  setdate  = 1 or  setdate  = 2 Ä  
 value$ = "newdate="+newDate$+"&newtime="+newtime$+"&dateformat="+dateformat+_
 "&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 Äy  setdate  = 3 Ä  
 value$ = "timefrequency=-1&daylight="+daylight+"&timezone="+timezone+"&dateformat="+dateformat+_
 "&tstampformat="+timeFormat+"&dateposition="+datePosition+_
 "&timeposition="+timePosition
 
 ÄD  
 Ä value$ 
 ret = setProperties(value$, responseData$) 
 
 ÄB Ä&(responseData$,"TIMEOUT timefrequency") <> -1 Ä
 Ä(0,"")
 Ä("SNTP request timed out due to network problem") 
 ret = -11
 Ä(1000,"DisplayDigitalClock")
 ÄC  
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD
 
 Ä ret
 
ÄF

/***********************************************************

 * Description: 
 * Get the storage setting values Ä the camera 
 * Returns 0 Ä Success; -1 failure  

 * Params:

 byref dimi ftpfileformat: Numeric - Enabled/ Disabled
 byref dims ftpfileformatname$: string - MPEG/JPEG

 byref dimi sdfileformat: Numeric - Enabled/ Disabled
 byref dims sdfileformatname$: string - MPEG/JPEG



 * byref dims recordSchedule$(): String - Existing record schedule
 * Created by:Franklin  On 2009-03-09 12:04:40
 * History: 
 ***********************************************************/
Ä getStorageSetting(byref dimi uploadbyFTP,byref dimi ftpfileformat,byref dims ftpfileformatname$, byref dimi storeLocally, _
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
 ÄB ret>=0 Ä  
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=2 or i=5 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 Ä ret 
ÄF


/***********************************************************

 * Description: 
 * Sets the storage setting values Ä camera 
 * Returns 0 Ä Success; -1 failure  

 * Params:






 * byref dims recordSchedule$(): String - Existing record schedule
 * Created by:Franklin  On 2009-03-09 14:02:04
 * History: 
 ***********************************************************/
Ä setStorageSetting(dimi uploadbyFTP,dimi ftpfileformat, dimi storeLocally, _
 dimi sdfileformat, dimi localStorage, dimi repeatSchedule, dimi noOfWeeks, _
 dimi scheduleInfinity, dims recordSchedule$)
 dims storageSetting$
 dims responseData$
 dimi ret
 storageSetting$="rftpenable="+uploadbyFTP+"&ftpfileformat="+ftpfileformat+"&sdrenable="+storeLocally+_
 "&sdfileformat="+sdfileformat+"&recordlocalstorage="+localStorage+"&schedulerepeatenable="+repeatSchedule+"&schedulenumweeks="+noOfWeeks+_
 "&schedule="+recordSchedule$+"&scheduleinfiniteenable="+scheduleInfinity+""
 
 ret = setProperties(storageSetting$, responseData$)
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: 
 * Get the Alarm setting details
 * Returns 0 Ä Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:




















 * Created by: vimala On 2009-05-11 17:12:10
 * History: 
 ***********************************************************/
Ä getAlarmSetting(byref dimi enableAlarm, byref dimi storageDuration, _
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
 
 ÄB retVal = 0 Ä
 
 Ä idx = 0 Ä ÄÇ(tempVal$) 
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 Ä
 
 ÄD
 
 Ä retVal 
 
ÄF
 
/***********************************************************

 * Description: 
 * Get the Alarm setting module dropdown values 
 * Returns 0 Ä Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:







 * byref dimi audioFiles$: String Array - Returns the durations Ä be saved before alarm.
 * Created by: vimala On 2009-05-11 10:52:31
 * History: 
 ***********************************************************/
Ä getAlarmSettingOptions(byref dims arrExtInpTriger$(), byref dims arrExtOutTriger$(), _
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
 
 ÄB retVal = 0 Ä
 
 Ä idx= 0 Ä ÄÇ(tempVal$)
 
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount>0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF
 
/***********************************************************

 * Description: 
 * set the Alarm setting details
 * Returns 0 Ä Success; -1 failure 
 * SRS Reference: Software Requirements> Modules> Settings> Alarm Setting 
 * Params:


















 * Created by: vimala On 2009-05-11 17:12:10
 * History: 
 ***********************************************************/
Ä setAlarmSetting(dimi enableAlarm, dimi storageDuration, _
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

 Ä value$
 ret = setProperties(value$, responseData$) 

 ÄB ret > 0 Ä  

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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF
 
/***********************************************************

 * Description: 
 * Get the Live video values from camera
 * 
 * Params:
 * byref dims streams$(): String - Ä get the value of the streams
 * byref dims clicksnapfilename$(): String - Ä get the filename
 * byref dims democfgname$(): String - 
 * byref dims audioenable: integer - Ä get the audioenable value
 * byref dims rotation: integer - Ä get the rotation value
 * byref dims clicksnapstorage: integer - Ä get the clicksnapstorage value
 * byref dims democfg: integer - Ä get the democfg value
 * byref dims frecognition: integer - Ä get the frecognition value
 * Created by:Franklin  On 2009-05-19 12:46:05
 * History: 
 ***********************************************************/
Ä getLiveVideoOptions(byref dims clicksnapfilename$,byref dims democfgname$, byref dimi audioenable,_
 byref dimi clicksnapstorage,byref dimi democfg,byref dimi audiomode)
 
 dims varName$(6) = ("clicksnapfilename$","democfgname$","audioenable",_
 "clicksnapstorage","democfg","audiomode")
 dims propName$(6) = ("gclicksnapfilename","gdemocfgname","gaudioenable",_
 "gclicksnapstorage","gdemocfg","gaudiomode")
 dims tempVal$(6)
 dimi idx, splitidx, retVal, ret  ,streamIndex
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 
 Ä idx=0 Ä ÄÇ(tempVal$)
 ÄB idx=0 or idx=1 Ä
 {varName$(idx)} = tempVal$(idx) 
 ÄC
 {varName$(idx)} = strtoint(tempVal$(idx)) 
 ÄD  
 Ä
 
 ÄD

 Ä retVal  
ÄF

/***********************************************************

 * Description: 
 * set audio status(enable/disable)
 * 
 * Params:
 * dimi audiostatus: Numeric - Audio status
 * dimi audiomode: Numeric - Audio mode
 * Created by: On 2009-03-13 15:18:23
 ***********************************************************/
Ä setAudioStatus(dimi audiostatus,dimi audiomode) 
 Dimi ret
 Dims responseData$, data$ 
 data$ = "audioenable="+audiostatus+"&audiomode="+audiomode
 ret = setProperties(data$, responseData$)
 
 ÄB ret > 0 Ä  
 dims propName$(2) = ("gaudioenable","gaudiomode")
 
 dims propVal$(2)
 propVal$(0) = audiostatus
 propVal$(1) = audiomode
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret
 
ÄF

/***********************************************************

 * Description: 
 * Ä get the alarm status(On / Off) from camera
 * 
 * Params:
 * dims alarmStatus: Numeric - Alarm status
 * Created by:Franklin  On 2009-03-13 18:49:49
 ***********************************************************/
Äh getAlarmstatus(byref dims alarmStatus$) 
 Dims responseData$
 Dimi ret 
 
 ret=Ä5(~camAddPath$+"vb.htm?getalarmstatus", "","result.txt",2,SUPRESSUI,~authHeader$,1,,responseData$) 
 SETOSVAR("*FLUSHEVENTS", "") 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä set property value Ä each property.
 * 
 * 
 * Params:

 * byref dims responseData$: String - Ä value from the camera
 * Created by: rajan  On 2009-03-18 17:38:12
 * History: 
 ***********************************************************/
Ä setProperties(dims data$, byref dims responseData$)
 dimi retVal  
 retVal=Ä5(~camAddPath$+"vb.htm?"+data$, "","result.txt",2,SUPRESSUI,~authHeader$,,,responseData$)
 responseData$ = Äà(responseData$, "OK ", "\nOK ")
 responseData$ = Äà(responseData$, "UW ", "\nUW ")
 responseData$ = Äà(responseData$, "NG ", "\nNG ")
 responseData$ = Äà(responseData$, ":", "\n")
 responseData$ = Äà(responseData$, "\n\n", "\n")
 setProperties = retVal  
ÄF


/***********************************************************

 Get video setting value Ä camera
 * Params: 
 * byref dimi videocodec: Numeric - get the value Ä the stream type
 * byref dims videocodecname$: String - Holds stream type drop down options

 * byref dims videocodecname$: String - Holds codec combo drop down options
 * byref dimi videocodecres: Numeric - get the value Ä the resolution type
 * byref dims videocodecresname$: String  - Hold resolution drop down options 
 * Created by: On 2009-05-11 09:44:29
 ***********************************************************/
Ä getVideoImageSetting(byref dimi videocodec, byref dims videocodecname$, byref dimi videocodecmode, _
 byref dims videocodecmodename$, byref dimi videocodecres, byref dims videocodecresname$) 
 dims varName$(6) = ("videocodec", "videocodecname$", "videocodecmode",_
 "videocodecmodename$", "videocodecres","videocodecresname$")
 dims propName$(6) = ("gvideocodec", "gvideocodecname", "gvideocodeccombo",_
 "gvideocodeccomboname", "gvideocodecres","gvideocodecresname")
 dims tempVal$(6)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=1 or i=3 or i=5 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret  

ÄF


/***********************************************************

 Get video stream 1 values from camera
 * Description: 
 * byref dimi framerate1: Numeric - get the framerate Ä stream1
 * byref dimi frameratename1$: String - get all possible frame rate options Ä load drop down









 * byref dimi textposition1: Numeric - get the value Ä textposition of stream1
 * byref dims  textpositionname$: String - get the value Ä text position drop down option values 


 * byref dimi mirctrl: Numeric - get the option Ä mirctrl-enable/disable
 * byref dims mirctrlname$: String - get the option Ä mirror ctrl drop down option values 
 * byref dims overlaytext1$: String - get the overlay text value
 * byref dimi detailinfo1: Numeric - get the  detail info value
 * byref dims localdisplayname$: String - get the local display drop down option values 
 *
 * Created by: On 2009-05-11 09:44:41
 * Histbyref ory: 
 ***********************************************************/
Ä getVideoStream1(byref dimi framerate1, byref dims frameratename1$, byref dimi bitrate1, _
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
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$) 
 ÄB i=1 or i=4 or i=9 or i=12 or i=16 or i=17 or i=19 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret 
 
 
ÄF


/***********************************************************

 * Description: 
 Get video stream 2 values from camera
 
 * Params:
 * byref dimi framerate2: Numeric - get the framerate Ä stream2
 * byref dims frameratename2$: String - get all possible frame rate options Ä load drop down







 * byref dimi textposition2: Numeric - get the value Ä textposition of stream2
 * byref dims overlaytext2$: String - get the overlay text value
 * byref dimi detailinfo2: Numeric - get the  detail info value
 
 * Created by: On 2009-05-11 09:44:52
 ***********************************************************/
Ä getVideoStream2(byref dimi framerate2, byref dims frameratename2$, byref dimi bitrate2, byref dimi ratecontrol2, byref dimi datestampenable2,_
 byref dimi timestampenable2, byref dimi logoenable2, byref dimi logoposition2, byref dimi textenable2, byref dimi textposition2,_
 byref dims overlaytext2$,byref dimi detailinfo2) 
 
 dims varName$(12) = ("framerate2", "frameratename2$", "bitrate2", "ratecontrol2", "datestampenable2",_
 "timestampenable2", "logoenable2", "logoposition2", "textenable2", "textposition2","overlaytext2$","detailinfo2")
 
 dims propName$(12) = ("gframerate2", "gframeratenameall2", "gbitrate2", "gratecontrol2", "gdatestampenable2",_
 "gtimestampenable2", "glogoenable2", "glogoposition2", "gtextenable2", "gtextposition2","goverlaytext2","gdetailinfo2")
 
 dims tempVal$(12)
 dimi i,ret
 
 ret=getiniValues(propName$,tempVal$)
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=1 or i=10 Ä
 {varName$(i)} = tempVal$(i)
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret 
 
ÄF


/***********************************************************

 * Description: 
 Get video stream 3 values from camera
 
 * Params:
 * byref dimi framerate3: Numeric - get the framerate Ä stream3
 * byref dims frameratename3$: String - get all possible frame rate options Ä load drop down








 * byref dimi textposition3: Numeric - get the value Ä textposition of stream3
 * byref dims overlaytext3$: String - get the overlay text value
 * byref dimi detailinfo3: Numeric - get the  detail info value
 * Created by: On 2009-05-11 09:45:02
 ***********************************************************/
Ä getVideoStream3(byref dimi framerate3, byref dims frameratename3$, byref dimi bitrate3, byref dimi ratecontrol3, _
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
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i=1 or i=11 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: 
 * Ä set the values Ä video Image setting Ä camera
 * 
 * Params:


 * dimi videocodecres: Numeric - set the value Ä resolution type
 * dimi mirctrl: Numeric - set the value Ä mirror control
 * Created by: On 2009-05-11 15:04:26
 ***********************************************************/
Ä setVideoImageSetting(dimi videocodec,dimi videocodecmode,dimi videocodecres,dimi mirctrl)
 
 dims VideoImageSetting$
 dims responseData$
 dimi ret

 VideoImageSetting$="videocodec="+videocodec+"&videocodeccombo="+videocodecmode+"&videocodecres="+videocodecres+_
 "&mirctrl="+mirctrl
 
 Ä VideoImageSetting$
 ret = setProperties(VideoImageSetting$, responseData$)

 ÄB ret > 0 Ä
 
 dims propName$(4) = ("gvideocodec","gvideocodeccombo", "gvideocodecres","gmirctrl")

 dims propVal$(4)
 propVal$(0) = videocodec
 propVal$(1) = videocodecmode
 propVal$(2) = videocodecres  
 propVal$(3) = mirctrl
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
ÄF


/***********************************************************

 * Description: 
 * Ä set the Values Ä Video Stream1
 * 
 * Params:









 * dimi devicename: Numeric - set the device name  
 * dimi textposition1: Numeric - set the value Ä textposition of stream1



 * dimi detailinfo1: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 1 stream type(JPEG / other stream(H264,MPEG4))
 * Created by: On 2009-05-11 15:09:54
 * History: 
 ***********************************************************/
Ä setVideoStream1(dimi framerate1,dimi bitrate1,dimi ratecontrol1,dimi liveQuality,dimi datestampenable1,_
 dimi timestampenable1,dimi logoenable1,dimi logoposition1,dimi textenable1, dims devicename$,_
 dimi textposition1, dimi encryptvideo,dimi localdisplay, dims overlaytext1$,dimi detailinfo1,dims streamType$)
 
 dims VideoStream1$
 dims responseData$
 dimi ret
 ÄB streamType$ = "JPEG" Ä
 VideoStream1$="framerate1="+framerate1+"&livequality="+liveQuality+_
 "&datestampenable1="+datestampenable1+"&timestampenable1="+timestampenable1+_
 "&logoenable1="+logoenable1+"&logoposition1="+logoposition1+"&textenable1="+textenable1+"&title="+devicename$+_
 "&textposition1="+textposition1+"&encryptvideo="+encryptvideo+"&localdisplay="+localdisplay+"&overlaytext1="+overlaytext1$+_
 "&detailinfo1="+detailinfo1
 ÄC 
 VideoStream1$="framerate1="+framerate1+"&bitrate1="+bitrate1+"&ratecontrol1="+ratecontrol1+_
 "&datestampenable1="+datestampenable1+"&timestampenable1="+timestampenable1+_
 "&logoenable1="+logoenable1+"&logoposition1="+logoposition1+"&textenable1="+textenable1+"&title="+devicename$+_
 "&textposition1="+textposition1+"&encryptvideo="+encryptvideo+"&localdisplay="+localdisplay+"&overlaytext1="+overlaytext1$+_
 "&detailinfo1="+detailinfo1
 ÄD
 Ä VideoStream1$
 ret = setProperties(VideoStream1$, responseData$)
 
 Ä Ä&(responseData$,"OK title")>0 Ä ~title$ = devicename$
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
 
ÄF

/***********************************************************

 * Description: 
 * Ä set the Values Ä Video Stream2
 * 
 * Params:
 








 * dimi textposition2: Numeric - set the value Ä textposition of stream2

 * dimi detailinfo2: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 2 stream type(JPEG / other stream(H264,MPEG4))

 * Created by: On 2009-05-11 15:16:10  
 * History: 
 ***********************************************************/
Ä setVideoStream2(dimi framerate2,dims bitrate2$,dimi ratecontrol2,dimi liveQuality,dimi datestampenable2,_
 dimi timestampenable2,dimi logoenable2,dimi logoposition2, dimi textenable2,_
 dimi textposition2, dims overlaytext2$,dimi detailinfo2,dims streamType$) 
 
 dims VideoStream2$
 dims responseData$
 dimi ret
 ÄB streamType$ = "JPEG" Ä
 VideoStream2$= "framerate2="+framerate2+"&livequality="+liveQuality+_
 "&datestampenable2="+datestampenable2+"&timestampenable2="+timestampenable2+_
 "&logoenable2="+logoenable2+"&logoposition2="+logoposition2+"&textenable2="+textenable2+_
 "&textposition2="+textposition2+"&overlaytext2="+overlaytext2$+"&detailinfo2="+detailinfo2
 ÄC 
 VideoStream2$= "framerate2="+framerate2+"&bitrate2="+bitrate2$+"&ratecontrol2="+ratecontrol2+_
 "&datestampenable2="+datestampenable2+"&timestampenable2="+timestampenable2+_
 "&logoenable2="+logoenable2+"&logoposition2="+logoposition2+"&textenable2="+textenable2+_
 "&textposition2="+textposition2+"&overlaytext2="+overlaytext2$+"&detailinfo2="+detailinfo2
 ÄD
 
 ret = setProperties(VideoStream2$, responseData$)
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF


/***********************************************************

 * Description: 
 * Ä set the Values Ä Video Stream3
 * 
 * Params:
 








 * dimi textposition3: Numeric - set the value Ä textposition of stream3

 * dimi detailinfo3: Numeric - set the detail info value
 * dims streamType$: String - Hold stream 3 stream type(JPEG / other stream(H364,MPEG4))
 * Created by: On 2009-05-11 15:55:09
 ***********************************************************/
Ä setVideoStream3(dimi framerate3,dims bitrate3$,dimi ratecontrol3,dimi liveQuality,_
 dimi datestampenable3,dimi timestampenable3,dimi logoenable3,dimi logoposition3,_
 dimi textenable3,dimi textposition3, dims overlaytext3$,dimi detailinfo3,dims streamType$)
 
 dims VideoStream3$
 dims responseData$
 dimi ret
 
 ÄB streamType$ = "JPEG" Ä
 VideoStream3$="framerate3="+framerate3+"&livequality="+liveQuality+_
 "&datestampenable3="+datestampenable3+"&timestampenable3="+timestampenable3+"&logoenable3="+logoenable3+_
 "&logoposition3="+logoposition3+"&textenable3="+textenable3+_
 "&textposition3="+textposition3+"&overlaytext3="+overlaytext3$+"&detailinfo3="+detailinfo3
 ÄC 
 VideoStream3$="framerate3="+framerate3+"&bitrate2="+bitrate3$+"&ratecontrol2="+ratecontrol3+_
 "&datestampenable3="+datestampenable3+"&timestampenable3="+timestampenable3+"&logoenable3="+logoenable3+_
 "&logoposition3="+logoposition3+"&textenable3="+textenable3+_
 "&textposition3="+textposition3+"&overlaytext3="+overlaytext3$+"&detailinfo3="+detailinfo3
 ÄD  
 
 Ä VideoStream3$
 
 ret = setProperties(VideoStream3$, responseData$)
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
ÄF


/***********************************************************

 * Description: 
 * Ä get the Values Ä Video - Advanced setting from camera
 * Params:



















 * byref dimi str1h3: Numeric - Region parameters value Ä Height
 * byref dimi qpinit1: Numeric - Get QP init value
 
 * Created by: On 2009-05-11 17:35:48
 * History: 
 ***********************************************************/
Ä getVideoImageAdvanced1(byref dims ipratio1$, byref dimi forceiframe1, byref dims qpmin1$,_
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
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i<=4 Ä  
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i))
 ÄD
 Ä
 ÄD

 Ä ret 
 
ÄF

/***********************************************************

 * Description: 
 * Ä get the Values Ä VideoImageAdvanced2 setting
 * 
 * Params:


















 * byref dimi str2h3: Numeric - Region parameters value Ä Height
 * byref dimi qpinit2: Numeric - Get QP init value
 * Created by: On 2009-05-11 17:43:36
 * History: 
 ***********************************************************/
Ä getVideoImageAdvanced2(byref dims ipratio2$, byref dimi forceiframe2, byref dims qpmin2$, byref dims qpmax2$,_
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
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i<=3 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret 
 
ÄF

/***********************************************************

 * Description: 
 * Ä get the Values Ä VideoImageAdvanced3 setting
 * 
 * Params:




















 * byref dimi str3h3: Numeric - Region parameters value Ä Height
 * byref dimi qpinit3: Numeric - Get QP init value
 * Created by: On 2009-05-11 17:47:28
 * History: 
 ***********************************************************/
Ä getVideoImageAdvanced3(byref dimS ipratio3$, byref dimi forceiframe3, byref dimS qpmin3$, byref dimS qpmax3$, byref dimi meconfig3,_
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
 ÄB ret>=0 Ä
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i<=3 Ä
 {varName$(i)} = tempVal$(i) 
 ÄC 
 {varName$(i)} = strtoint(tempVal$(i)) 
 ÄD
 Ä
 ÄD
 
 Ä ret  
 
ÄF

/***********************************************************

 * Description: 
 * Ä set the Values Ä Video Advanced 1 setting
 * 
 * Params:



















 * dimi str1h3: Numeric - Region parameters value Ä Height
 * Created by: On 2009-05-11 20:05:42
 * History: 
 ***********************************************************/
Ä setVideoImageAdvanced1(dims ipratio1$, dimi forceiframe1, dims qpmin1$, dims qpmax1$, dims  qpinit1$,_
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
 Ä VideoImageAdvanced1$
 
 ret = setProperties(VideoImageAdvanced1$, responseData$)

 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF
/***********************************************************

 * Description: 
 * Ä set the Values Ä Video Advanced 2 setting
 * 
 * Params:



















 * dimi str2h3: Numeric - Region parameters value Ä Height
 * Created by: On 2009-05-11 20:05:42
 * History: 
 ***********************************************************/
Ä setVideoImageAdvanced2(dims ipratio2$, dimi forceiframe2, dims qpmin2$, dims qpmax2$, dims qpinit2$,_
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
 
 Ä VideoImageAdvanced2$  
 
 ret = setProperties(VideoImageAdvanced2$, responseData$)

 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF 

/***********************************************************

 * Description: 
 * Ä set the Values Ä VideoImageAdvanced3 setting
 * 
 * Params:



















 * dimi str3h3: Numeric - Region parameters value Ä Height
 * Created by: On 2009-05-19 12:08:27
 ***********************************************************/

Ä setVideoImageAdvanced3(dims ipratio3$, dimi forceiframe3, dims qpmin3$, dims qpmax3$,dims qpinit3$, _
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
 Ä VideoImageAdvanced3$
 
 
 ret = setProperties(VideoImageAdvanced3$, responseData$)

 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF 




/***********************************************************

 * Description: Ä get audio setting screen values
 * 
 * 
 * Params:





 * byref dimi bitRate: Numeric - Bit Rate
 * byref dimi alarmLevel: Numeric - Value ranges between 1 and 100
 * byref dimi outputVolume Numeric - Value ranges between 1 and 100.
 * Created by: vimala On 2009-05-11 21:59:09
 ***********************************************************/
Ä getAudioSetting(byref dimi enableAudio, byref dimi audioMode, byref dimi inputVolume, _
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
 
 ÄB retVal = 0 Ä
 
 Ä i= 0 Ä ÄÇ(tempVal$) 
 
 {varName$(i)} = strtoint(tempVal$(i)) 
 
 Ä
 
 ÄD
 
 Ä retVal  
 
ÄF



/***********************************************************

 * Description: 
 * Get drop down values Ä audio setting
 * 
 * Params:
 * byref dims audioMode$: String array - Audio mode drop down option
 * byref dims encoding$: String array - Encoding drop down option
 * byref dims sampleRate$: String array - Sample Rate drop down option
 * byref dims bitRate$: String array- Bit Rate drop down option *
 * Created by: vimala On 2009-05-11 22:03:36
 ***********************************************************/
Ä getAudioOptions( byref dims audioMode$(), byref dims encoding$(), _
 byref dims sampleRate$(), byref dims bitRate$())
 
 dims varName$(4) = ("audioMode$","encoding$","sampleRate$","bitRate$")
 dims propName$(4) = ("gaudiomodename","gencodingname","gsampleratename","gaudiobitratename")
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 
 Ä idx = 0 Ä ÄÇ(tempVal$)
 
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount > 0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF


/***********************************************************

 * Description: 
 * Ä set the values Ä Audio Setting Ä camera
 * 
 * Params:







 * dimi outputVolume Numeric - Value ranges between 1 and 100.
 * Created by: vimala On 2009-05-11 06:55:30
 ***********************************************************/
Ä setAudioSetting(dimi enableAudio, dimi audioMode, dimi inputVolume, _
 dimi encoding, dimi sampleRate, dimi bitRate, _
 dimi alarmLevel, dimi outputVolume) 
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "audioenable="+enableAudio+"&audiomode="+audioMode+"&audioinvolume="+inputVolume+_
 "&encoding="+encoding+"&samplerate="+sampleRate+"&audiobitrate="+bitRate+_
 "&alarmlevel="+alarmLevel+"&audiooutvolume="+outputVolume
 Ä value$  
 ret = setProperties(value$, responseData$) 
 
 ÄB ret > 0 Ä
 
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
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF


/***********************************************************

 * Description: 
 * Ä set the Values Ä click snap user input controls
 * 
 * Params:

 * dimi clicksnapstorage: Numeric - click snap storage option value
 * Created by: On 2009-05-20 11:07:09
 ***********************************************************/
Ä setLiveVideoOptions(dims clicksnapfilename$, dimi clicksnapstorage)
 
 dimi ret
 dims value$
 dims responseData$
 
 value$ = "clicksnapfilename="+clicksnapfilename$+"&clicksnapstorage="+clicksnapstorage+""

 ret = setProperties(value$, responseData$)

 ÄB ret > 0 Ä
 
 dims propName$(2) = ("gclicksnapfilename","gclicksnapstorage")
 
 dims propVal$(8)
 
 propVal$(0) = clicksnapfilename$
 propVal$(1) = clicksnapstorage
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret  
 
ÄF



/***********************************************************

 * Description: Get stream avaiable stream name feom camera
 * 
 * Params:




 * Created by: Vimala On 2010-01-13 02:21:31
 ***********************************************************/
Ä getStreamDisplayOrder(byref dimi videocodec,byref dims streamName1$,_
 byref dims streamName2$, byref dims streamName3$) 
 dims varName$(4) = ("videocodec","streamName1$","streamName2$","streamName3$") 
 dims propName$(4) = ("gvideocodec","gstreamname1","gstreamname2","gstreamname3")
 
 dims tempVal$(4)
 dimi i,retVal  
 
 retVal = getiniValues(propName$,tempVal$) 
 
 ÄB retVal = 0 Ä
 
 Ä i= 0 Ä ÄÇ(tempVal$)
 ÄB i = 0 Ä
 {varName$(i)} = strtoint(tempVal$(i))
 ÄC 
 {varName$(i)} = tempVal$(i) 
 ÄD
 Ä
 
 
 ÄD
 
 Ä retVal  
 
ÄF


/***********************************************************

 * Description: 
 * Ä get the Version Number Ä the params from the ini.htm
 * 
 * Params:




 * byref Dims GUIVersion: Numeric - retrieve the Version Number
 * Created by: Franklin Jacques.k On 2009-10-08 11:28:28
 ***********************************************************/
Ä getSupportData(byref Dims kernelVersion$, byref Dims UbootVersion$, byref Dims SoftwareVersion$)
 
 dims varName$(3)=("kernelVersion$", "UbootVersion$", "SoftwareVersion$")
 dims propName$(3)=("gkernelversion", "gbiosversion", "gsoftwareversion")
 dims tempVal$(3)
 dimi i,retVal
 
 retVal = getiniValues(propName$,tempVal$) 
 
 ÄB retVal = 0 Ä
 
 Ä i= 0 Ä ÄÇ(tempVal$)
 {varName$(i)} = tempVal$(i)
 Ä
 
 ÄD
 
 Ä retVal
 
ÄF


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
Ä getSDCardValue(byref Dims sdInsertVal$)
 dimi ret 
 
 ret=Ä5(~camAddPath$+"vb.htm?paratest=sdinsert", "","test1.txt",2,SUPRESSUI,~authHeader$,,,sdInsertVal$)
 
 
 ÄB ret > 0 Ä
 Ä ret
 ÄC
 Ä -10  
 ÄD 
 
 
ÄF


/***********************************************************

 * Description: Set example value Ä camera
 * 
 * Params:
 * byref Dimi democfg: Numeric - Example drop down selected value  
 * Created by: Vimala On 2009-12-15 00:26:47
 ***********************************************************/
Ä setExampleValue(dimi democfg)
 dimi ret
 dims responseData$, data$ 
 data$ = "democfg="+democfg
 ret = setProperties(data$, responseData$)
 
 ÄB ret > 0 Ä  
 dims propName$(1) = ("gdemocfg")
 
 dims propVal$(1)
 propVal$(0) = democfg
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä get the values of video file section
 
 * Params:



 * VideoSize$: String - Video size drop down
 * Created by: vimala On 2009-12-15 03:11:55
 * History: 
 ***********************************************************/
Ä getVideoFile(byref dimi videoStream,byref dims videoStreamName$(),byref dimi videoSize,byref dims VideoSize$()) 
 dims varName$(4) = ("videoStreamName$","VideoSize$","videoStream","videoSize")
 dims propName$(4) = ("gaviformatname","gavidurationname","gaviformat","gaviduration")
 
 dims tempVal$(4)
 dimi idx, splitidx, retVal,sptCount  
 dims optionValue$, splitChar$
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 
 Ä idx= 0 Ä ÄÇ(tempVal$)
 
 ÄB idx = 0 or idx =1 Ä
 splitChar$ = ";"
 sptCount = Ä<(optionValue$, tempVal$(idx), splitChar$)
 Ä sptCount>0 Ä redim {varName$(idx)}(sptCount)
 
 Ä splitidx = 0 Ä sptCount-1
 {varName$(idx)}(splitidx) = optionValue$(splitidx)
 Ä
 
 ÄC 
 {varName$(idx)} = strtoint(tempVal$(idx))
 ÄD
 
 Ä
 
 ÄD
 
 Ä retVal
ÄF



/***********************************************************

 * Description: Ä this Ä Ä Set the values of video file section
 * 
 * 
 * Params:

 * dimi videoSize: Numeric - video size selected value
 * Created by: Vimala On 2010-05-04 14:51:03
 * History: 
 ***********************************************************/
Ä setVideoFile(dimi videoStream, dimi videoSize) 
 dimi ret
 dims responseData$, data$ 
 data$ = "aviformat="+videoStream+"&aviduration="+videoSize
 Ä data$
 ret = setProperties(data$, responseData$)
 
 ÄB ret > 0 Ä  
 dims propName$(2) = ("gaviformatname","gaviduration")
 
 dims propVal$(2)
 propVal$(0) = videoStream
 propVal$(1) = videoSize
 
 ~errorKeywords$ = ""
 ~errorKeywords$ = chkRetStatusAndUpdate$(responseData$,propName$,propVal$)
 
 ÄB Ä (~errorKeywords$) > 0 Ä
 Ä -10
 ÄC
 Ä ret
 ÄD  
 
 ÄD 
 
 Ä ret
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä get the reload Ä from IPNC
 * 
 * 
 * Params:
 * reloadTime: Numeric - IPNC reload Ä
 * Created by: Vimala On 2010-01-05 06:20:36
 * History: 
 ***********************************************************/
Ä getLoadingTime(byref dimi reloadTime) 
 dims propName$(1) = ("greloadtime")
 dims tempVal$(1) 
 dimi retVal
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 reloadTime = strtoint(tempVal$(0))
 ÄD

 
 Ä retVal
ÄF


/***********************************************************

 * Description: Ä this Ä Ä delete all the schedules
 * 
 * Created by: Vimala On 2010-05-04 14:52:13
 ***********************************************************/
Äh setDeleteSchedule$() 
 dimi ret
 dims responseData$, data$ 
 data$ = "delschedule=1"
 Ä data$
 ret = setProperties(data$, responseData$) 
ÄF



/***********************************************************

 * Description: Ä this Ä Ä fetch reloadflag from IPNC
 
 * Created by: Vimala On 2010-04-13 18:32:14
 ***********************************************************/
Ä getReloadFlag() 
 getReloadFlag = -1
 dimi retVal
 dims responseData$
 
 retVal=Ä5(~camAddPath$+"vb.htm?paratest=reloadflag", "","test1.txt",2,SUPRESSUI,~authHeader$,,,responseData$)
 
 
 ÄB retVal >= 0 Ä
 Ä responseData$
 getReloadFlag = Ä(Äà(responseData$,"OK reloadflag=",""))
 ÄD
 
 Ä "getReloadFlag = " + getReloadFlag
 
ÄF



/***********************************************************

 * Description: Ä this Ä Ä get dmva enable value from camera
 * Enable Smart Analytics in the Äå menu only ÄB the flag "dmvaenable" = 1 
 * Created by:Vimala  On 2010-05-24 10:53:08
 * History: 
 ***********************************************************/
Ä getDMVAEnableValue() 
 getDMVAEnableValue = -1
 dimi retVal
 dims responseData$
 
 retVal=Ä5(~camAddPath$+"vb.htm?paratest=dmvaenable", "","test1.txt",2,SUPRESSUI,~authHeader$,,,responseData$) 
 ÄB retVal >= 0 Ä
 Ä responseData$
 getDMVAEnableValue = Ä(Äà(responseData$,"OK dmvaenable=",""))
 ÄD
 
 
 Ä "dmvaenable = " + getDMVAEnableValue
 
ÄF

/***********************************************************

 * Description: 
 * 
 * 
 * Params:



 * maxPwdLen: Numeric - 
 * Created by: On 2010-07-16 12:46:39
 * History: 
 ***********************************************************/
Ä getCtrlMaxMinValues(byref dimi minNameLen,byref dimi maxNameLen,byref dimi minPwdLen,byref dimi maxPwdLen) 
 SETOSVAR("*FLUSHEVENTS", "") 
 dims varName$(4) = ("minNameLen","maxNameLen","minPwdLen","maxPwdLen")
 dims propName$(4) = ("gminnamelen","gmaxnamelen","gminpwdlen","gmaxpwdlen")
 dims tempVal$(4) 
 dimi retVal,i
 
 retVal = getIniValues(propName$, tempVal$)
 
 ÄB retVal = 0 Ä
 Ä i = 0 Ä ÄÇ(tempVal$)
 Ä tempVal$(i)
 {varName$(i)} = Ä(tempVal$(i))
 Ä
 ÄD
 
 Ä retVal
ÄF



/***********************************************************

 * Description: Ä debug and Ä& the runtime values
 * Created by: On 2009-12-22 00:22:13
 ***********************************************************/
Äh writeToFile(dims XMLString$)
 dimi h1,b,ret
 h1=ÄK("setString.txt",1,3)
 XMLString$ = XMLString$ + "\n"
 b=ÄM(h1,XMLString$)
 ret=ÄO(h1)
 
ÄF


/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Äå Menu  *
 * *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.  *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED  *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT  *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS Ä A PARTICULAR PURPOSE.  *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE Ä ANY DAMAGES WHATSOEVER  *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES Ä LOSS OF BUSINESS PROFITS, *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS) *
 * ARISING OUT OF THE USE OF OR INABILITY Ä USE THE SOFTWARE, EVEN ÄB GoDB  *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  *
 * *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN  *
 * PERMISSION FROM GoDBTech.  *
\***************************************************************************************/
Functioni extern "user32" SetCursor(Dimi hCursor)
ÄF

Functioni extern "user32" LoadCursorA(Dimi Instance, Dimi lpCursorName)
ÄF


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

Ä alginBGImage  
Ä buildLeftTree()

/***********************************************************

 * Description: Lock mouse scroll
 * Created by: Franklin On 2009-05-15 15:21:15
 * History: 
 ***********************************************************/
Äh scroll_Keypressed(key)
 dimi k1=26 
 dimi k2=25
 
 ÄB k1=key or k2=key Ä
 Ä-(2)
 ÄD  
 
ÄF

/***********************************************************

 * Description: Resize back ground images based on screen resolution.
 * Created by: vimala  On 2009-05-15 06:07:30
 * History: 
 ***********************************************************/
Äh alginBGImage()
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
 ÄB ~menuYRes = 650 Ä
 yVal = START_YVALUE * ~factorY
 MENU_GAP=40 * ~factorY
 SUBMENU_GAP=28 * ~factorY
 ÄD
 
 Ä i = 0 Ä 2
 Ä ~loginAuthority = 1  and i = 1 Ä  continue
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
 
 Ä  
 
 SUBMENU_GAP = SUBMENU_GAP * ~factorY  
 yVal = #lblmenuval[2].y + #imgmenu[2].desth + SUBMENU_GAP  
 
 Ä i = 0 Ä MAXSUBMENU-1  
 ctrlName$ = "rosubmenu["+i+"]"
 #{ctrlName$}.y = yVal
 arrMousePos(noLeftMenuCtrls,0) = #{ctrlName$}.x
 arrMousePos(noLeftMenuCtrls,1) = yVal
 arrMousePos(noLeftMenuCtrls,2) = #{ctrlName$}.x + #{ctrlName$}.w
 arrMousePos(noLeftMenuCtrls,3) = yVal + #{ctrlName$}.h
 noLeftMenuCtrls++ 
 
 ÄB dmvaEnable <= 0 and i = 2 Ä  
 #{ctrlName$}.hidden = 1 
 ÄC
 yVal += SUBMENU_GAP
 ÄD  
 Ä
 
 Ä i = 3 Ä 4
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
 Ä  
 
 noLeftMenuCtrls--
 Ä i = 0 Ä noLeftMenuCtrls
 Ä arrMousePos(i,0);arrMousePos(i,1);arrMousePos(i,2);arrMousePos(i,3) 
 Ä

ÄF


/***********************************************************

 * Description: Assign selected image Ä the selected image
 * Created by:Vimala On 2009-05-19 11:53:33
 * History: 
 ***********************************************************/
Äh imgmenu_focus
 
 

 dims ctrlName$
 ctrlName$ = Ä(()
 
 ÄB ~changeFlag = 0  Ä 
 
 #imgselected.hidden = 0  
 #imgselected.x = #{ctrlName$}.x
 Ä #imgselected.x
 #imgselected.y = #{ctrlName$}.y  
 Ä #imgselected.y
 #imgselected.destw = #{ctrlName$}.destw+10
 Ä ctrlName$
 Ä #imgselected.destw
 #imgselected.desth = #rosubmenu.h +20
 Ä #imgselected.desth
 ÄD
 Ä∂(0)
ÄF  

/***********************************************************

 * Description: Assign selected image Ä the selected readonly box
 * Created by: Vimala On 2009-05-19 11:56:05
 * History: 
 ***********************************************************/
Äh rosubmenu_Focus  
 
 dims ctrlName$
 ctrlName$ = Ä(()
 
 ÄB ~changeFlag = 0  Ä  
 #imgselected.hidden = 0
 #imgselected.x = #{ctrlName$}.x
 #imgselected.y = #{ctrlName$}.y-10
 #imgselected.destw = #{ctrlName$}.w+17
 #imgselected.desth = #rosubmenu.h +20
 ÄD
 Ä∂(0)
ÄF

/***********************************************************

 * Description: Ä this Ä Ä load the menu captions
 * from menuCaptions.lan
 
 * Created by: vimala On 2009-05-19 12:02:04
 ***********************************************************/
Äh loadMenuCaptions() 
 dimi i,j
 dims ctrlName$
 loadarray(~menuArray$,"menuCaptions.lan")
 
 Ä i = 0 Ä MAXMAINMENU-1
 ctrlName$ = "lblmenuval["+i+"]"
 #{ctrlName$}$ = ~menuArray$(i)
 Ä "~menuArray$(i)";~menuArray$(i)
 Ä
 
 Ä j = 0 Ä MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 #{ctrlName$}$ = ~menuArray$(i)
 i++
 Ä  
 
ÄF




/***********************************************************

 * Description: Loads the selected screen
 * Created by: vimala On 2009-05-19 12:03:02
 * History: 
 ***********************************************************/
Äh imgmenu_Click
 
 
 
 ÄB canReload = 1 Ä  
 dims ctrlName$
 dimi arrPos
 
 ctrlName$ = Ä(()
 arrPos = getctrlNo(ctrlName$) 
 Ä Ä+() = ~urlMainArray$(arrPos) Ä Ä
 Ä chkValueMismatch()
 ÄB ~changeFlag = 1  Ä 
 ~mousemoveflag=1
 Ä("Do you want to save the changes",3)
 ~mousemoveflag=0
 ÄB Äu()=1 Ä  
 Ä∂(0) 
 ~UrlToLoad$ = ~urlMainArray$(arrPos)
 savePage() 
 Ä ~changeFlag = 0  Ä Ä_(~urlMainArray$(arrPos)) 
 ÄC 
 ~changeFlag = 0
 Ä_(~urlMainArray$(arrPos))
 ÄD 
 ÄC
 Ä_(~urlMainArray$(arrPos))
 ÄD
 ÄD
 
ÄF


/***********************************************************

 * Description: Ä assignOffImages Ä Ä assign OFF image.
 * Assign selected image Ä the control.
 * 
 * Params:
 * dims ctrlName$: String - Name of the control.
 * Created by: vimala On 2009-05-19 12:03:33
 * History: 
 ***********************************************************/
Äh assignSelectedImage(dims ctrlName$) 
 dimi arrPos
 
 assignOffImages()

 arrPos = getctrlNo(ctrlName$)
 #{ctrlName$}.src$ = ~menuOnImg$(arrPos)
 
 ÄB arrPos = 2 Ä
 showSubMenu(0,1)
 Äd("rosubmenu")
 rosubmenu_Click
 ÄC 
 showSubMenu(1,0) 
 ÄD 
 
 #lblheading$=~menuArray$(arrPos)
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä get the control array index.
 * Params:
 * dims ctrlName$: String - Name of the control
 * Created by: vimala On 2009-05-19 12:11:34
 * History: 
 ***********************************************************/
Ä getctrlNo(dims ctrlName$)
 
 dimi pos
 pos = Ä&(ctrlName$,"[")
 Ä pos = -1 Ä Ä 0
 ctrlName$ = Äà(ctrlName$,"]","")
 pos = Ä(Äç(ctrlName$,1))
 Ä pos  
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä assign OFF image Ä all 
 * the image control.
 * Created by: vimala On 2009-05-19 12:12:31
 * History: 
 ***********************************************************/
Äh assignOffImages()
 
 dimi i
 dims ctrlName$
 
 Ä i = 0 Ä MAXMAINMENU-1
 ctrlName$ = "imgmenu["+i+"]"  
 #{ctrlName$}.src$ = menuOffImg$(i)
 Ä
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä show or hide the settings Äh menu.
 * Params:

 * 1 - Hide Äh menu  
 * dimi selFlag: Numeric - ÄB set Ä 1, sets focus Ä setting image.
 * Created by: vimala On 2009-05-19 12:13:30
 * History: 
 ***********************************************************/
Äh showSubMenu(dimi showFlag,dimi selFlag)
 
 dimi j
 dims ctrlName$
 
 Ä j = 0 Ä MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 Ä dmvaEnable <= 0 and j = 2 Ä continue  
 #{ctrlName$}.hidden = showFlag  
 Ä  
 
 Ä selFlag = 1 Ä #imgmenu[2].src$ = ~menuOnImg$(2);Äd("imgmenu[2]")
 
ÄF



/***********************************************************

 * Description: Load the selected setting screen
 * Created by: vimala On 2009-05-19 12:17:38
 * History: 
 ***********************************************************/
Äh rosubmenu_Click
 Ä∂(0)
 
 
 ÄB canReload = 1 Ä  
 dims ctrlName$
 dimi arrPos
 
 ctrlName$ = Ä(()
 arrPos = getctrlNo(ctrlName$)
 
 Ä Ä+() = ~urlSubArray$(arrPos) Ä Ä
 Ä chkValueMismatch()
 ÄB ~changeFlag = 1 Ä 
 ~mousemoveflag=1
 Ä("Do you want to save the changes",3)
 ~mousemoveflag=0
 ÄB Äu()=1 Ä  
 Ä∂(0) 
 ~UrlToLoad$ = ~urlSubArray$(arrPos)
 savePage() 
 Ä ~changeFlag = 0  Ä Ä_(~urlSubArray$(arrPos)) 
 ÄC 
 ~changeFlag = 0
 Ä_(~urlSubArray$(arrPos)) 
 ÄD 
 ÄC
 Ä_(~urlSubArray$(arrPos)) 
 ÄD
 ÄD
ÄF



/***********************************************************

 * Description: set Ä∂
 * Created by: Franklin On 2009-05-19 12:17:38
 * History: 
 ***********************************************************/
Äh rosubmenu_blur
 Ä∂(3)
ÄF

/***********************************************************

 * Description: Ä assignFGcolor Ä Ä set default FG color
 * and change the FG color Ä the selected setting
 * Created by: vimala On 2009-05-19 12:18:04
 * History: 
 ***********************************************************/
Äh selectSubMenu()
 
 dims ctrlName$
 dimi arrPos
 
 assignFGcolor()
 
 ctrlName$ = Ä(()
 
 arrPos = getctrlNo(ctrlName$)
 
 #{ctrlName$}.fg = 64512
 #{ctrlName$}.selfg = 64512
 #lblheading$=~menuArray$(MAXMAINMENU+arrPos)
 
ÄF

/***********************************************************

 * Description: Ä this Ä Ä set default FG color.
 * Created by: vimala On 2009-05-19 12:19:30
 * History: 
 ***********************************************************/
Äh assignFGcolor()
 
 dimi j
 dims ctrlName$
 
 Ä j = 0 Ä MAXSUBMENU-1
 ctrlName$ = "rosubmenu["+j+"]"
 #{ctrlName$}.fg = 42228
 #{ctrlName$}.selfg = 42228
 Ä  
 
ÄF


/***********************************************************

 * Description: Click on the image label loads the selected screen
 * Created by: vimala On 2009-05-19 12:21:16
 * History: 
 ***********************************************************/
Äh lblmenuval_Click  
 Ä imgmenu_Click
ÄF



/***********************************************************

 * Description: Hitting ESC key sets focus Ä Ä main menu control
 * Params:

 * dimi menuNo: Numeric - currently selected menu number
 * Created by: vimala On 2009-05-19 12:22:24
 * History: 
 ***********************************************************/
Äh setLeftMenuFocus(dimi key,dimi menuNo) 
 
 dims ctrlName$
 
 ÄB key = 15 Ä
 menuNo++
 ctrlName$ = "imgmenu["+menuNo+"]"
 Äd(ctrlName$) 
 Ä∂(0)
 ÄD

ÄF



/***********************************************************

 * Description: Hitting ESC key sets focus Ä Ä Äh menu control
 * Params:

 * dimi menuNo: Numeric - currently selected menu number
 * Created by: vimala On 2009-05-19 12:23:17
 * History: 
 ***********************************************************/
Äh setSubMenuFocus(dimi key,dimi menuNo)
 
 
 dims ctrlName$
 
 ÄB key = 15 Ä
 
 ÄB menuNo = 7 Ä 
 setLeftMenuFocus(key,2) 
 ÄC
 menuNo++
 ctrlName$ = "rosubmenu["+menuNo+"]"
 Äd(ctrlName$) 
 ÄD
 Ä∂(0)
 ÄD
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä hide and show 
 * Äå menu controls based on user's authority
 * Created by: On 2009-05-17 23:50:13
 * History: 
 ***********************************************************/
Äh buildLeftTree  
 
 ÄB ~loginAuthority = 1 Ä
 #imgmenu[1].hidden = 1
 #lblmenuval[1].hidden = 1  
 
 Äy ~loginAuthority = 2 Ä
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
 ÄC
 #imgmenu[1].hidden = 0
 #imgmenu[2].hidden = 0
 #lblmenuval[1].hidden = 0
 #lblmenuval[2].hidden = 0
 showSubMenu(0,0) 
 ÄD  
 
 #imgLogo.x = #imgmenu[1].x + 5 
 #imgLogo.y = #imgleftmenu.desth - (70 * ~factorY )
ÄF


/***********************************************************

 * Description: Ä this Ä Ä re algin control positions
 * Created by: Vimala On 2009-05-18 00:32:20
 * History: 
 ***********************************************************/
Äh reAlignMenu()
 dimi j,yVal,SUBMENU_GAP
 dims ctrlName$,prevCtrl$
 #lblmenuval[2].y = #lblmenuval[1].y
 #imgmenu[2].y = #imgmenu[1].y
 SUBMENU_GAP = 35 * ~factorY  
 yVal = #lblmenuval[2].y + #imgmenu[2].desth + SUBMENU_GAP 

 Ä j = 0  Ä MAXSUBMENU-1 
 ctrlName$ = "rosubmenu["+j+"]"  
 #{ctrlName$}.y  = yVal
 yVal += SUBMENU_GAP  
 Ä  

 
 
ÄF



/***********************************************************

 * Description: Loads the login screen
 * Created by: vimala On 2009-05-19 12:27:07
 * History: 
 ***********************************************************/
Äh imgLogout_Click
 Ä_("!auth.frm") 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä check whether the control values are modified or not.
 * set ~changeFlag = 1 ÄB control value modified.
 * 
 * 
 * Params:
 * key: Numeric - Key value
 * Created by: On 2009-06-10 10:32:11
 * History: 
 ***********************************************************/
Äh checkForModification(dims ctrlValues$(), dims LabelName$()) 
 ~changeFlag = 0
 dimi i
 Ä i = 0 Ä ÄÇ(ctrlValues$) 
 Ä LabelName$(i) = "" or LabelName$(i) = "lblSuccessMessage" Ä continue
 Ä LabelName$(i);ctrlValues$(i);#{LabelName$(i)}$ 
 ÄB ctrlValues$(i) <> #{LabelName$(i)}$ Ä
 ~changeFlag = 1  
 ÄE
 ÄD
 Ä
ÄF


/***********************************************************

 * Description: Ä this Ä Ä Ä control window handle 
 
 * key: Numeric - Key value
 * Created by: vimala  On 2009-06-10 10:32:11
 * History: 
 ***********************************************************/
Äh getFocus() 
 dimi focusHandle  
 dimi hwnd  
 focusHandle = ÄV("user32.dll") 
 hwnd = Ä(Äº("*hwnd")) 
 CallLibFuncPas(focusHandle,"SetFocus",hwnd) 
 ÄW(focusHandle) 
ÄF  


Äh ChangeMouseCursor(X, Y)
 dimi Cnt, lHandle, blnChnageCursor
 Ä Cnt = 0 Ä noLeftMenuCtrls
 ÄB (X >= arrMousePos(Cnt, 0) and X <= arrMousePos(Cnt, 2)) and (Y >= arrMousePos(Cnt, 1) and Y <= arrMousePos(Cnt, 3)) Ä
 blnChnageCursor = 1
 Ä
 ÄD
 Ä
 ÄB blnChnageCursor = 1 Ä
 lHandle = LoadCursorA(0, IDC_HAND)
 ÄC
 lHandle = LoadCursorA(0, IDC_ARROW) 
 ÄD
 ÄB (lHandle > 0) Ä 
 SetCursor(lHandle)
 ÄD
ÄF



dimi noofctrl
noofctrl = Ä~()-25

dims LabelName$(noofctrl)
dimi XPos(noofctrl)
dimi YPos(noofctrl)
dimi Wdh(noofctrl)
dimi height(noofctrl)

LabelName$(0) = "rocameraName" : XPos(0) = 439: YPos(0) = 75: Wdh(0) = 100: Height(0) = -1
LabelName$(1) = "roCameraDate" : XPos(1) = 492: YPos(1) = 120: Wdh(1) = 76: Height(1) = -1
LabelName$(2) = "roTime" : XPos(2) = 657: YPos(2) = 120: Wdh(2) = 100: Height(2) = -1
LabelName$(3) = "optSetTime" : XPos(3) = 439: YPos(3) = 170: Wdh(3) = 136: Height(3) = 14
LabelName$(4) = "rodateManually" : XPos(4) = 492: YPos(4) = 210: Wdh(4) = 76: Height(4) = -1
LabelName$(5) = "drphour" : XPos(5) = 657: YPos(5) = 210: Wdh(5) = 48: Height(5) = -1
LabelName$(6) = "drpMinute" : XPos(6) = 773: YPos(6) = 210: Wdh(6) = 48: Height(6) = -1
LabelName$(7) = "drpSecond" : XPos(7) = 888: YPos(7) = 210: Wdh(7) = 48: Height(7) = -1
LabelName$(8) = "optSetTime[1]" : XPos(8) = 439: YPos(8) = 250: Wdh(8) = 222: Height(8) = 14
LabelName$(9) = "roDateComputer" : XPos(9) = 492: YPos(9) = 287: Wdh(9) = 76: Height(9) = -1
LabelName$(10) = "roTimeComputer" : XPos(10) = 657: YPos(10) = 287: Wdh(10) = 100: Height(10) = -1
LabelName$(11) = "optSetTime[2]" : XPos(11) = 439: YPos(11) = 333: Wdh(11) = 220: Height(11) = 14
LabelName$(12) = "roSNTP" : XPos(12) = 563: YPos(12) = 376: Wdh(12) = 227: Height(12) = -1
LabelName$(13) = "drpTimeZone" : XPos(13) = 563: YPos(13) = 416: Wdh(13) = 231: Height(13) = -1
LabelName$(14) = "chkdayLight" : XPos(14) = 439: YPos(14) = 457: Wdh(14) = 329: Height(14) = 14
LabelName$(15) = "drpFormat" : XPos(15) = 439: YPos(15) = 506: Wdh(15) = 139: Height(15) = -1
LabelName$(16) = "drptimeFormat" : XPos(16) = 773: YPos(16) = 506: Wdh(16) = 139: Height(16) = -1
LabelName$(17) = "drpDatePosition" : XPos(17) = 439: YPos(17) = 553: Wdh(17) = 139: Height(17) = -1
LabelName$(18) = "drpTimePostion" : XPos(18) = 774: YPos(18) = 553: Wdh(18) = 139: Height(18) = -1
LabelName$(19) = "cmdSubmit" : XPos(19) = 539: YPos(19) = 618: Wdh(19) = 80: Height(19) = 20
LabelName$(20) = "cmdCancel" : XPos(20) = 626: YPos(20) = 618: Wdh(20) = 80: Height(20) = 20
LabelName$(21) = "lblCameraTime" : XPos(21) = 322: YPos(21) = 120: Wdh(21) = 114: Height(21) = 14
LabelName$(22) = "lblDate" : XPos(22) = 439: YPos(22) = 120: Wdh(22) = 44: Height(22) = 14
LabelName$(23) = "lblTime" : XPos(23) = 597: YPos(23) = 120: Wdh(23) = 45: Height(23) = 14
LabelName$(24) = "lblDateFormat" : XPos(24) = 322: YPos(24) = 506: Wdh(24) = 99: Height(24) = 14
LabelName$(25) = "lblSetTime" : XPos(25) = 322: YPos(25) = 170: Wdh(25) = 99: Height(25) = 14
LabelName$(26) = "lblDateManually" : XPos(26) = 439: YPos(26) = 210: Wdh(26) = 43: Height(26) = 14
LabelName$(27) = "lblTimeManually" : XPos(27) = 597: YPos(27) = 210: Wdh(27) = 43: Height(27) = 14
LabelName$(28) = "lblDateComputer" : XPos(28) = 439: YPos(28) = 287: Wdh(28) = 43: Height(28) = 14
LabelName$(29) = "lblTimeComputer" : XPos(29) = 597: YPos(29) = 287: Wdh(29) = 43: Height(29) = 14
LabelName$(30) = "lblSNTP" : XPos(30) = 439: YPos(30) = 376: Wdh(30) = 91: Height(30) = 14
LabelName$(31) = "lblTimeZone" : XPos(31) = 439: YPos(31) = 416: Wdh(31) = 80: Height(31) = 14
LabelName$(32) = "lblsep" : XPos(32) = 751: YPos(32) = 210: Wdh(32) = 5: Height(32) = 14
LabelName$(33) = "lblsep1" : XPos(33) = 870: YPos(33) = 210: Wdh(33) = 10: Height(33) = 14
LabelName$(34) = "lbldayligth" : XPos(34) = 553: YPos(34) = 75: Wdh(34) = 225: Height(34) = 14
LabelName$(35) = "lbltimeFormat" : XPos(35) = 676: YPos(35) = 506: Wdh(35) = 80: Height(35) = 14
LabelName$(36) = "lblcameraName" : XPos(36) = 322: YPos(36) = 75: Wdh(36) = 80: Height(36) = 14
LabelName$(37) = "lblDatePosition" : XPos(37) = 322: YPos(37) = 553: Wdh(37) = 88: Height(37) = 14
LabelName$(38) = "lblTimePostion" : XPos(38) = 679: YPos(38) = 553: Wdh(38) = 80: Height(38) = 14
LabelName$(39) = "lblhr" : XPos(39) = 727: YPos(39) = 210: Wdh(39) = 16: Height(39) = 14
LabelName$(40) = "lblmin" : XPos(40) = 839: YPos(40) = 210: Wdh(40) = 24: Height(40) = 12
LabelName$(41) = "lblsec" : XPos(41) = 959: YPos(41) = 210: Wdh(41) = 28: Height(41) = 14
LabelName$(42) = "lblSuccessMessage" : XPos(42) = 313: YPos(42) = 588: Wdh(42) = 618: Height(42) = 14

dims dateFormat$
dims dateInCamera$,timeInCamera$
dimi currdate,hours,minutes,seconds 
Ä∂(3)
~wait = 2  
dimi displayCount,isMessageDisplayed  
displayCount = 1  
dims ctrlValues$(noofctrl),tempLabelName$(noofctrl)
dimi stopTimerFlag=1
dimi animateCount = 0  
dimi saveSuccess = 0  
dims error$ = ""  
dimi tempX  
Ä


/***********************************************************

 * Description: Ä displayControls Ä Ä algin contorls
 * based on the screen resolution.
 * Fetch Ä and Ä values from camera and
 * assign values Ä controls.
 * Highlight the selected link in Äå menu.

 * Created by: vimala On 2009-03-17 17:37:02
 ***********************************************************/
Äh Form_Load
 dimi retVal
 retVal = loadIniValues()
 
 ÄB ~maxPropIndex = 0 Ä 
 Ä("Unable to load initial values.")
 Ä_("!auth.frm")
 ÄD
 
 Ä displayControls(LabelName$,XPos,YPos,Wdh,height)
 Ä loadDateTimeValues()
 Ä fetchDateTime() 
 Ä loadDefaultValues()
 
 showSubMenu(0,1)
 Äd("rosubmenu[5]")
 selectSubMenu()
 Äd("optsettime")
 Ä drpFormat_Change() 
 #lblsuccessmessage$ = ""  
ÄF


/***********************************************************

 * Description: Store all the control values in an array Ä validate changes in form.

 * Created by: On 2010-05-03 12:31:27
 ***********************************************************/
Äh Form_Complete  
 dimi i
 Ä i = 0 Ä ÄÇ(ctrlValues$) 
 Ä LabelName$(i) = "roTime" or LabelName$(i) = "roTimeComputer" Ä continue
 tempLabelName$(i) = LabelName$(i)
 ctrlValues$(i) = #{LabelName$(i)}$  
 Ä tempLabelName$(i);ctrlValues$(i) 
 Ä
 
 ÄB canReload = 1 and ~UrlToLoad$ <> "" Ä  
 Dims ChangeUrl$
 ChangeUrl$ = ~UrlToLoad$
 ~UrlToLoad$ = ""
 Ä_(ChangeUrl$)
 ÄD
 
 SETOSVAR("*FLUSHEVENTS", "")
ÄF

/***********************************************************

 * Description: Ä this Ä Ä fetch values from camera
 * and load the same Ä screen controls
 
 * Created by: Vimala On 2009-03-19 10:12:52
 ***********************************************************/
Äh loadDateTimeValues()
 #rocameraname$ = ~title$
 
 dims dateformat$(1),timeFormat$(1),datePosition$(1),timePosition$(1)
 dimi retVal
 
 
 retVal = getDateFormatOptions(dateformat$,timeFormat$,datePosition$,timePosition$)
 
 ÄB retVal = 0 Ä
 Ä addItemsToDropDown("drpformat",dateformat$,-1)
 Ä addItemsToDropDown("drptimeFormat",timeFormat$,-1)
 Ä addItemsToDropDown("drpDatePosition",datePosition$,-1)
 Ä addItemsToDropDown("drpTimePostion",timePosition$,-1)
 ÄD  
 
 
 Ä loadTimeValues("drphour",23)
 Ä loadTimeValues("drpminute",59)
 Ä loadTimeValues("drpsecond",59) 
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä assign system Ä and time.
 
 * Created by: vimala On 2009-03-17 17:45:05
 ***********************************************************/
Äh loadDefaultValues  
 dims sysTime$,temp$
 dimi splitCount
 sysTime$ = Ä$("Time",Ä())
 splitCount = Ä<(temp$,sysTime$,":")
 
 ÄB splitCount = 3 Ä
 #drphour$ = temp$(0)
 #drpminute$ = temp$(1)
 #drpsecond$ = temp$(2)
 ÄD  
 
 #rotimecomputer$ = Ä$("time",Ä()) 
 Ä disableCtrls(1) 
ÄF




/***********************************************************

 * Description: Ä this Ä Ä fetch values from the camera and 
 * assign the same Ä controls.
 
 * Created by: vimala On 2009-03-17 17:52:52
 ***********************************************************/
Äh fetchDateTime  
 
 dimi retVal  
 dimi retTimezone
 dims sntpServer$
 dimi timezone,daylight,dateformat,timeFormat,datePosition,timePosition
 
 
 retVal = getDateTime(dateInCamera$,timeInCamera$,sntpServer$,timezone,daylight, _
 dateformat,timeFormat,datePosition,timePosition)
 
 ÄB retVal = -1 Ä
 Ä("Unable to fetch  values")
 Ä
 ÄD
 
 dimi convertDate  
 convertDate = convertDateToGoDBFormat(dateInCamera$,"YYYY/MM/DD")
 displayDate("rocameradate",#drpFormat.ITEMLABEL$(#drpformat),convertDate)
 currdate = convertDate  
 hours = Ä(Äå(timeInCamera$,2))
 minutes = Ä(Ä%(timeInCamera$,3,2))
 seconds = Ä(Äç(timeInCamera$,2)) 
 #rotime$ = timeInCamera$
 #rosntp$ = sntpServer$
 dateFormat$ = #drpFormat.ITEMLABEL$(#drpformat)
 #chkdaylight$ = daylight
 ÄB daylight = 1 Ä
 #lbldayligth$ = "Daylight Saving Time Is Acitve."
 ÄC 
 #lbldayligth$ = ""
 ÄD  
 
 
 dims timezone$(1)
 retTimezone=getTimezones(timezone$,"timezoneinfo.txt")
 
 ÄB retTimezone >= 0 Ä  
 Ä addItemsToDropDown("drpTimeZone", timezone$, timezone) 
 ÄD

 
 #drpformat$ = dateformat
 #drptimeFormat$ = timeFormat
 #drpDatePosition$ = datePosition
 #drpTimePostion$ = timePosition  
 
ÄF


/***********************************************************

 * Description: Disable Ä and Ä control ÄB other than
 * manually option is selected
 
 * Created by: vimala On 2009-03-17 17:55:14
 ***********************************************************/
Äh optsettime_click  
 
 ÄB #optsettime$ = "1" Ä
 Ä disableCtrls(0) 
 Äy #optsettime$ = "2" Ä
 Ä disableCtrls(1) 
 Äy #optsettime$ = "3" Ä
 Ä disableCtrls(1)
 #drpTimeZone.disabled = 0
 #chkdayLight.disabled = 0
 ÄD
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä enable and disable controls.
 
 * Params:
 * dimi disablevalue: Numeric - 0 - Ä enable controls
 * 1 - Ä disable control
 * Created by: vimala On 2009-03-17 17:55:20
 * History: 
 ***********************************************************/
Äh disableCtrls(dimi disablevalue) 
 #rodatemanually.disabled = disablevalue
 #drphour.disabled = disablevalue
 #drpminute.disabled = disablevalue
 #drpsecond.disabled = disablevalue  
 #drpTimeZone.disabled = 1
 #chkdayLight.disabled = 1
ÄF



/***********************************************************

 * Description: Ä savePage Ä save values Ä the camera.
 
 * Created by: vimala On 2009-03-17 18:11:50
 ***********************************************************/
Äh cmdSubmit_Click
 ÄB canReload = 1 Ä
 savePage() 
 ÄD  
ÄF



/***********************************************************

 * Description: Saves Ä and Ä setting values Ä camera 
 * based on selected options.
 
 * Created by: Vimala On 2009-05-28 16:34:07
 ***********************************************************/
Äh savePage()
 ~debugInfo$ += "Date time Settings \n"
 dimi retVal,retTimeZone,i
 dims manualTime$
 dims dateManually$
 
 ÄB #optsettime$ = "1" Ä
 manualTime$ = #drphour$+":"+#drpminute$+":"+#drpsecond$  
 dateManually$ = convertDateFormat$(Ä$("8",#rodatemanually.tag)) 
 Äy  #optsettime$ = "2" Ä
 manualTime$ = #rotimecomputer$
 dateManually$ = convertDateFormat$(Ä$("8",Ä()))
 Äy #optsettime$ = "3" Ä
 dateManually$ = dateInCamera$
 manualTime$ = timeInCamera$
 ÄC
 dateManually$ = dateInCamera$
 manualTime$ = timeInCamera$
 ÄD  
 
 retVal = setDatetime(#optsettime,dateManually$,manualTime$,_
 #drpformat,#drptimeformat,#drpdateposition,#drptimepostion,_
 #drptimezone,#chkdaylight)
 
 Ä(1000) 
 
 saveSuccess = retVal
 tempX = #lblsuccessmessage.x
 
 ÄB getReloadFlag() = 1 Ä  
 #lblsuccessmessage.style = 128
 #lblsuccessmessage.x = #lblsuccessmessage.x + #lblsuccessmessage.w/3
 canReload = 0
 animateCount = 1
 Ä animateLabel("lblsuccessmessage","Updating Camera")
 ÄC // ÄB Reload animation is not required
 canReload = 1
 ÄD
 
 ÄB canReload = 1 Ä  //Do the remaining actions after reload animation is done
 ÄB #optsettime$ = "3" Ä  
 retVal = loadIniValues() 
 ÄD  
 Ä displaySaveStatus(saveSuccess) 
 ÄD  
 
ÄF



/***********************************************************

 * Description: Ä this Ä Ä display saved message 
 * 
 * Created by: Vimala On 2010-06-24 14:39:10
 * History: 
 ***********************************************************/
Äh displaySaveStatus(dimi saveStatus)
 ÄB saveStatus > 0 Ä  
 #lblsuccessmessage.style = 64
 #lblsuccessmessage.x = tempX
 #lblsuccessmessage$ = "Date/Time setting saved to camera "+~title$  
 isMessageDisplayed = 1  
 #lblsuccessmessage.paint(1) 
 Äy saveStatus = -11 Ä 
 Ä
 ÄC
 ÄB ~keywordDetFlag = 1 Ä
 Ä("Date/Time setting for \n"+~errorKeywords$+"\nfailed for the camera "+~title$)
 ÄC
 Ä("Date/Time setting failed for the camera "+~title$)
 ÄD
 ÄD
 
 Ä loadDateTimeValues() 
 Ä fetchDateTime() 
 Ä optsettime_click
 Ä drpFormat_Change() 
 Ä(1000,"DisplayDigitalClock")
 Äd("optsettime")
 ~changeFlag = 0  
 canReload = 1  
 Ä Form_complete()
ÄF


/***********************************************************

 * Description: Popup calender and allow user Ä select date.
 
 * Created by: vimala On 2009-03-17 18:03:06
 ***********************************************************/
Äh rodateManually_Click  
 dimi  retVal
 retVal = Äâ(Ä(),(#lblSetTime.x+10),(#rodatemanually.y+#rodatemanually.h+5))
 
 ÄB retVal = 1 Ä  
 displayDate("rodateManually",#drpFormat.ITEMLABEL$(#drpformat),Ää()) 
 #rodatemanually.tag = Ää() 
 ÄD
ÄF



/***********************************************************

 * Description: Ä this Ä Ä display Ä in selected format.
 
 * Params:


 * dimi setVal: Numeric - selected value
 * Created by: vimala On 2009-03-17 18:03:06

 ***********************************************************/
Äh displayDate(dims ctrlName$,dims dateFormat$,dimi setVal) 
 
 ÄB dateFormat$ = "YYYY/MM/DD" Ä
 #{ctrlName$}$ = convertDateFormat$(Ä$("8",setVal)) 
 Äy dateFormat$ = "MM/DD/YYYY" Ä  
 #{ctrlName$}$ = Ä$("DATE0",setVal) 
 Äy dateFormat$ = "DD/MM/YYYY" Ä  
 #{ctrlName$}$ = Ä$("DATE1",setVal) 
 ÄD  
 
ÄF

/***********************************************************

 * Description: Displays Ä in selected Ä format.
 
 * Created by: vimala On 2009-03-17 18:18:17
 
 ***********************************************************/
Äh drpFormat_Change  
 dimi convertDate  
 convertDate = convertDateToGoDBFormat(#rocameradate$,dateFormat$)
 Ä convertDate
 
 ÄB #drpFormat.ITEMLABEL$(#drpformat) = "YYYY/MM/DD" Ä
 #rocameradate$ = convertDateFormat$(Ä$("8",convertDate)) 
 #rodatemanually$ = convertDateFormat$(Ä$("8",Ä()))
 #rodatemanually.tag = Ä()
 #rodatecomputer$ = convertDateFormat$(Ä$("8",Ä())) 
 Äy #drpFormat.ITEMLABEL$(#drpformat) = "MM/DD/YYYY" Ä  
 #rocameradate$ = Ä$("DATE0",convertDate) 
 #rodatemanually$ = Ä$("DATE0",Ä())
 #rodatemanually.tag = Ä()
 #rodatecomputer$ = Ä$("DATE0",Ä())
 Äy #drpFormat.ITEMLABEL$(#drpformat) = "DD/MM/YYYY" Ä  
 #rocameradate$ = Ä$("DATE1",convertDate) 
 #rodatemanually$ = Ä$("DATE1",Ä())
 #rodatemanually.tag = Ä()
 #rodatecomputer$ = Ä$("DATE1",Ä())
 ÄD
 
 dateFormat$ = #drpFormat.ITEMLABEL$(#drpformat) 
 
ÄF

/***********************************************************

 * Description: Converts the Ä Ä GoDB Ä$ - YYYYMMDD.
 
 * Params:

 * dims formatType$: String - Ä$ type of the Ä
 * Created by: vimala On 2009-03-17 18:20:09
 ***********************************************************/
Ä convertDateToGoDBFormat(dims dateInCamera$,dims formatType$) 
 
 convertDateToGoDBFormat = 0
 
 dims sptVal$(3)
 dimi retVal,sptIDx
 dims convertedDate$
 retVal = Ä<(sptVal$,dateInCamera$,"/")
 
 ÄB retVal = 3 Ä
 
 ÄB formatType$ = "YYYY/MM/DD" Ä  
 convertedDate$ = sptVal$(0)+sptVal$(1)+sptVal$(2) 
 Äy formatType$ = "MM/DD/YYYY" Ä  
 convertedDate$ = sptVal$(2)+sptVal$(1)+sptVal$(0) 
 Äy formatType$ = "DD/MM/YYYY" Ä  
 convertedDate$ = sptVal$(2)+sptVal$(1)+sptVal$(1) 
 ÄD
 
 convertDateToGoDBFormat = strtoint(convertedDate$)
 ÄD  
 
ÄF

/***********************************************************

 * Description: Convert GoDB Ä Ä YYYY/MM/DD format.
 
 * Params:
 * dims dateInCamera$: String - Ä in GoDB Ä$ YYYYMMDD
 * Created by: vimala On 2009-03-17 18:20:50

 ***********************************************************/
Ä convertDateFormat$(dims dateInCamera$) 
 
 convertDateFormat$ = Äå(dateInCamera$,4)+"/"+Ä%(dateInCamera$,4,2)+"/"+Äç(dateInCamera$,2)
 
ÄF


/***********************************************************

 * Description: Ä this Ä Ä increment Ä by one second.
 
 * Created by: vimala On 2009-03-17 18:21:49
 ***********************************************************/
Äh DisplayDigitalClock()
 
 dims hour$,min$,sec$  
 
 ÄB seconds < 59 Ä
 seconds++
 ÄC
 seconds = 0
 ÄB minutes < 59 Ä
 minutes++
 ÄC 
 minutes = 0
 ÄB hours < 23 Ä
 hours++
 ÄC 
 hours = 0
 currdate = Äb(currdate,1,0) 
 ÄD
 ÄD
 ÄD
 
 hour$ = Ä$("2",hours)
 min$ = Ä$("2",minutes)
 sec$ = Ä$("2",seconds)
 
 Ä Ä(hour$)< 10 Ä hour$ = "0"+Ä#(hour$)
 Ä Ä(min$)< 10 Ä min$ = "0"+Ä#(min$)
 Ä Ä(sec$)< 10 Ä sec$ = "0"+Ä#(sec$) 
 
 displayDate("rocameradate",#drpFormat.ITEMLABEL$(#drpformat),currdate) 
 #rotime$ = hour$+":"+min$+":"+sec$  
 #rocameradate.paint(1)
 #rotime.paint(1)
 displayDate("roDateComputer",#drpFormat.ITEMLABEL$(#drpformat),Ä()) 
 
 #rotimecomputer$ = Ä$("time",Ä())
 Ä stopTimerFlag = 1 Ä #rotimecomputer.paint(1) 
 
 
 ÄB isMessageDisplayed = 1 Ä  
 displayCount++
 ÄB displayCount = 5 Ä  
 isMessageDisplayed = 0
 displayCount = 1
 #lblsuccessmessage$ = ""
 Ä
 ÄD
 ÄD
 Ä "displayCount = " + displayCount
 
 ÄB canReload = 0 Ä
 ÄB animateCount <= ~reLoadTime Ä
 animateCount ++
 animateLabel("lblsuccessmessage","Updating Camera") 
 ÄC
 Ä displaySaveStatus(saveSuccess)
 ÄD
 ÄD  
 
ÄF

/***********************************************************

 * Description: Every second DisplayDigitalClock Ä 
 * is called Ä increment Ä value Ä display in UI.

 * Created by: On 2009-03-19 17:06:09
 ***********************************************************/
Äh form_timer  
 Ä DisplayDigitalClock()
ÄF


/***********************************************************

 * Description: Lock mouse scroll  
 Ä setSubMenuFocus Ä set focus in Äå menu
 * 
 * Params:

 * FromMouse : Numeric - char code of the mouse pressed
 * Created by: On 2009-05-16 03:47:17
 ***********************************************************/
Äh Form_KeyPress( Key, FromMouse )
 scroll_keypressed(key) 
 setSubMenuFocus(Key,4)
ÄF


/***********************************************************

 * Description: Fetch value from the camera(Reload the page)

 * Created by: vimala On 2009-05-19 11:39:43
 ***********************************************************/
Äh cmdCancel_Click  
 ÄB canReload = 1 Ä
 Ä loadDateTimeValues()
 Ä fetchDateTime() 
 Ä loadDefaultValues()
 #optsettime$ = ""
 ~changeFlag = 0  
 Ä drpFormat_Change() 
 ÄD
 Äd("rosubmenu[5]") 
ÄF



/***********************************************************

 * Description: Stop Ä1 of computer Ä
 
 * Created by: Vimala On 2010-05-03 13:07:41
 ***********************************************************/
Äh drphour_Click  
 stopTimerFlag = 0
ÄF

/***********************************************************

 * Description: Ä1 computer Ä 

 * Created by:Vimala  On 2010-05-03 13:09:51
 ***********************************************************/
Äh drphour_Blur  
 stopTimerFlag = 1
ÄF


/***********************************************************

 * Description: Ä1 computer Ä 

 * Created by:Vimala  On 2010-05-03 13:10:07
 ***********************************************************/
Äh drphour_Change  
 stopTimerFlag = 1
ÄF

/*
Äh Form_MouseMove( x, y )
 Ä0(0)
ÄF*/

Äh Form_MouseMove( x, y )
 ChangeMouseCursor(x, y)
ÄF


Äh optSetTime_Focus
 Ä∂(1)
ÄF

Äh optSetTime_Blur
 Ä∂(3)
ÄF

Äh chkdayLight_Focus
 Ä∂(1)
ÄF

Äh chkdayLight_Blur
 Ä∂(3)
ÄF


/***********************************************************

 * Description: Ä this Ä Ä check whether the control values are modified or not.
 * set ~changeFlag = 1 ÄB control value modified.

 * Created by: Vimala On 2010-04-30 18:01:13
 ***********************************************************/
Äh chkValueMismatch() 
 checkForModification(ctrlValues$, tempLabelName$)
ÄF

