/***************************************************************************************\
 * PROJECT NAME  : IPNC  * 
 * MODULE NAME  : Video Advanced Settings  *
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

option(4+1)


dimi timerCount
dimi flagMouseClick  //added by Frank on 15th July 2010//Ä trace the mouse click event when cursor not in activex control 

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




dims TabsImagesA$,TabsImagesB$,TabsImagesC$

dimi noofctrl  
noofctrl = Ä~()-25  
dims LabelName$(noofctrl) 
dimi XPos(noofctrl) 
dimi YPos(noofctrl) 
dimi Wdh(noofctrl) 
dimi height(noofctrl) 
 
LabelName$(0) = "lblSuccessMessage" : XPos(0) = 259: YPos(0) = 592: Wdh(0) = 460: Height(0) = 14
LabelName$(1) = "lblCamera" : XPos(1) = 257: YPos(1) = 82: Wdh(1) = 70: Height(1) = 14
LabelName$(2) = "cmdSave" : XPos(2) = 359: YPos(2) = 618: Wdh(2) = 82: Height(2) = 20
LabelName$(3) = "cmdCancel" : XPos(3) = 448: YPos(3) = 618: Wdh(3) = 80: Height(3) = 20
LabelName$(4) = "rocamera" : XPos(4) = 331: YPos(4) = 82: Wdh(4) = 114: Height(4) = -1
LabelName$(5) = "fradvanced" : XPos(5) = 257: YPos(5) = 146: Wdh(5) = 462: Height(5) = 407
LabelName$(6) = "frAdvStream1" : XPos(6) = 1090: YPos(6) = 125: Wdh(6) = 456: Height(6) = 368
LabelName$(7) = "gdobg" : XPos(7) = 735: YPos(7) = 177: Wdh(7) = 260: Height(7) = 149
LabelName$(8) = "frAdvStream3" : XPos(8) = 2049: YPos(8) = 108: Wdh(8) = 456: Height(8) = 368
LabelName$(9) = "frAdvStream2" : XPos(9) = 1583: YPos(9) = 109: Wdh(9) = 456: Height(9) = 368
LabelName$(10) = "btnBack" : XPos(10) = 536: YPos(10) = 618: Wdh(10) = 80: Height(10) = 20
LabelName$(11) = "lbldummy" : XPos(11) = 735: YPos(11) = 532: Wdh(11) = 80: Height(11) = 14
LabelName$(12) = "lblloading" : XPos(12) = 796: YPos(12) = 224: Wdh(12) = 137: Height(12) = 30
LabelName$(13) = "chkForceIFrame3" : XPos(13) = 2263: YPos(13) = 145: Wdh(13) = 20: Height(13) = 14
LabelName$(14) = "txtIPRatio3" : XPos(14) = 2261: YPos(14) = 119: Wdh(14) = 100: Height(14) = -1
LabelName$(15) = "txtMin3" : XPos(15) = 2340: YPos(15) = 177: Wdh(15) = 40: Height(15) = -1
LabelName$(16) = "txtMax3" : XPos(16) = 2448: YPos(16) = 177: Wdh(16) = 40: Height(16) = -1
LabelName$(17) = "drpMEConfig3" : XPos(17) = 2263: YPos(17) = 209: Wdh(17) = 104: Height(17) = -1
LabelName$(18) = "txtPacketSize3" : XPos(18) = 2258: YPos(18) = 239: Wdh(18) = 39: Height(18) = -1
LabelName$(19) = "chkFaceDetect3" : XPos(19) = 2073: YPos(19) = 333: Wdh(19) = 201: Height(19) = 14
LabelName$(20) = "txtreg1X3" : XPos(20) = 2182: YPos(20) = 388: Wdh(20) = 22: Height(20) = -1
LabelName$(21) = "txtreg1Y3" : XPos(21) = 2261: YPos(21) = 388: Wdh(21) = 22: Height(21) = -1
LabelName$(22) = "txtreg1wdt3" : XPos(22) = 2362: YPos(22) = 388: Wdh(22) = 22: Height(22) = -1
LabelName$(23) = "txtreg1hgt3" : XPos(23) = 2462: YPos(23) = 388: Wdh(23) = 22: Height(23) = -1
LabelName$(24) = "txtreg2X3" : XPos(24) = 2182: YPos(24) = 418: Wdh(24) = 22: Height(24) = -1
LabelName$(25) = "txtreg2Y3" : XPos(25) = 2261: YPos(25) = 418: Wdh(25) = 22: Height(25) = -1
LabelName$(26) = "txtreg2wdt3" : XPos(26) = 2361: YPos(26) = 418: Wdh(26) = 22: Height(26) = -1
LabelName$(27) = "txtreg2hgt3" : XPos(27) = 2462: YPos(27) = 418: Wdh(27) = 22: Height(27) = -1
LabelName$(28) = "txtreg3X3" : XPos(28) = 2182: YPos(28) = 447: Wdh(28) = 22: Height(28) = -1
LabelName$(29) = "txtreg3Y3" : XPos(29) = 2261: YPos(29) = 447: Wdh(29) = 22: Height(29) = -1
LabelName$(30) = "txtreg3wdt3" : XPos(30) = 2362: YPos(30) = 447: Wdh(30) = 22: Height(30) = -1
LabelName$(31) = "txtreg3hgt3" : XPos(31) = 2462: YPos(31) = 447: Wdh(31) = 22: Height(31) = -1
LabelName$(32) = "lblForceIFrame3" : XPos(32) = 2070: YPos(32) = 151: Wdh(32) = 106: Height(32) = 14
LabelName$(33) = "lblreg1hgt3" : XPos(33) = 2406: YPos(33) = 388: Wdh(33) = 46: Height(33) = 14
LabelName$(34) = "lblreg1wdt3" : XPos(34) = 2312: YPos(34) = 388: Wdh(34) = 36: Height(34) = 14
LabelName$(35) = "lblreg1Y3" : XPos(35) = 2233: YPos(35) = 388: Wdh(35) = 13: Height(35) = 14
LabelName$(36) = "lblIPRatio3" : XPos(36) = 2073: YPos(36) = 119: Wdh(36) = 80: Height(36) = 14
LabelName$(37) = "lblQPValue3" : XPos(37) = 2069: YPos(37) = 177: Wdh(37) = 55: Height(37) = 14
LabelName$(38) = "lblMax3" : XPos(38) = 2399: YPos(38) = 177: Wdh(38) = 35: Height(38) = 14
LabelName$(39) = "lblMEConfig3" : XPos(39) = 2069: YPos(39) = 209: Wdh(39) = 100: Height(39) = 17
LabelName$(40) = "lblMin3" : XPos(40) = 2299: YPos(40) = 177: Wdh(40) = 35: Height(40) = 14
LabelName$(41) = "lblPacketSize3" : XPos(41) = 2069: YPos(41) = 239: Wdh(41) = 80: Height(41) = 14
LabelName$(42) = "lblFrameData3" : XPos(42) = 2313: YPos(42) = 239: Wdh(42) = 127: Height(42) = 14
LabelName$(43) = "lblRegion23" : XPos(43) = 2061: YPos(43) = 418: Wdh(43) = 60: Height(43) = 14
LabelName$(44) = "lblRegion33" : XPos(44) = 2061: YPos(44) = 447: Wdh(44) = 60: Height(44) = 14
LabelName$(45) = "lblreg3hgt3" : XPos(45) = 2406: YPos(45) = 447: Wdh(45) = 46: Height(45) = 14
LabelName$(46) = "lblreg3wdt3" : XPos(46) = 2312: YPos(46) = 447: Wdh(46) = 36: Height(46) = 14
LabelName$(47) = "lblreg3Y3" : XPos(47) = 2233: YPos(47) = 447: Wdh(47) = 13: Height(47) = 14
LabelName$(48) = "lblreg2x3" : XPos(48) = 2157: YPos(48) = 418: Wdh(48) = 13: Height(48) = 14
LabelName$(49) = "lblreg3x3" : XPos(49) = 2157: YPos(49) = 447: Wdh(49) = 13: Height(49) = 14
LabelName$(50) = "lblreg2Y3" : XPos(50) = 2233: YPos(50) = 418: Wdh(50) = 13: Height(50) = 14
LabelName$(51) = "lblreg2wdt3" : XPos(51) = 2312: YPos(51) = 418: Wdh(51) = 36: Height(51) = 14
LabelName$(52) = "lblreg2hgt3" : XPos(52) = 2406: YPos(52) = 418: Wdh(52) = 46: Height(52) = 14
LabelName$(53) = "lblRegion13" : XPos(53) = 2061: YPos(53) = 388: Wdh(53) = 60: Height(53) = 14
LabelName$(54) = "lblreg1x3" : XPos(54) = 2157: YPos(54) = 388: Wdh(54) = 13: Height(54) = 14
LabelName$(55) = "btnConfigure3" : XPos(55) = 2261: YPos(55) = 333: Wdh(55) = 100: Height(55) = 20
LabelName$(56) = "txtInit3" : XPos(56) = 2244: YPos(56) = 177: Wdh(56) = 40: Height(56) = -1
LabelName$(57) = "lblInit3" : XPos(57) = 2195: YPos(57) = 177: Wdh(57) = 35: Height(57) = 13
LabelName$(58) = "txtIPRatio2" : XPos(58) = 1792: YPos(58) = 115: Wdh(58) = 100: Height(58) = -1
LabelName$(59) = "txtMin2" : XPos(59) = 1878: YPos(59) = 175: Wdh(59) = 40: Height(59) = -1
LabelName$(60) = "txtMax2" : XPos(60) = 1986: YPos(60) = 175: Wdh(60) = 40: Height(60) = -1
LabelName$(61) = "drpMEConfig2" : XPos(61) = 1794: YPos(61) = 207: Wdh(61) = 104: Height(61) = -1
LabelName$(62) = "txtPacketSize2" : XPos(62) = 1795: YPos(62) = 237: Wdh(62) = 39: Height(62) = -1
LabelName$(63) = "chkFaceDetect2" : XPos(63) = 1596: YPos(63) = 336: Wdh(63) = 205: Height(63) = 14
LabelName$(64) = "txtreg1X2" : XPos(64) = 1719: YPos(64) = 387: Wdh(64) = 22: Height(64) = -1
LabelName$(65) = "txtreg1Y2" : XPos(65) = 1785: YPos(65) = 387: Wdh(65) = 22: Height(65) = -1
LabelName$(66) = "txtreg1wdt2" : XPos(66) = 1881: YPos(66) = 387: Wdh(66) = 22: Height(66) = -1
LabelName$(67) = "txtreg1hgt2" : XPos(67) = 1983: YPos(67) = 388: Wdh(67) = 22: Height(67) = -1
LabelName$(68) = "txtreg2X2" : XPos(68) = 1719: YPos(68) = 417: Wdh(68) = 22: Height(68) = -1
LabelName$(69) = "lblMin2" : XPos(69) = 1837: YPos(69) = 175: Wdh(69) = 35: Height(69) = 14
LabelName$(70) = "lblMax2" : XPos(70) = 1937: YPos(70) = 175: Wdh(70) = 35: Height(70) = 14
LabelName$(71) = "chkForceIFrame2" : XPos(71) = 1794: YPos(71) = 143: Wdh(71) = 20: Height(71) = 14
LabelName$(72) = "lblMEConfig2" : XPos(72) = 1595: YPos(72) = 207: Wdh(72) = 100: Height(72) = 14
LabelName$(73) = "lblForceIFrame2" : XPos(73) = 1595: YPos(73) = 136: Wdh(73) = 106: Height(73) = 14
LabelName$(74) = "lblPacketSize2" : XPos(74) = 1593: YPos(74) = 237: Wdh(74) = 80: Height(74) = 14
LabelName$(75) = "lblQPValue2" : XPos(75) = 1594: YPos(75) = 175: Wdh(75) = 55: Height(75) = 14
LabelName$(76) = "lblFrameData2" : XPos(76) = 1848: YPos(76) = 237: Wdh(76) = 127: Height(76) = 14
LabelName$(77) = "lblreg2x2" : XPos(77) = 1696: YPos(77) = 417: Wdh(77) = 13: Height(77) = 14
LabelName$(78) = "lblreg1x2" : XPos(78) = 1696: YPos(78) = 387: Wdh(78) = 13: Height(78) = 14
LabelName$(79) = "lblRegion12" : XPos(79) = 1596: YPos(79) = 388: Wdh(79) = 60: Height(79) = 14
LabelName$(80) = "lblRegion22" : XPos(80) = 1596: YPos(80) = 418: Wdh(80) = 60: Height(80) = 14
LabelName$(81) = "lblreg1Y2" : XPos(81) = 1763: YPos(81) = 387: Wdh(81) = 13: Height(81) = 14
LabelName$(82) = "lblreg1wdt2" : XPos(82) = 1834: YPos(82) = 387: Wdh(82) = 36: Height(82) = 14
LabelName$(83) = "lblreg1hgt2" : XPos(83) = 1928: YPos(83) = 388: Wdh(83) = 46: Height(83) = 14
LabelName$(84) = "lblIPRatio2" : XPos(84) = 1595: YPos(84) = 115: Wdh(84) = 80: Height(84) = 14
LabelName$(85) = "btnConfigure2" : XPos(85) = 1829: YPos(85) = 336: Wdh(85) = 100: Height(85) = 20
LabelName$(86) = "txtreg2Y2" : XPos(86) = 1785: YPos(86) = 417: Wdh(86) = 22: Height(86) = -1
LabelName$(87) = "txtreg2wdt2" : XPos(87) = 1881: YPos(87) = 417: Wdh(87) = 22: Height(87) = -1
LabelName$(88) = "txtreg2hgt2" : XPos(88) = 1983: YPos(88) = 418: Wdh(88) = 22: Height(88) = -1
LabelName$(89) = "txtreg3X2" : XPos(89) = 1719: YPos(89) = 447: Wdh(89) = 22: Height(89) = -1
LabelName$(90) = "txtreg3Y2" : XPos(90) = 1785: YPos(90) = 447: Wdh(90) = 22: Height(90) = -1
LabelName$(91) = "txtreg3wdt2" : XPos(91) = 1881: YPos(91) = 447: Wdh(91) = 22: Height(91) = -1
LabelName$(92) = "txtreg3hgt2" : XPos(92) = 1983: YPos(92) = 447: Wdh(92) = 22: Height(92) = -1
LabelName$(93) = "lblRegion32" : XPos(93) = 1596: YPos(93) = 447: Wdh(93) = 60: Height(93) = 14
LabelName$(94) = "lblreg3X2" : XPos(94) = 1696: YPos(94) = 447: Wdh(94) = 13: Height(94) = 14
LabelName$(95) = "lblreg3Y2" : XPos(95) = 1763: YPos(95) = 447: Wdh(95) = 13: Height(95) = 14
LabelName$(96) = "lblreg2Y2" : XPos(96) = 1763: YPos(96) = 417: Wdh(96) = 13: Height(96) = 14
LabelName$(97) = "lblreg2wdt2" : XPos(97) = 1834: YPos(97) = 417: Wdh(97) = 36: Height(97) = 14
LabelName$(98) = "lblreg3wdt2" : XPos(98) = 1834: YPos(98) = 447: Wdh(98) = 36: Height(98) = 14
LabelName$(99) = "lblreg2hgt2" : XPos(99) = 1928: YPos(99) = 418: Wdh(99) = 46: Height(99) = 14
LabelName$(100) = "lblreg3hgt2" : XPos(100) = 1928: YPos(100) = 447: Wdh(100) = 46: Height(100) = 14
LabelName$(101) = "txtInit2" : XPos(101) = 1785: YPos(101) = 175: Wdh(101) = 40: Height(101) = -1
LabelName$(102) = "lblInit2" : XPos(102) = 1741: YPos(102) = 175: Wdh(102) = 35: Height(102) = 13
LabelName$(103) = "btnConfigure1" : XPos(103) = 1320: YPos(103) = 350: Wdh(103) = 100: Height(103) = 20
LabelName$(104) = "lblForceIFrame1" : XPos(104) = 1108: YPos(104) = 182: Wdh(104) = 133: Height(104) = 14
LabelName$(105) = "txtIPRatio1" : XPos(105) = 1251: YPos(105) = 145: Wdh(105) = 103: Height(105) = -1
LabelName$(106) = "txtMin1" : XPos(106) = 1389: YPos(106) = 220: Wdh(106) = 40: Height(106) = -1
LabelName$(107) = "txtMax1" : XPos(107) = 1489: YPos(107) = 220: Wdh(107) = 40: Height(107) = -1
LabelName$(108) = "drpMEConfig1" : XPos(108) = 1251: YPos(108) = 259: Wdh(108) = 107: Height(108) = -1
LabelName$(109) = "txtPacketSize1" : XPos(109) = 1251: YPos(109) = 297: Wdh(109) = 41: Height(109) = -1
LabelName$(110) = "lblMin1" : XPos(110) = 1349: YPos(110) = 220: Wdh(110) = 35: Height(110) = 14
LabelName$(111) = "lblMax1" : XPos(111) = 1445: YPos(111) = 220: Wdh(111) = 35: Height(111) = 14
LabelName$(112) = "lblQPValue1" : XPos(112) = 1108: YPos(112) = 220: Wdh(112) = 58: Height(112) = 14
LabelName$(113) = "lblIPRatio1" : XPos(113) = 1108: YPos(113) = 145: Wdh(113) = 83: Height(113) = 14
LabelName$(114) = "lblMEConfig1" : XPos(114) = 1108: YPos(114) = 259: Wdh(114) = 100: Height(114) = 14
LabelName$(115) = "lblPacketSize1" : XPos(115) = 1108: YPos(115) = 297: Wdh(115) = 83: Height(115) = 14
LabelName$(116) = "lblFrameData1" : XPos(116) = 1313: YPos(116) = 297: Wdh(116) = 130: Height(116) = 14
LabelName$(117) = "chkForceIFrame1" : XPos(117) = 1246: YPos(117) = 182: Wdh(117) = 23: Height(117) = 14
LabelName$(118) = "chkFaceDetect1" : XPos(118) = 1103: YPos(118) = 350: Wdh(118) = 193: Height(118) = 14
LabelName$(119) = "txtreg1X1" : XPos(119) = 1224: YPos(119) = 386: Wdh(119) = 25: Height(119) = -1
LabelName$(120) = "txtreg1Y1" : XPos(120) = 1299: YPos(120) = 386: Wdh(120) = 25: Height(120) = -1
LabelName$(121) = "txtreg1wdt1" : XPos(121) = 1395: YPos(121) = 386: Wdh(121) = 25: Height(121) = -1
LabelName$(122) = "txtreg1hgt1" : XPos(122) = 1500: YPos(122) = 386: Wdh(122) = 25: Height(122) = -1
LabelName$(123) = "txtreg2X1" : XPos(123) = 1224: YPos(123) = 422: Wdh(123) = 25: Height(123) = -1
LabelName$(124) = "txtreg2Y1" : XPos(124) = 1299: YPos(124) = 422: Wdh(124) = 25: Height(124) = -1
LabelName$(125) = "txtreg2wdt1" : XPos(125) = 1395: YPos(125) = 422: Wdh(125) = 25: Height(125) = -1
LabelName$(126) = "txtreg2hgt1" : XPos(126) = 1500: YPos(126) = 422: Wdh(126) = 25: Height(126) = -1
LabelName$(127) = "txtreg3X1" : XPos(127) = 1224: YPos(127) = 458: Wdh(127) = 25: Height(127) = -1
LabelName$(128) = "txtreg3Y1" : XPos(128) = 1299: YPos(128) = 458: Wdh(128) = 25: Height(128) = -1
LabelName$(129) = "txtreg3wdt1" : XPos(129) = 1395: YPos(129) = 458: Wdh(129) = 25: Height(129) = -1
LabelName$(130) = "txtreg3hgt1" : XPos(130) = 1500: YPos(130) = 458: Wdh(130) = 25: Height(130) = -1
LabelName$(131) = "lblRegion11" : XPos(131) = 1108: YPos(131) = 386: Wdh(131) = 62: Height(131) = 14
LabelName$(132) = "lblreg1x1" : XPos(132) = 1195: YPos(132) = 386: Wdh(132) = 16: Height(132) = 14
LabelName$(133) = "lblreg1Y1" : XPos(133) = 1271: YPos(133) = 386: Wdh(133) = 16: Height(133) = 14
LabelName$(134) = "lblRegion31" : XPos(134) = 1108: YPos(134) = 458: Wdh(134) = 63: Height(134) = 14
LabelName$(135) = "lblreg1wdt1" : XPos(135) = 1348: YPos(135) = 386: Wdh(135) = 38: Height(135) = 14
LabelName$(136) = "lblreg3x1" : XPos(136) = 1195: YPos(136) = 458: Wdh(136) = 16: Height(136) = 14
LabelName$(137) = "lblreg1hgt1" : XPos(137) = 1449: YPos(137) = 386: Wdh(137) = 43: Height(137) = 14
LabelName$(138) = "lblreg3Y1" : XPos(138) = 1271: YPos(138) = 458: Wdh(138) = 16: Height(138) = 14
LabelName$(139) = "lblreg3wdt1" : XPos(139) = 1348: YPos(139) = 458: Wdh(139) = 38: Height(139) = 14
LabelName$(140) = "lblreg3hgt1" : XPos(140) = 1449: YPos(140) = 458: Wdh(140) = 43: Height(140) = 14
LabelName$(141) = "lblRegion21" : XPos(141) = 1108: YPos(141) = 422: Wdh(141) = 63: Height(141) = 14
LabelName$(142) = "lblreg2x1" : XPos(142) = 1195: YPos(142) = 422: Wdh(142) = 16: Height(142) = 14
LabelName$(143) = "lblreg2Y1" : XPos(143) = 1271: YPos(143) = 422: Wdh(143) = 16: Height(143) = 14
LabelName$(144) = "lblreg2wdt1" : XPos(144) = 1348: YPos(144) = 422: Wdh(144) = 38: Height(144) = 14
LabelName$(145) = "lblreg2hgt1" : XPos(145) = 1449: YPos(145) = 422: Wdh(145) = 43: Height(145) = 14
LabelName$(146) = "lblInit1" : XPos(146) = 1246: YPos(146) = 220: Wdh(146) = 35: Height(146) = 13
LabelName$(147) = "txtInit1" : XPos(147) = 1291: YPos(147) = 220: Wdh(147) = 40: Height(147) = -1
LabelName$(148) = "frmRegOfInterest" : XPos(148) = 1203: YPos(148) = 586: Wdh(148) = 597: Height(148) = 437
LabelName$(149) = "lblregInt" : XPos(149) = 1203: YPos(149) = 588: Wdh(149) = 578: Height(149) = 26
LabelName$(150) = "btnROI_Save" : XPos(150) = 1457: YPos(150) = 993: Wdh(150) = 100: Height(150) = 20
LabelName$(151) = "btnROI_Cancel" : XPos(151) = 1571: YPos(151) = 993: Wdh(151) = 100: Height(151) = 20
LabelName$(152) = "drpRegion1" : XPos(152) = 1219: YPos(152) = 878: Wdh(152) = 70: Height(152) = -1
LabelName$(153) = "txtX1" : XPos(153) = 1364: YPos(153) = 878: Wdh(153) = 40: Height(153) = -1
LabelName$(154) = "txtY1" : XPos(154) = 1460: YPos(154) = 878: Wdh(154) = 40: Height(154) = -1
LabelName$(155) = "lblX1" : XPos(155) = 1320: YPos(155) = 878: Wdh(155) = 23: Height(155) = 14
LabelName$(156) = "lblX2" : XPos(156) = 1320: YPos(156) = 909: Wdh(156) = 20: Height(156) = 14
LabelName$(157) = "lblX3" : XPos(157) = 1320: YPos(157) = 940: Wdh(157) = 15: Height(157) = 14
LabelName$(158) = "lblY1" : XPos(158) = 1421: YPos(158) = 878: Wdh(158) = 24: Height(158) = 14
LabelName$(159) = "lblY2" : XPos(159) = 1421: YPos(159) = 909: Wdh(159) = 27: Height(159) = 14
LabelName$(160) = "lblY3" : XPos(160) = 1421: YPos(160) = 940: Wdh(160) = 20: Height(160) = 14
LabelName$(161) = "txtW1" : XPos(161) = 1567: YPos(161) = 878: Wdh(161) = 40: Height(161) = -1
LabelName$(162) = "lblW1" : XPos(162) = 1525: YPos(162) = 878: Wdh(162) = 24: Height(162) = 14
LabelName$(163) = "lblH1" : XPos(163) = 1630: YPos(163) = 878: Wdh(163) = 19: Height(163) = 14
LabelName$(164) = "txtH1" : XPos(164) = 1675: YPos(164) = 878: Wdh(164) = 40: Height(164) = -1
LabelName$(165) = "btnDelete1" : XPos(165) = 1729: YPos(165) = 878: Wdh(165) = 56: Height(165) = 20
LabelName$(166) = "btnDelete2" : XPos(166) = 1729: YPos(166) = 909: Wdh(166) = 56: Height(166) = 20
LabelName$(167) = "txtH2" : XPos(167) = 1675: YPos(167) = 909: Wdh(167) = 39: Height(167) = -1
LabelName$(168) = "lblH2" : XPos(168) = 1629: YPos(168) = 909: Wdh(168) = 20: Height(168) = 14
LabelName$(169) = "txtW2" : XPos(169) = 1567: YPos(169) = 909: Wdh(169) = 40: Height(169) = -1
LabelName$(170) = "lblW2" : XPos(170) = 1525: YPos(170) = 909: Wdh(170) = 22: Height(170) = 14
LabelName$(171) = "txtY2" : XPos(171) = 1460: YPos(171) = 909: Wdh(171) = 40: Height(171) = -1
LabelName$(172) = "txtX2" : XPos(172) = 1364: YPos(172) = 909: Wdh(172) = 40: Height(172) = -1
LabelName$(173) = "drpRegion2" : XPos(173) = 1219: YPos(173) = 909: Wdh(173) = 70: Height(173) = -1
LabelName$(174) = "drpRegion3" : XPos(174) = 1219: YPos(174) = 940: Wdh(174) = 70: Height(174) = -1
LabelName$(175) = "txtX3" : XPos(175) = 1364: YPos(175) = 940: Wdh(175) = 40: Height(175) = -1
LabelName$(176) = "txtY3" : XPos(176) = 1460: YPos(176) = 940: Wdh(176) = 40: Height(176) = -1
LabelName$(177) = "lblW3" : XPos(177) = 1525: YPos(177) = 940: Wdh(177) = 26: Height(177) = 14
LabelName$(178) = "txtW3" : XPos(178) = 1567: YPos(178) = 940: Wdh(178) = 40: Height(178) = -1
LabelName$(179) = "lblH3" : XPos(179) = 1629: YPos(179) = 940: Wdh(179) = 20: Height(179) = 14
LabelName$(180) = "btnDelete3" : XPos(180) = 1729: YPos(180) = 940: Wdh(180) = 56: Height(180) = 20
LabelName$(181) = "txtH3" : XPos(181) = 1675: YPos(181) = 940: Wdh(181) = 40: Height(181) = -1
LabelName$(182) = "btnrefresh" : XPos(182) = 1325: YPos(182) = 993: Wdh(182) = 122: Height(182) = 20
LabelName$(183) = "lblInterest" : XPos(183) = 1221: YPos(183) = 593: Wdh(183) = 126: Height(183) = 14
LabelName$(184) = "lblErrMsg" : XPos(184) = 1209: YPos(184) = 968: Wdh(184) = 588: Height(184) = 14
LabelName$(185) = "lblBg" : XPos(185) = 1252: YPos(185) = 642: Wdh(185) = 319: Height(185) = 126
dimi gdoWidth
dimi gdoHeight
dimi rule  
dimi noOfTabs  
dimi MsgColorFlag=-1
dimi ErrorROIFlag=0  
dimi FocusFlag=0  
dims stream$(3),rtspUrl$(3)

Ä(1000) 
dimi validateFlag  
validateFlag =1  
dimi jpegStream
dimi displayCount,isMessageDisplayed  
displayCount = 1  

dims ctrlValues$(noofctrl),tempLabelName$(noofctrl)
dimi animateCount = 0  
dimi saveSuccess = 0  
dims error$ = ""  
Ä


/***********************************************************

 * Description:Ä align the control's X,Y position with 
 respect Ä the Resolution in all tabs

 * Created by: Vimala On 2009-05-12 05:55:42
 ***********************************************************/
Äh alignCtrls(dimi tabno)
 dims ctrlname$(45) = ("lblForceIFrame","lblMin","lblMax","lblInit","txtInit","lblQPValue","chkForceIFrame","txtMin", _
 "txtMax","txtIPRatio","lblIPRatio","lblMEConfig","lblPacketSize","txtPacketSize", _
 "drpMEConfig","lblFrameData","chkFaceDetect","txtreg1hgt","lblRegion1", _
 "txtreg2hgt","lblreg1x","txtreg1X","txtreg3wdt","lblreg1Y","txtreg1Y","lblRegion3","lblreg1wdt", _
 "txtreg1wdt","lblreg3x","lblreg1hgt","txtreg3Y","lblreg3Y","txtreg3X","lblreg3wdt","lblreg3hgt", _
 "lblRegion2","txtreg3hgt","lblreg2x","txtreg2X","lblreg2Y","txtreg2Y","lblreg2wdt","txtreg2wdt", _
 "lblreg2hgt","btnConfigure")
 
 dimi i,ctrlLen
 dims controlName$,tempctrl$,tempctrl1$,temp$
 Ä i = 0 Ä ÄÇ(ctrlname$) 
 controlName$ = ctrlname$(i)+tabno  
 tempctrl$ = ctrlname$(i)+"1"  
 
 ÄB Ä&(ctrlname$(i),"opt")>=0 Ä
 temp$ = Äç(ctrlname$(i),3)
 ctrlLen = Ä (ctrlname$(i))
 tempctrl$ = Äå(ctrlname$(i),ctrlLen-3)+tabno+temp$
 tempctrl1$ = Äå(ctrlname$(i),ctrlLen-3)+1+temp$
 controlName$ = tempctrl$ 
 tempctrl$ = tempctrl1$
 ÄD
 
 #{controlName$}.x = #{tempctrl$}.x
 #{controlName$}.y = #{tempctrl$}.y
 #{controlName$}.w = #{tempctrl$}.w 
 
 Ä
 
ÄF



/***********************************************************

 * Description:Ä set wait flag when switching between forms
 * Display save success message Ä 5 secs
 
 * Created by: Franklin On 2009-06-30 16:14:12

 ***********************************************************/
Äh form_timer
 ~wait = ~wait +1  
 
 
 ÄB isMessageDisplayed = 1 Ä  
 displayCount++
 ÄB displayCount = 5 Ä  
 isMessageDisplayed = 0
 displayCount = 1
 #lblsuccessmessage$ = ""
 Ä  
 ÄD
 ÄD  
 
 ÄB canReload = 0 Ä
 ÄB animateCount <= ~reLoadTime Ä
 animateCount ++
 animateLabel("lblLoading","Updating") 
 ÄC
 Ä displaySaveStatus(saveSuccess)
 ÄD
 ÄD
 
ÄF


/***********************************************************

 * Description: 
 * Ä set the Initial values Ä all the controls
 * 
 * Functions/Methods: getVideoImageAdvanced1()- Ä set the values Ä the stream1 
 getVideoImageAdvanced2()- Ä set the values Ä the stream2
 getVideoImageAdvanced3()- Ä set the values Ä the stream3
 
 * Created by: Franklin Jacques  On 2009-05-11 16:27:17
 ***********************************************************/
Äh setInitialValues()
 dimi ret1,ret2,ret3,ret4
 dims ddValue$
 
 
 dims ipratio1$,qpmin1$,qpmax1$,meconfigname$,packetsize1$
 dimi forceIframe1,regionofinterestenable1,meconfig1,str1x1,str1y1,str1w1,str1h1,str1x2,str1y2,str1w2,str1h2,str1x3,str1y3,str1w3,str1h3
 dimi qpinit1  
 
 dims ipratio2$,qpmin2$,qpmax2$,packetsize2$
 dimi forceIframe2,regionofinterestenable2,meconfig2
 dimi str2x1,str2y1,str2w1,str2h1,str2x2,str2y2,str2w2,str2h2,str2x3,str2y3,str2w3,str2h3  
 dimi qpinit2  
 
 dims ipratio3$,qpmin3$,qpmax3$,packetsize3$  
 dimi forceIframe3,regionofinterestenable3,meconfig3
 dimi str3x1,str3y1,str3w1,str3h1,str3x2,str3y2,str3w2,str3h2,str3x3,str3y3,str3w3,str3h3  
 dimi qpinit3  
 
 
 ret1=getVideoImageAdvanced1(ipratio1$,forceIframe1,qpmin1$,qpmax1$,meconfig1,meconfigname$,_
 packetsize1$,regionofinterestenable1,str1x1,str1y1,str1w1,str1h1,_
 str1x2,str1y2,str1w2,str1h2,str1x3,str1y3,str1w3,str1h3,qpinit1) 
 
 ret2=getVideoImageAdvanced2(ipratio2$,forceIframe2,qpmin2$,qpmax2$,meconfig2,_
 packetsize2$,regionofinterestenable2,str2x1,str2y1,_
 str2w1,str2h1,str2x2,str2y2,str2w2,str2h2,str2x3,_
 str2y3,str2w3,str2h3,qpinit2) 
 
 ret3=getVideoImageAdvanced3(ipratio3$,forceIframe3,qpmin3$,qpmax3$,meconfig3,_
 packetsize3$,regionofinterestenable3,str3x1,str3y1,_
 str3w1,str3h1,str3x2,str3y2,str3w2,str3h2,str3x3,_
 str3y3,str3w3,str3h3,qpinit3) 
 
 
 #rocamera$ = ~title$
 #txtIPRatio1$=ipratio1$  
 #chkForceIFrame1$= forceIframe1  
 #txtinit1$ = qpinit1
 #txtMin1$=qpmin1$  
 #txtMax1$=qpmax1$  
 Ä<(ddValue$,meconfigname$,";")
 Ä addItemsToDropDown("drpMEConfig1", ddValue$, meconfig1) 
 #txtPacketSize1$= packetsize1$  
 #chkFaceDetect1$=regionofinterestenable1  
 #txtreg1X1$=str1x1  
 #txtreg1Y1$=str1y1  
 #txtreg1wdt1$=str1w1  
 #txtreg1hgt1$=str1h1  
 #txtreg2X1$=str1x2  
 #txtreg2Y1$=str1y2  
 #txtreg2wdt1$=str1w2  
 #txtreg2hgt1$=str1h2  
 #txtreg3X1$=str1x3  
 #txtreg3Y1$=str1y3  
 #txtreg3wdt1$=str1w3  
 #txtreg3hgt1$=str1h3
 
 #txtIPRatio2$=ipratio2$  
 #chkForceIFrame2$= forceIframe2 
 #txtinit2$ = qpinit2  
 #txtMin2$=qpmin2$  
 #txtMax2$=qpmax2$  
 Ä<(ddValue$,meconfigname$,";")
 Ä addItemsToDropDown("drpMEConfig2", ddValue$, meconfig2) 
 #txtpacketsize2$= packetsize2$  
 #chkFaceDetect2$=regionofinterestenable2  
 #txtreg1X2$=str2x1  
 #txtreg1Y2$=str2y1  
 #txtreg1wdt2$=str2w1  
 #txtreg1hgt2$=str2h1  
 #txtreg2X2$=str2x2  
 #txtreg2Y2$=str2y2  
 #txtreg2wdt2$=str2w2  
 #txtreg2hgt2$=str2h2  
 #txtreg3X2$=str2x3  
 #txtreg3Y2$=str2y3  
 #txtreg3wdt2$=str2w3  
 #txtreg3hgt2$=str2h3  
 
 #txtIPRatio3$=ipratio3$  
 #chkForceIFrame3$= forceIframe3  
 #txtinit3$ = qpinit3
 #txtMin3$=qpmin3$  
 #txtMax3$=qpmax3$  
 Ä<(ddValue$,meconfigname$,";")
 Ä addItemsToDropDown("drpMEConfig3", ddValue$, meconfig3) 
 #txtpacketsize3$= packetsize3$  
 #chkFaceDetect3$=regionofinterestenable3  
 #txtreg1X3$=str3x1  
 #txtreg1Y3$=str3y1  
 #txtreg1wdt3$=str3w1  
 #txtreg1hgt3$=str3h1  
 #txtreg2X3$=str3x2  
 #txtreg2Y3$=str3y2  
 #txtreg2wdt3$=str3w2  
 #txtreg2hgt3$=str3h2  
 #txtreg3X3$=str3x3  
 #txtreg3Y3$=str3y3  
 #txtreg3wdt3$=str3w3  
 #txtreg3hgt3$=str3h3  
 
ÄF


/***********************************************************

 * Description: 
 loadIniValues() - Fetch values Ä keyword from ini.htm.  
 setInitialValues() - Get values Ä all screen controls
 displayControls - Display controls based on the screen resolution .
 loadStreamDetails - Get stream names and rtsp url values
 createGDOControl - Create video player based on the stream resolution aspect ratio
 alignGDOCtrl - align gdo control
 addTabImage - display tab image
 showSubMenu - Ä display setting menu
 selectSubMenu - Highlight selected setting screen  

 * Created by: Franklin Jacques.k On 2009-04-10 15:08:03
 ***********************************************************/
Äh Form_Load  
 dimi ret  
 dimi retVal
 retVal = loadIniValues()
 
 ÄB ~maxPropIndex = 0 Ä 
 Ä("Unable to load initial values.")
 Ä_("!auth.frm")
 ÄD  

 Ä setInitialValues  
 loadStreamDetails(stream$,rtspUrl$) 
 
 Ä displayControls(LabelName$,XPos,YPos,Wdh,height)
 createGDOControl("gdoVideo", GDO_X, GDO_Y, GDO_W, GDO_H)
 createGDOControl("gdoVideoROI",GDO_X, GDO_Y, GDO_W, GDO_H)
 Ä alignGDOCtrl(0)
 
 noOfTabs = Ä(ÄÉ("noOfTabs"))
 
 ret = #fradvanced.addtab("frAdvStream1","Stream 1")
 
 ÄB noOfTabs = 2 Ä
 ret = #fradvanced.addtab("frAdvStream2","Stream 2")
 Äy noOfTabs = 3 Ä
 ret = #fradvanced.addtab("frAdvStream2","Stream 2")
 ret = #fradvanced.addtab("frAdvStream3","Stream 3") 
 ÄD  
 
 Ä addTabImage()
 showSubMenu(0,1)
 Äd("rosubmenu")
 selectSubMenu()
 #lblheading$ = "Video > Advanced"
 Äd("txtipratio1")
 chkFaceDetect1_click
 #lblloading.hidden = 1
 #lblErrMsg.hidden = 1  
 
 #lblsuccessmessage$ = ""  
 isMessageDisplayed = Ä(ÄÉ("isMessageDisplayed"))
 ÄB isMessageDisplayed = 1 Ä
 #lblsuccessmessage$ = "Video - Advanced setting saved to camera "+~title$  
 ÄD  
ÄF


/***********************************************************

 * Description: 
 * Ä align the GDO control with respect Ä the current stream aspect ratio.

 * Created by: Franklin Jacques.k On 2009-09-30 09:59:52

 ***********************************************************/
Äh alignGDOCtrl(dimi streamNo)
 dimi gdoCurX, gdoCurY, gdoCurWidth, gdoCurHeight
 Dimi xRatio,yRatio  
 ~previewVideoRes$ = stream$(streamNo)
 
 #fradvstream1.w = #lbldummy.x - #fradvanced.x - 16
 #fradvstream2.w = #lbldummy.x - #fradvanced.x - 16
 #fradvstream3.w = #lbldummy.x - #fradvanced.x - 16
 #fradvanced.w = #lbldummy.x - #fradvanced.x - 14
 #fradvstream1.h = #lbldummy.y - #fradvanced.y -20
 #fradvstream2.h = #lbldummy.y - #fradvanced.y -20
 #fradvstream3.h = #lbldummy.y - #fradvanced.y -20
 #fradvanced.h = #fradvstream1.h + 40
 
 Ä "~previewVideoRes$ = " + ~previewVideoRes$
 calVideoDisplayRatio(~previewVideoRes$,xRatio,yRatio) 
 gdoCurX = GDO_X * ~factorX
 gdoCurY = GDO_Y * ~factorY
 gdoCurWidth  = 256 * ~factorX
 gdoCurHeight = 200 * ~factorY  
 checkAspectRatio(gdoCurWidth, gdoCurHeight,xRatio,yRatio)
 #gdobg.x=gdoCurX-1
 #gdobg.y=gdoCurY-1
 #gdobg.w = gdoCurWidth+1 
 #gdobg.h = gdoCurHeight+1  
 #gdoVideo.x = gdoCurX
 #gdoVideo.y = gdoCurY
 #gdoVideo.w = gdoCurWidth
 #gdoVideo.h = gdoCurHeight  
 #frmregofinterest.x = #fradvanced.x
 #frmregofinterest.y = #fradvanced.y 
 #frmregofinterest.h = (#btnrefresh.y  - #frmregofinterest.y) + #btnrefresh.h + 10
 #lblregInt.y = #fradvanced.y + 2
 #lblregInt.w = #frmregofinterest.w  - 20
 #lblInterest.y = #lblregInt.y+2
 #frmregofinterest.bg = 4358
 gdoCurWidth  = #frmregofinterest.w 
 gdoCurHeight  = #drpregion1.y - (#lblregInt.y + #lblregInt.h + #drpregion1.h+10)
 checkAspectRatio(gdoCurWidth, gdoCurHeight,xRatio,yRatio)
 #gdoVideoROI.x = #frmregofinterest.x+(#frmregofinterest.w-gdoCurWidth)/2
 #gdoVideoROI.y = #lblregint.y+#lblregint.h+15
 #gdoVideoROI.w = gdoCurWidth
 #gdoVideoROI.w = gdoCurWidth
 #gdoVideoROI.h = gdoCurHeight  
 #lblbg.x = (#frmregofinterest.x+(#frmregofinterest.w-gdoCurWidth)/2) -4
 #lblbg.y = #lblregint.y+#lblregint.h+11
 #lblbg.w = gdoCurWidth+7
 #lblbg.h = gdoCurHeight+7
 gdoWidth = gdoCurWidth
 gdoHeight = gdoCurHeight
 #gdoVideo.Audio = 0  
 #gdoVideoROI.totregion = 3  
 #gdoVideoROI.UIMode=2
 #gdoVideoROI.hidden=1
 #gdoVideoROI.Audio=1
 #frmregofinterest.hidden=1
 
 #gdoVideo.paint(1) 
ÄF



/***********************************************************

 * Description: 
 * Ä align the controls during the frame change event 
 * 
 * Methods : alignCtrls- Ä align the controls of the current frame
 
 * Created by:Franklin Jacques On 2009-05-12 06:14:35
 * History: 
 ***********************************************************/
Äh fradvanced_change
 Dimi a, ret 
 Dims url$, value$

 Ä alignGDOCtrl(#fradvanced.curtab)
 ÄB #fradvanced.curtab = 0 Ä
 alignCtrls(1)
 chkFaceDetect1_click
 Ä validateFlag = 1 Ä Äd("txtipratio1") 
 Äy #fradvanced.curtab = 1 Ä
 alignCtrls(2)
 chkFaceDetect2_click
 Ä validateFlag = 1 Ä Äd("txtipratio2") 
 Äy #fradvanced.curtab = 2 Ä
 alignCtrls(3)
 chkFaceDetect3_click
 Ä validateFlag = 1 Ä Äd("txtipratio3") 
 ÄD
 a = #gdoVideo.stop(1)
 ÄŸ(2)
 value$ = rtspUrl$(#fradvanced.curtab) 
 a=#gdoVideo.Play(value$) //godVideoROI-gdo control Ä region of interest
 #gdoVideo.hidden=0
 Ä∂(3)
 checkForJpegStream()
 SETOSVAR("*FLUSHEVENTS", "") // Added By Rajan
ÄF


/***********************************************************

 * Description: 
 * Set the properties Ä gdo video control Ä play rtsp stream
 
 * Created by: Franklin Jacques On 2009-03-03 16:02:27
 
 ***********************************************************/
Äh Form_complete
 ~wait = 0
 
 
 dimi i
 Ä i = 0 Ä ÄÇ(ctrlValues$)
 Ä LabelName$(i) = "lblIPRatio1" or LabelName$(i) = "lblIPRatio2" or LabelName$(i) = "lblIPRatio3" Ä continue
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
 
 Ä alignGDOCtrl(#fradvanced.curtab) 
 Ä disp_streams() 
 Ä∂(3)
 Ä
 SETOSVAR("*FLUSHEVENTS", "")
ÄF

/***********************************************************

 * Description: 
 * Ä set the URL Ä the GDO Control

 * Created by: Franklin Jacques  On 2009-07-31 19:01:44
 * History: 
 ***********************************************************/
Äh disp_streams()
 dims url$,value$
 dimi ret,a  
 value$ = rtspUrl$(#fradvanced.curtab) 
 a = #gdovideo.play(value$)
 #gdovideo.hidden = 0
 
 checkForJpegStream()
 
ÄF

/***********************************************************

 * Description: ÄB stream is jpeg Ä display message and hide all controls

 * Created by: On 2009-11-06 18:23:52
 ***********************************************************/
Äh checkForJpegStream()
 
 dims ctrlName$,tempName$
 dimi sNo,spltCount,i
 spltCount = noOfTabs 
 Ä i = 0 Ä spltCount-1
 Ä rtspUrl$(i)
 ÄB Ä&(Ä7(rtspUrl$(i)),"JPEG") > 0  Ä  
 sNo = i+1
 jpegStream = sNo  
 ÄB #fradvanced.curtab = jpegStream-1 Ä 
 ctrlName$ = "frAdvStream"+sNo
 #{ctrlName$}.disabled = 1
 #{ctrlName$}.hidden = 1
 tempName$ = "lblipratio"+sNo
 #{tempName$}.hidden = 0  
 #{tempName$}$ = "No Advanced Setting for JPEG is available in this version"
 #{tempName$}.w = 400
 #{tempName$}.x = #lblipratio1.x + #frAdvStream1.w/5
 #{tempName$}.y = #fradvanced.y + #fradvanced.h/3
 #{tempName$}.font = 10
 Ä∂(0)
 ÄD
 ÄD
 Ä
ÄF



/***********************************************************

 * Description: 
 * Load initial values from camera
 * 
 * Methods: Ä set the Initial Values Ä the VideoImageAdvanced setting
 * Created by:Franklin Jacques.k  On 2009-04-16 14:20:12

 ***********************************************************/
Äh cmdCancel_Click  
 ÄB canReload = 1 Ä
 ~changeFlag = 0  
 Ä setInitialValues() 
 chkFaceDetect1_click()
 ÄD
 Äd("rosubmenu[0]") 
ÄF


/***********************************************************

 * Description: shows or hide region of interest controls
 
 * Created by: Franklin Jacques On 2009-06-10 10:44:50
***********************************************************/
Äh chkFaceDetect1_click  
 
 ÄB #chkfacedetect1$ = "1" Ä
 #btnconfigure1.disabled = 0
 showAllRegionCtrls(0,1)
 ÄC
 #btnconfigure1.disabled = 1
 showAllRegionCtrls(1,1)
 ÄD
 
ÄF

/***********************************************************

 * Description: shows or hide region of interest controls
 
 * Created by: Franklin Jacques On 2009-06-10 10:46:48

 ***********************************************************/
Äh chkFaceDetect2_click  
 
 ÄB #chkfacedetect2$ = "1" Ä
 #btnconfigure2.disabled = 0
 showAllRegionCtrls(0,2)
 ÄC
 #btnconfigure2.disabled = 1
 showAllRegionCtrls(1,2)
 ÄD
 
ÄF


/***********************************************************

 * Description: shows or hide region of interest controls
 
 * Created by: Franklin Jacques On 2009-06-10 10:46:56

 ***********************************************************/
Äh chkFaceDetect3_click  
 
 ÄB #chkfacedetect3$ = "1" Ä
 #btnconfigure3.disabled = 0
 showAllRegionCtrls(0,3)
 ÄC
 #btnconfigure3.disabled = 1
 showAllRegionCtrls(1,3)
 ÄD
 
ÄF

/***********************************************************

 * Description: 
 * Ä display all the region controls Ä stream1, stream2, stream3 
 * 
 * Params:

 * dimi frameNo: Numeric - Frame number
 * Created by: Franklin On 2009-05-19 11:22:34

 ***********************************************************/
Äh showAllRegionCtrls(dimi hideVal,dimi frameNo)
 
 dimi i,j
 dims ctrlName$
 dims regCtrl$(4)=("X","Y","wdt","hgt")
 
 Ä i = 1 Ä 3  
 ctrlName$ = "lblRegion"+i+frameNo  
 #{ctrlName$}.hidden = hideVal
 
 Ä j = 0 Ä 3
 ctrlName$ = "lblreg"+i+regCtrl$(j)+frameNo  
 #{ctrlName$}.hidden = hideVal
 ctrlName$ = "txtreg"+i+regCtrl$(j)+frameNo  
 #{ctrlName$}.hidden = hideVal  
 Ä
 
 Ä
 
ÄF

/***********************************************************

 * Description: 
 * property Ä reset the mouse click flag of activex control (ResetMouseFlag)
 * 
 * Params:

 * y: Numeric - 
 * Created by: On 2010-07-15 10:59:55
 * History: 
 ***********************************************************/
Äh form_Mouseup(x,y)
 ÄB canReload = 0 Ä  
 Ä0(2)
 Ä
 ÄD
 ÄB flagMouseClick = 0 Ä  //ÄB mouseclick is done over the activex control
 #gdoVideoROI.ResetMouseFlag = 0 //added by Frank on 15th july 2010//Ä reset on  //property Ä reset the mouse click flag of activex control
 ÄD 
 flagMouseClick = 0  //reset Ä the default value
 Ä Form_KeyPress(0, 1) //Ä the keypress event signalling it as 1 ( Ä mouseup)
ÄF

/***********************************************************

 * Description: 
 * Ä set wait flag before switching between forms  
 Checks entered key value based on the rule set Ä that user input control

 * Params:

 * FromMouse : Numeric - char code of the mouse pressed
 * Created by: Franklin Jacques On 2009-05-16 03:47:42
 * History: 
 ***********************************************************/
Äh Form_KeyPress( Key, FromMouse ) 
 ÄB canReload = 0 Ä  
 Ä-(2)
 Ä
 ÄD
 ÄB Key = 15 Ä
 Ä ~wait<=1 Ä Ä
 ~wait = 2
 ÄD
 scroll_keypressed(key)
 dims keypressed$
 keypressed$ = ÄQ(Ä,())
 
 Ä (CheckKey(Key,rule,keypressed$))=1 Ä Ä-(2)
 setSubMenuFocus(Key,0)
ÄF



/***********************************************************

 * Description: 
 * Save all user input values Ä camera
 * 
 * Params:
 * Created by:Franklin Jacques  On 2009-05-11 19:57:09
 * History: 
 ***********************************************************/
Äh cmdSave_Click
 ÄB canReload = 1 Ä
 savePage() 
 ÄD
ÄF


/***********************************************************

 * Description: 
 * Ä this Ä Ä get number of regions selected Ä a stream
 * 
 * Params: regionNo - Numeric
 * Created by:S.Vimala  On 2009-12-04 
 * History: 
 ***********************************************************/
Ä getNoOfRegionsSelected(dimi regionNo) 
 dims regName1$(4) = ("txtreg1X","txtreg1Y","txtreg1wdt","txtreg1hgt")
 dims regName2$(4) = ("txtreg2X","txtreg2Y","txtreg2wdt","txtreg2hgt")
 dims regName3$(4) = ("txtreg3X","txtreg3Y","txtreg3wdt","txtreg3hgt")
 
 dimi i,selectedFlag,totalRegion 
 dims tempName$
 selectedFlag = 0
 Ä i = 0 Ä ÄÇ(regName1$)
 tempName$ = regName1$(i)+regionNo
 Ä tempName$
 ÄB #{tempName$} > 0 Ä 
 selectedFlag = 1
 ÄE
 ÄD
 Ä
 
 totalRegion = selectedFlag
 selectedFlag = 0
 Ä i = 0 Ä ÄÇ(regName2$)
 tempName$ = regName2$(i)+regionNo
 Ä tempName$
 ÄB #{tempName$} > 0 Ä 
 selectedFlag = 1
 ÄE
 ÄD
 Ä
 
 totalRegion += selectedFlag
 selectedFlag = 0
 Ä i = 0 Ä ÄÇ(regName3$)
 tempName$ = regName3$(i)+regionNo
 Ä tempName$
 ÄB #{tempName$} > 0 Ä 
 selectedFlag = 1
 ÄE
 ÄD
 Ä
 
 totalRegion += selectedFlag
 getNoOfRegionsSelected = totalRegion
ÄF




/***********************************************************

 * Description: 
 * Save all the tab values  Ä camera
 
 * Created by: Franklin On 2009-05-28 16:34:07

 ***********************************************************/
Äh savePage() 
 ErrorROIFlag=0
 ÄB validateCtrlValues() = 0 Ä 
 fradvanced_change()
 Ä
 ÄD
 
 
 ÄB  ValidateRegionValues(1) = 1 and #chkfacedetect1.checked = 1 Ä
 Ä("Please enter valid X,Y,Width,Height for stream1")
 #fradvanced.curtab = 0
 #imgselected.y = #rosubmenu.y-10
 Äd("txtreg1x1")
 Ä
 Äy  ValidateRegionValues(2) = 1 and #chkfacedetect2.checked = 1  and noOfTabs >= 2 Ä
 Ä("Please enter valid X,Y,Width,Height for stream2")
 #fradvanced.curtab = 1  
 #imgselected.y = #rosubmenu.y-10
 Äd("txtreg1x2") 
 Ä
 Äy  ValidateRegionValues(3) = 1 and #chkfacedetect3.checked = 1 and noOfTabs=3  Ä
 Ä("Please enter valid X,Y,Width,Height for stream3")
 #fradvanced.curtab = 2  
 #imgselected.y = #rosubmenu.y-10
 Äd("txtreg1x3")
 Ä
 ÄD

 ÄB noOfTabs >= 1 Ä
 Ä showRegionValues(1)
 ÄB ErrorROIFlag=1 Ä 
 #imgselected.y = #rosubmenu.y-10
 Ä
 ÄD
 ÄD
 
 ÄB noOfTabs >= 2 Ä
 Ä showRegionValues(2)
 ÄB ErrorROIFlag=1 Ä 
 #imgselected.y = #rosubmenu.y-10
 Ä
 ÄD
 ÄD
 
 ÄB noOfTabs = 3 Ä
 Ä showRegionValues(3)
 ÄB ErrorROIFlag=1 Ä 
 #imgselected.y = #rosubmenu.y-10
 Ä
 ÄD
 ÄD

 dimi a
 a = #gdoVideo.stop(1) 
 #gdoVideo.hidden = 1  
 #gdobg.paint(1)
 #lblloading$= "Updating..."
 #lblloading.paint(1) 
 
 #lblloading.hidden = 0  
 
 dimi noOfRegions1,noOfRegions2,noOfRegions3
 ÄB #chkFaceDetect1 = 1 Ä
 noOfRegions1 = getNoOfRegionsSelected(1)
 ÄD
 
 ÄB #chkFaceDetect2 = 1 Ä
 noOfRegions2 = getNoOfRegionsSelected(2)
 ÄD
 
 ÄB #chkFaceDetect3 = 1 Ä
 noOfRegions3 = getNoOfRegionsSelected(3)
 ÄD
 
 dimi ret1, ret2, ret3,i
 dims error$
 Ä #txtreg1hgt1
 ret1 = setVideoImageAdvanced1(#txtIPRatio1$,#chkForceIFrame1,#txtMin1$,#txtMax1$,#txtinit1$,_
 #drpMEConfig1,#txtPacketSize1$,_
 noOfRegions1,#txtreg1X1,#txtreg1Y1,#txtreg1wdt1,#txtreg1hgt1,_
 #txtreg2X1,#txtreg2Y1,#txtreg2wdt1,#txtreg2hgt1,#txtreg3X1,_
 #txtreg3Y1,#txtreg3wdt1,#txtreg3hgt1) 
 error$ = ~errorKeywords$
 ret2 = 1
 
 ÄB noOfTabs >= 2 and jpegStream=0 Ä 
 ret2 = setVideoImageAdvanced2(#txtIPRatio2$,#chkForceIFrame2,#txtMin2$,#txtMax2$,#txtinit2$,_
 #drpMEConfig2,#txtPacketSize2$,_
 noOfRegions2,#txtreg1X2,#txtreg1Y2,#txtreg1wdt2,#txtreg1hgt2,_
 #txtreg2X2,#txtreg2Y2,#txtreg2wdt2,#txtreg2hgt2,#txtreg3X2,_
 #txtreg3Y2,#txtreg3wdt2,#txtreg3hgt2) 
 error$ += ~errorKeywords$  
 ÄD
 ret3 = 1
 ÄB noOfTabs = 3 Ä 
 ret3 = setVideoImageAdvanced3(#txtIPRatio3$,#chkForceIFrame3,#txtMin3$,#txtMax3$,#txtinit3$,_
 #drpMEConfig3,#txtPacketSize3$,_
 noOfRegions3,#txtreg1X3,#txtreg1Y3,#txtreg1wdt3,#txtreg1hgt3,_
 #txtreg2X3,#txtreg2Y3,#txtreg2wdt3,#txtreg2hgt3,_
 #txtreg3X3,#txtreg3Y3,#txtreg3wdt3,#txtreg3hgt3) 
 error$ += ~errorKeywords$
 ÄD
 
 ÄB ret1>0 and ret2>0 and ret3>0 Ä  
 saveSuccess = 1
 ÄC 
 saveSuccess = 0
 ÄD
 
 
 ÄB getReloadFlag() = 1 Ä  
 canReload = 0
 animateCount = 1
 Ä animateLabel("lblLoading","Updating")
 ÄC // ÄB Reload animation is not required
 canReload = 1
 ÄD

 ÄB canReload = 1 Ä  //Do the remaining actions after reload animation is done
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
 #lblsuccessmessage$ = "Video - Advanced setting saved to camera "+~title$  
 isMessageDisplayed = 1  
 ÄC 
 ÄB ~keywordDetFlag = 1 Ä
 Ä("Video - Advanced setting for \n"+error$+"\nfailed for the camera "+~title$)
 ÄC
 Ä("Video - Advanced setting failed for the camera "+~title$)
 ÄD  
 ÄD
 ~changeFlag = 0  
 
 ÄB validateFlag = 1 Ä
 Ä_("!videoImageAdvanced.frm&noOfTabs="+noOfTabs+"&isMessageDisplayed="+isMessageDisplayed)
 ÄD
 
ÄF


/***********************************************************

 * Description: 
 * Ä validate user input values

 * Created by: Franklin On 2009-05-18 12:08:07

 ***********************************************************/
Ä validateCtrlValues()
 
 validateCtrlValues=1
 validateFlag = 1

 ÄB #txtpacketsize1 > 100 Ä  
 Ä("Packet Size should allow values between 0 to 100")
 #fradvanced.curtab = 0
 Äd("txtpacketsize1")
 validateCtrlValues=0  
 validateFlag = 0  
 Äy #txtmax1 < #txtmin1 Ä
 Ä("QP value Max should be greater than Min")
 #fradvanced.curtab = 0
 Äd("txtmax1")
 validateCtrlValues=0  
 validateFlag = 0  
 Äy jpegStream <> 2 and #txtpacketsize2 > 100 and  (noOfTabs = 2 or  noOfTabs = 3) Ä  
 Ä("Packet Size should allow values between 0 to 100")
 #fradvanced.curtab = 1
 Äd("txtpacketsize2")
 validateCtrlValues=0  
 validateFlag = 0  
 Äy jpegStream <> 2  and #txtmax2 < #txtmin2  and  (noOfTabs = 2 or  noOfTabs = 3) Ä  
 Ä("QP value Max should be greater than Min")
 #fradvanced.curtab = 1
 Äd("txtmax2")
 validateCtrlValues=0  
 validateFlag = 0  
 Äy #txtmax3 < #txtmin3 Ä
 Ä("QP value Max should be greater than Min")
 #fradvanced.curtab = 2
 Äd("txtmax3")
 validateCtrlValues=0  
 validateFlag = 0  
 Äy #txtpacketsize3 > 100 and noOfTabs = 3  Ä  
 Ä("Packet Size should allow values between 0 to 100")
 #fradvanced.curtab = 2
 Äd("txtpacketsize3")
 validateCtrlValues=0  
 validateFlag = 0  
 ÄD
 
ÄF

/***********************************************************

 * Description:Used Ä Add the Tab images in Frame
 * 
 * 
 * Params:
 * Created by: C.Balaji On 2009-05-11 11:13:34
 * History: 
 ***********************************************************/
Äh addTabImage()
 Ä—(TabsImagesA$,0,0,90,30,2,1,"!stream_1.bin")
 Ä—(TabsImagesB$,0,0,90,30,2,1,"!stream_2.bin")
 Ä—(TabsImagesC$,0,0,90,30,2,1,"!stream_3.bin")
 #fradvanced.tabheight=35  
 #fradvanced.curtab=0
 #fradvanced.paneimage(0)=TabsImagesA$
 #fradvanced.paneimage(1)=TabsImagesB$
 #fradvanced.paneimage(2)=TabsImagesC$
ÄF  


Äh chkForceIFrame1_Focus
 Ä∂(1)
ÄF

Äh chkForceIFrame1_Blur
 Ä∂(3)
ÄF

Äh optUMV1_Focus
 Ä∂(1)
ÄF

Äh chkFaceDetect1_Focus
 Ä∂(1)
ÄF

Äh chkFaceDetect1_Blur
 Ä∂(3)
ÄF

Äh chkForceIFrame2_Focus
 Ä∂(1)
ÄF

Äh chkForceIFrame2_Blur
 Ä∂(3)
ÄF

Äh optUMV2_Focus
 Ä∂(1)
ÄF

Äh chkFaceDetect2_Blur
 Ä∂(3)
ÄF

Äh chkFaceDetect2_Focus
 Ä∂(1)
ÄF

Äh chkForceIFrame3_Focus
 Ä∂(1)
ÄF

Äh chkForceIFrame3_Blur
 Ä∂(3)
ÄF

Äh optUMV3_Focus
 Ä∂(1)
ÄF

Äh chkFaceDetect3_Blur
 Ä∂(3)
ÄF

Äh chkFaceDetect3_Focus
 Ä∂(1)
ÄF

/***********************************************************

 * Description: 
 * Ä load the videoImageSettings.frm when back button is pressed  
 * 
 * Created by: Franklin Jacques.K  On 2009-07-16 14:40:55
 * History: 
 ***********************************************************/
Äh btnBack_Click  
 ~UrlToLoad$ = "!videoImageSettings.frm"  
 ErrorROIFlag=0
 chkValueMismatch()
 ÄB ~changeFlag = 1  Ä 
 Ä("Do you want to save the changes",3)
 ÄB Äu()=1 Ä
 ÄB validateCtrlValues() = 0 Ä 
 fradvanced_change()
 Ä
 ÄD  
 
 ÄB  ValidateRegionValues(1) = 1 and #chkfacedetect1.checked = 1 Ä
 Ä("Please enter valid X,Y,Width,Height for stream1")
 #fradvanced.curtab = 0  
 Äd("txtreg1x1")
 Ä
 Äy  ValidateRegionValues(2) = 1 and #chkfacedetect2.checked = 1  and noOfTabs >= 2 Ä
 Ä("Please enter valid X,Y,Width,Height for stream2")
 #fradvanced.curtab = 1  
 Äd("txtreg1x2") 
 Ä
 Äy  ValidateRegionValues(3) = 1 and #chkfacedetect3.checked = 1 and noOfTabs=3  Ä
 Ä("Please enter valid X,Y,Width,Height for stream3")
 #fradvanced.curtab = 2
 Äd("txtreg1x3")
 Ä
 ÄD  
 
 ÄB noOfTabs >= 1 Ä
 Ä showRegionValues(1)
 Ä ErrorROIFlag=1 Ä Ä
 ÄD
 
 ÄB noOfTabs >= 2 Ä
 Ä showRegionValues(2)
 Ä ErrorROIFlag=1 Ä Ä
 ÄD
 
 ÄB noOfTabs = 3 Ä
 Ä showRegionValues(3)
 Ä ErrorROIFlag=1 Ä Ä
 ÄD  
 
 savePage() 
 Ä "canReload = " + canReload  
 
 Ä  
 ÄC  
 ~changeFlag = 0  
 ÄD 
 ÄD
 
 Ä canReload = 1 Ä Ä_("!videoImageSettings.frm")
ÄF

/***********************************************************

 * Description: 
 * Ä get the focus on the control
 * 
 * Params:

 * y: Numeric - mouse click y value
 * Created by:Vimala  On 2009-07-16 11:27:46
 * History: 
 ***********************************************************/
Äh form_Mouseclick(x,y)
 ÄB canReload = 0 Ä  
 Ä0(2)
 Ä
 ÄD
 flagMouseClick = 1  //added by franklin on 15th july //Ä keep track of the mouseclick mode
 Ä getFocus() 
ÄF



/***********************************************************

 * Description: 
 Ä display the region of interest Frame 
 set the url with respect Ä the current stream
 * Method: setDrpRegionValues()- Ä set the region values Ä the 
 dropdown boxes
 showRegionValues- Ä show the currently selected region co=ordinates
 btnrefresh_Click- Ä refresh the values of the textboxes Ä show the
 currently selected region co-ordinates
 * Created by: Franklin Jacques.K  On 2009-09-18 10:34:11
 * History: 
 ***********************************************************/
Äh btnConfigure1_Click
 ÄB canReload = 1 Ä
 dimi a,ret 
 dims url$,value$
 
 
 ÄB ValidateRegionValues(1) = 0 Ä 
 Ä setDrpRegionValues()
 Ä showRegionValues(1)
 Ä btnrefresh_Click()
 ÄB ErrorROIFlag = 0 Ä 
 #frmRegOfInterest.hidden=0
 a=#gdoVideo.stop(1)
 #gdoVideo.hidden=1
 #gdobg.hidden=1
 #cmdsave.hidden=1
 #cmdcancel.hidden=1
 #btnback.hidden=1
 value$ =rtspUrl$(0) 
 a=#gdoVideoROI.Play(value$) //godVideoROI-gdo control Ä region of interest
 #gdoVideoROI.hidden=0
 Äd("gdoVideoROI")
 ÄD
 ÄC
 Ä("Please enter valid X,Y,Width,Height for stream1")
 ÄD  
 
 
 ErrorROIFlag=0
 ÄD
ÄF

/***********************************************************

 * Description: 
 * Ä Validate the Region values with respect Ä the current stream
 * 
 * Methods: getCurStreamResolution- Ä get the current stream Resolution
 * Created by: Franklin Jacques.K On 2009-09-25 11:43:02
 * History: 
 ***********************************************************/
Ä ValidateRegionValues(dimi tabNo)
 ValidateRegionValues = 0
 
 dims ctrlName$,ctrlX$, ctrlY$
 dims regCoordinates$(4) = ("X","Y","wdt","hgt")
 dimi xRes,yRes,i,j,errorFlag = 0  
 
 getCurStreamResolution(stream$(tabNo-1),xRes,yRes)
 
 Ä i = 1 Ä 3
 Ä j = 0 Ä ÄÇ(regCoordinates$)
 ctrlName$ = "txtreg"+i+regCoordinates$(j)+tabNo
 
 ÄB j = 0 or j=2 Ä
 ÄB j=2 Ä
 ctrlX$ = "txtreg"+i+regCoordinates$(0)+tabNo
 ÄB (#{ctrlName$} + #{ctrlX$}) > xRes Ä
 ValidateRegionValues = 1
 errorFlag = 1
 ÄE
 ÄD
 ÄD
 ÄB #{ctrlName$} > xRes Ä 
 ValidateRegionValues = 1
 errorFlag = 1
 ÄE  
 ÄD
 Äy j = 1 or j = 3 Ä
 ÄB j=3 Ä
 ctrlY$ = "txtreg"+i+regCoordinates$(1)+tabNo
 ÄB (#{ctrlName$} + #{ctrlY$}) > yRes Ä
 ValidateRegionValues = 1
 errorFlag = 1
 ÄE
 ÄD
 ÄD
 ÄB #{ctrlName$} > yRes Ä 
 ValidateRegionValues = 1
 errorFlag = 1
 ÄE  
 ÄD
 ÄD  
 Ä  
 Ä
 
 Äd(ctrlName$)
ÄF

/***********************************************************

 * Description: 
 * Ä populate the region Values and display the selected region in the 
 ActiveX control
 * 
 * Methods : deCalcResolution- Ä calculate the the region Values Ä the current ActiveX Controls resolution
 * dimi Index: Numeric - 
 * Created by: Franklin Jacques.K On 2009-09-23 17:58:03
 * History: 
 ***********************************************************/
Äh showRegionValues(dimi Index)
 Dims regOfInterest$
 ÄB index = 1 Ä 
 Ä deCalcResolution(1,#txtreg1X1$,#txtreg1Y1$,#txtreg1wdt1$,#txtreg1hgt1$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg1wdt1")
 Ä FocusFlag = 2 Ä Äd("txtreg1hgt1")
 FocusFlag = 0
 Ä
 ÄD
 Ä "showRegionValues: " + regOfInterest$
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(2,#txtreg2X1$,#txtreg2Y1$,#txtreg2wdt1$,#txtreg2hgt1$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg2wdt1")
 Ä FocusFlag = 2 Ä Äd("txtreg2hgt1")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(3,#txtreg3X1$,#txtreg3Y1$,#txtreg3wdt1$,#txtreg3hgt1$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg3wdt1")
 Ä FocusFlag = 2 Ä Äd("txtreg3hgt1")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Äy index = 2 Ä 
 Ä deCalcResolution(1,#txtreg1X2$,#txtreg1Y2$,#txtreg1wdt2$,#txtreg1hgt2$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg1wdt2")
 Ä FocusFlag = 2 Ä Äd("txtreg1hgt2")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(2,#txtreg2X2$,#txtreg2Y2$,#txtreg2wdt2$,#txtreg2hgt2$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg2wdt2")
 Ä FocusFlag = 2 Ä Äd("txtreg2hgt2")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(3,#txtreg3X2$,#txtreg3Y2$,#txtreg3wdt2$,#txtreg3hgt2$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg3wdt2")
 Ä FocusFlag = 2 Ä Äd("txtreg3hgt2")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Äy index = 3 Ä
 Ä deCalcResolution(1,#txtreg1X3$,#txtreg1Y3$,#txtreg1wdt3$,#txtreg1hgt3$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg1wdt3")
 Ä FocusFlag = 2 Ä Äd("txtreg1hgt3")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(2,#txtreg2X3$,#txtreg2Y3$,#txtreg2wdt3$,#txtreg2hgt3$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg2wdt3")
 Ä FocusFlag = 2 Ä Äd("txtreg2hgt3")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 Ä deCalcResolution(3,#txtreg3X3$,#txtreg3Y3$,#txtreg3wdt3$,#txtreg3hgt3$,regOfInterest$)
 ÄB ErrorROIFlag=1 Ä
 Ä FocusFlag = 1 Ä Äd("txtreg3wdt3")
 Ä FocusFlag = 2 Ä Äd("txtreg3hgt3")
 FocusFlag = 0
 Ä
 ÄD
 #gdoVideoROI.RegionOfInterest(regOfInterest$)
 ÄD
ÄF

/***********************************************************

 * Description: 
 * Ä calculate the the region Values Ä the current ActiveX Controls resolution
 * 
 * Params:




 * dims regH$: String - value of the text control 
 * byref dims regOfInterest$ : String - Ä region values Äi with &
 * Created by: On 2009-09-23 18:10:36

 ***********************************************************/
Äh deCalcResolution(dimi Index, dims regX$, dims regY$, dims regW$, dims regH$, byref dims regOfInterest$)
 Dimi xRes,yRes
 getCurStreamResolution(stream$(#fradvanced.curtab),xRes,yRes)
 Ä xRes<=0 or yRes<=0 Ä Ä
 dimi regX, regY, regW, regH
 dimi tabNo, MinValue
 Ä gdoWidth;gdoHeight;xRes;yRes
 MinValue = ÄY(xRes/gdoWidth)
 MinValue = MinValue*2
 regX = ÄY((Ä(regX$)*gdoWidth)/xRes)
 regY = ÄY((Ä(regY$)*gdoHeight)/yRes)
 regW = ÄY((Ä(regW$)*gdoWidth)/xRes)
 regH = ÄY((Ä(regH$)*gdoHeight)/yRes)
 
 tabNo = #fradvanced.curtab
 tabNo+=1
 ÄB Ä(regH$)<=2 and regX<>0 Ä 
 Ä("Please enter valid width and height for Stream"+tabNo+"\nMin W : "+MinValue+" & Min H : "+MinValue+"")
 ErrorROIFlag=1
 FocusFlag = 1
 Ä
 ÄD
 
 ÄB Ä(regH$)<=2 and regY<>0 Ä 
 Ä("Please enter valid width and height for Stream"+tabNo+"\nMin W : "+MinValue+" & Min H : "+MinValue+"")
 ErrorROIFlag=1
 FocusFlag = 2
 Ä
 ÄD
 ÄB (Ä(regW$)<>0 and Ä(regH$)=0) Ä 
 Ä("Please enter valid width and height for Stream"+tabNo+"\nMin W : "+MinValue+" & Min H : "+MinValue+"")
 ErrorROIFlag=1
 FocusFlag = 2
 Ä
 Äy (Ä(regH$)<>0 and Ä(regW$)=0) Ä 
 Ä("Please enter valid width and height for Stream"+tabNo+"\nMin W : "+MinValue+" & Min H : "+MinValue+"")
 ErrorROIFlag=1
 FocusFlag = 1
 Ä
 ÄD
 regOfInterest$ = Index+"&"+regX+"&"+regY+"&"+regW+"&"+regH
 Ä regOfInterest$
ÄF

/***********************************************************

 * Description: Add three regions Ä drop downs
 
 * Created by: On 2009-09-21 16:53:42
 ***********************************************************/
Äh setDrpRegionValues()
 #drpregion1.removeAll()
 #drpregion2.removeAll()
 #drpregion3.removeAll()
 #drpregion1.additem("0","Region1")
 #drpregion1.additem("1","Region2")
 #drpregion1.additem("2","Region3")
 #drpregion2.additem("0","Region1")
 #drpregion2.additem("1","Region2")
 #drpregion2.additem("2","Region3")
 #drpregion3.additem("0","Region1")
 #drpregion3.additem("1","Region2")
 #drpregion3.additem("2","Region3")
 #drpregion1.selIdx=0
 #drpregion2.selIdx=1
 #drpregion3.selIdx=2
ÄF

/***********************************************************

 * Description: 
 Ä display the region of interest Frame 
 set the url with respect Ä the current stream
 * Method: setDrpRegionValues()- Ä set the region values Ä the 
 dropdown boxes
 showRegionValues- Ä show the currently selected region co=ordinates
 btnrefresh_Click- Ä refresh the values of the textboxes Ä show the
 currently selected region co-ordinates
 * Created by: Franklin Jacques.K  On 2009-09-18 10:34:11
 * History: 
 ***********************************************************/
Äh btnConfigure2_Click
 ÄB canReload = 1 Ä
 Dimi a,ret
 dims url$,value$
 
 
 ÄB ValidateRegionValues(2) = 0 Ä 
 Ä setDrpRegionValues()
 Ä showRegionValues(2)
 Ä btnrefresh_Click
 ÄB ErrorROIFlag = 0 Ä 
 #frmRegOfInterest.hidden=0
 a=#gdoVideo.stop(1)
 #gdoVideo.hidden=1
 #gdoVideo.hidden=1
 #gdobg.hidden=1
 #cmdsave.hidden=1
 #cmdcancel.hidden=1
 #btnback.hidden=1
 value$ = rtspUrl$(1) 
 a=#gdoVideoROI.Play(value$) //godVideoROI-gdo control Ä region of interest
 #gdoVideoROI.hidden=0
 ÄD
 ÄC
 Ä("Please enter valid X,Y,Width,Height for stream2")
 ÄD
 
 
 ErrorROIFlag=0
 ÄD
ÄF


/***********************************************************

 * Description: 
 Ä display the region of interest Frame 
 set the url with respect Ä the current stream
 * Method: setDrpRegionValues()- Ä set the region values Ä the 
 dropdown boxes
 showRegionValues- Ä show the currently selected region co=ordinates
 btnrefresh_Click- Ä refresh the values of the textboxes Ä show the
 currently selected region co-ordinates
 * Created by: Franklin Jacques.K  On 2009-09-18 10:34:11
 * History: 
 ***********************************************************/
Äh btnConfigure3_Click
 ÄB canReload = 1 Ä
 Dimi a,ret
 dims url$,value$
 
 
 ÄB ValidateRegionValues(3) = 0 Ä 
 Ä setDrpRegionValues()
 Ä showRegionValues(3)
 Ä btnrefresh_Click()
 ÄB ErrorROIFlag = 0 Ä 
 #frmRegOfInterest.hidden=0
 a=#gdoVideo.stop(1)
 #gdoVideo.hidden=1
 #gdoVideo.hidden=1
 #gdobg.hidden=1
 #cmdsave.hidden=1
 #cmdcancel.hidden=1
 #btnback.hidden=1
 value$ = rtspUrl$(2) 
 a=#gdoVideoROI.Play(value$) //godVideoROI-gdo control Ä region of interest
 #gdoVideoROI.hidden=0  
 ÄD
 ÄC
 Ä("Please enter valid X,Y,Width,Height for stream3")
 ÄD
 
 
 ErrorROIFlag=0
 ÄD
ÄF


/***********************************************************

 * Description: Ä cancel all selected regions
 * 
 * 
 * Methods: frmregofinterest_cancel- Ä cancel all the region selected recently and 
 set back Ä the initial values
 
 * Created by: Franklin Jacques.K On 2009-09-21 11:27:51
 ***********************************************************/
Äh btnROI_Cancel_Click
 Ä frmregofinterest_cancel() 
 #gdoVideoROI.ResetMouseFlag = 1  //added by Frank on 15th july 2010 //Ä reset  //added by Frank on 15th july 2010 //Ä reset all the flags of the activex control's mouse event
ÄF

/***********************************************************

 * Description: 
 * Ä set the values of selected region Ä the text boxes 
 of the Main screen(Video Advanced  setting)
 * 
 * Params:
 * Created by:Franklin Jacques.K  On 2009-10-06 16:55:52
 * History: 
 ***********************************************************/
Äh setRegionValuesToMainScreen()
 
 dims ctrlNameROI$, ctrlNameMainScreen$
 dims regCoordinates$(4) = ("X","Y","wdt","hgt")
 dims regCoordinatesOfMainScreen$(4) = ("X","Y","W","H")
 dimi i,j,tabNo,drpVal
 dims drpName$
 tabNo = #fradvanced.curtab
 tabNo = tabNo +1
 
 Ä i = 1 Ä 3
 drpName$ = "drpregion"+i+"$"
 drpVal = Ä(#{drpName$}$) + 1
 Ä j = 0 Ä ÄÇ(regCoordinates$)
 ctrlNameMainScreen$ = "txtreg"+drpVal+regCoordinates$(j)+tabNo
 ctrlNameROI$ = "txt"+regCoordinatesOfMainScreen$(j)+i
 Ä ctrlNameROI$ 
 Ä ctrlNameMainScreen$
 #{ctrlNameMainScreen$}$ = #{ctrlNameROI$}$
 Ä  
 Ä
ÄF


/***********************************************************

 * Description: 
 * set the region values of the controls(region of interest) Ä the 
 controls of the VideoImageAdvanced setting
 * 
 * Methods: regionSelected- the selected region
 * Created by: Franklin Jacques.K On 2009-09-21 14:33:48
 * History: 
 ***********************************************************/
Äh btnROI_Save_Click
 Ä regionSelected() 
 Dimi ret 
 #lblErrMsg.hidden = 0
 ÄB #drpregion1$<>#drpregion2$ and #drpregion2$<>#drpregion3$ and  #drpregion3$<>#drpregion1$ Ä
 MsgColorFlag = -1
 btnROI_Cancel_Click()
 
 #lblErrMsg.hidden = 1
 Ä setRegionValuesToMainScreen()
 ÄC  
 #lblErrMsg$="Drop down boxes should have different values"
 MsgColorFlag = 1
 ÄD

ÄF


/***********************************************************

 * Description: 
 * set the region values of the controls(region of interest) from the region selected
 in the ActiveX control
 
 * Methods: RoiCalculation- Ä calculate the region values selected using the Mouse  
 * Created by: Franklin Jacques.K On 2009-09-21 16:45:57

 ***********************************************************/
Äh regionSelected()
 dims region$(5)
 RoiCalculation(strtoint(#drpregion1$), region$)
 
 ÄB strtoint(region$(0))=1 Ä
 #txtX1$= strtoint(region$(1)) 
 #txtY1$= strtoint(region$(2))
 #txtW1$= strtoint(region$(3)) 
 #txtH1$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=2 Ä 
 #txtx2$= strtoint(region$(1))
 #txty2$= strtoint(region$(2))
 #txtw2$= strtoint(region$(3)) 
 #txth2$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=3 Ä 
 #txtx3$= strtoint(region$(1))
 #txty3$= strtoint(region$(2))
 #txtw3$= strtoint(region$(3)) 
 #txth3$= strtoint(region$(4))
 ÄD
 RoiCalculation(strtoint(#drpregion2$), region$)
 
 ÄB strtoint(region$(0))=1 Ä
 #txtX1$= strtoint(region$(1)) 
 #txtY1$= strtoint(region$(2))
 #txtW1$= strtoint(region$(3)) 
 #txtH1$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=2 Ä 
 #txtx2$= strtoint(region$(1))
 #txty2$= strtoint(region$(2))
 #txtw2$= strtoint(region$(3)) 
 #txth2$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=3 Ä 
 #txtx3$= strtoint(region$(1))
 #txty3$= strtoint(region$(2))
 #txtw3$= strtoint(region$(3)) 
 #txth3$= strtoint(region$(4))
 ÄD
 RoiCalculation(strtoint(#drpregion3$), region$) 
 
 ÄB strtoint(region$(0))=1 Ä
 #txtX1$= strtoint(region$(1)) 
 #txtY1$= strtoint(region$(2))
 #txtW1$= strtoint(region$(3)) 
 #txtH1$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=2 Ä 
 #txtx2$= strtoint(region$(1))
 #txty2$= strtoint(region$(2))
 #txtw2$= strtoint(region$(3)) 
 #txth2$= strtoint(region$(4)) 
 Äy strtoint(region$(0))=3 Ä 
 #txtx3$= strtoint(region$(1))
 #txty3$= strtoint(region$(2))
 #txtw3$= strtoint(region$(3)) 
 #txth3$= strtoint(region$(4))
 ÄD

ÄF

/***********************************************************

 * Description: 
 * Ä calculate the region values selected  Ä the stream resolution 

 * Created by: On 2009-09-21 14:11:18

 ***********************************************************/
Äh RoiCalculation(dimi regionIndex, byref dims regionArray$())
 dims strVal$, tempVal$, region$
 dimi ret, xRes, yRes, regX, regY, regX1, regY1, regW1, regH1
 tempVal$=#gdoVideoROI.RegionOfInterest$
 Ä "RoiCalculation:" + tempVal$
 ret=Ä<(strVal$,tempVal$,"|")
 
 ÄB ret>0 Ä
 Ä<(region$,strVal$(regionIndex), "&")
 
 dimi width, height
 ÄB Ä(region$(3))>Ä(region$(1)) Ä 
 width=Ä(region$(3))-Ä(region$(1))
 ÄC
 width=Ä(region$(1))-Ä(region$(3))
 ÄD
 ÄB Ä(region$(4))>Ä(region$(2)) Ä 
 height=Ä(region$(4))-Ä(region$(2))
 ÄC
 height=Ä(region$(2))-Ä(region$(4))
 ÄD
 
 getCurStreamResolution(stream$(#fradvanced.curtab),xRes,yRes)
 Ä xRes<=0 or yRes<=0 Ä Ä
 regionArray$(0)=region$(0)
 regX = Ä(region$(1))
 regY = Ä(region$(2))
 
 regX1 = ÄY((regX*xRes)/gdoWidth) 
 regY1 = ÄY((regY*yRes)/gdoHeight)
 regW1 = ÄY((width*xRes)/gdoWidth)
 regH1 = ÄY((height*yRes)/gdoHeight)
 
 ÄB (regX1 + regW1) > xRes Ä
 regW1 = xRes - regX1
 ÄD
 ÄB (regY1 + regH1) > yRes Ä
 regH1 = yRes - regY1
 ÄD
 
 regionArray$(1)=regX1
 regionArray$(2)=regY1
 regionArray$(3)=regW1
 regionArray$(4)=regH1
 ÄD
ÄF

/***********************************************************

 * Description: 
 * Ä cancel all the region selected recently and 
 set back Ä the initial values
 * 
 * Params:
 * Created by: Farnklin Jacques.K  On 2009-09-21 14:52:15
 * History: 
 ***********************************************************/
Äh frmregofinterest_cancel()
 dimi a
 #frmregofinterest.hidden=1
 a=#gdoVideoROI.stop(1)
 #gdoVideoROI.hidden=1
 MsgColorFlag = -1
 Ä disp_streams()
 ÄB #fradvanced.curtab=0 Ä 
 #chkFaceDetect1.checked = 1
 Äy #fradvanced.curtab=1 Ä 
 #chkfacedetect2.checked = 1
 Äy #fradvanced.curtab=2 Ä 
 #chkfacedetect3.checked = 1
 ÄD
 #gdobg.hidden=0
 #cmdsave.hidden=0
 #cmdcancel.hidden=0
 #btnback.hidden=0
 #lblErrMsg.hidden = 1
 Äd("rosubmenu[0]") 
ÄF


/***********************************************************

 * Description: 
 * Ä set the region values Ä the controls based on the selected region on the 
 ActiveX control
 * 
 * Methods: regionSelected- Ä set the region values Ä the controls based on the selected region on the 
 ActiveX control
 * Created by: Franklin Jacques.K On 2009-09-23 16:51:34
 * History: 
 ***********************************************************/
Äh btnrefresh_Click
 Ä regionSelected()
 #lblErrMsg.hidden = 1
 Äd("rocamera") 
ÄF



/***********************************************************

 * Description: 
 * Ä delete the selected region(Stream1) of the Activex Control
 * 
 * Params:
 * Created by: On 2009-09-21 18:34:05
 * History: 
 ***********************************************************/
Äh btnDelete1_Click
 dimi RegNo
 RegNo=strtoint(#drpRegion1$)+1
 #gdoVideoROI.RegionOfInterest("1&0&0&0&0")
 Ä btnrefresh_click
ÄF



/***********************************************************

 * Description: 
 * Ä delete the selected region(Stream2) of the Activex Control
 * 
 * Params:
 * Created by: Franklin Jacques.K On 2009-10-08 16:58:10
 * History: 
 ***********************************************************/
Äh btnDelete2_Click  
 dimi RegNo
 RegNo=strtoint(#drpRegion2$)+1  
 #gdoVideoROI.RegionOfInterest("2&0&0&0&0")
 Ä btnrefresh_click
ÄF



/***********************************************************

 * Description: 
 * Ä delete the selected region(Stream2) of the Activex Control  
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-10-08 16:59:16
 * History: 
 ***********************************************************/
Äh btnDelete3_Click
 dimi RegNo
 RegNo=strtoint(#drpRegion3$)+1
 #gdoVideoROI.RegionOfInterest("3&0&0&0&0")
 Ä btnrefresh_click
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1X1_focus
 rule=7
ÄF


/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1Y1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1Wdt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1Hgt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2X1_focus
 rule=7
ÄF


/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2Y1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2Wdt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2Hgt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3X1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3Y1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3wdt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3hgt1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1X2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1Y2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1wdt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1hgt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2X2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by:Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2Y2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2wdt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2hgt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3X2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3Y2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3wdt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3Hgt2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1X3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1Y3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1wdt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg1hgt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2X3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2Y3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2wdt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg2hgt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3X3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3Y3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3wdt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtreg3Hgt3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtPacketSize1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMin1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtIPRatio1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMax1_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtPacketSize2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMin2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtIPRatio2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMax2_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtPacketSize3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMin3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtIPRatio3_focus
 rule=7
ÄF

/***********************************************************

 * Description: 
 * Validation Ä the control Ä allow only the Numeric Values
 * 
 * Params:
 * Created by: Franklin Jacques.K  On 2009-09-28 11:48:07
 * History: 
 ***********************************************************/
Äh txtMax3_focus
 rule=7
ÄF


/***********************************************************

 * Description: Ä this Ä Ä check whether the control values are modified or not.
 * set ~changeFlag = 1 ÄB control value modified.

 * Created by: Vimala On 2010-04-30 18:01:13
 ***********************************************************/
Äh chkValueMismatch() 
 checkForModification(ctrlValues$, tempLabelName$) 
ÄF


Äh Form_MouseMove( x, y )
 ChangeMouseCursor(x, y)
ÄF

