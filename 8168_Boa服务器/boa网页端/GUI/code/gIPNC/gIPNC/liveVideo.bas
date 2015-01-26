/***************************************************************************************\
 * PROJECT NAME          : IPNC          								               *        
 * MODULE NAME           : Live Video                                                  *
 *                                                                                     *
 * Copyright (c) 2008 - GoDB Tech Private Limited. All rights reserved.                *
 * THIS SOURCE CODE IS PROVIDED AS-IS WITHOUT ANY EXPRESSED OR IMPLIED                 *
 * WARRANTY OF ANY KIND INCLUDING THOSE OF MERCHANTABILITY, NONINFRINGEMENT            *
 * OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS FOR A PARTICULAR PURPOSE.          *
 * NEITHER GoDB NOR ITS SUPPLIERS SHALL BE LIABLE FOR ANY DAMAGES WHATSOEVER           *
 * (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS,               *
 * BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER LOSS)                 *
 * ARISING OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF GoDB            *
 * HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.                                *
 *                                                                                     *
 * DO-NOT COPY,DISTRIBUTE,EMAIL,STORE THIS CODE WITHOUT PRIOR WRITTEN                  *
 * PERMISSION FROM GoDBTech.                                                           *
\***************************************************************************************/
/*
Displays live video
*/

option(4+1)
dimi timerCount				  'Used to animate Loading.... value    'TR-30
#include "defines.inc"
#include "common.inc"
#include "functions.inc"
#include "leftMenu.bas"
#define TOOLTIP_TXT_STYLE        8
#define TOOLTIP_TXT_FG           55038
#define TOOLTIP_TXT_BG           6440
#define TOOLTIP_TXT_FONT         7

#define TOOLTIP_WIDTH1           80 
#define TOOLTIP_WIDTH2           100
#define TOOLTIP_WIDTH3           120 
#define TOOLTIP_WIDTH4           80 
#define TOOLTIP_HEIGHT           20

#define GDO_X			   286	
#define GDO_Y			   190	
#define GDO_W              672
#define GDO_H              378

#define GNOTIFY_HTTP_DNLD_FAILURE 40 
#define GNOTIFY_HTTP_DNLD_SUCCESS 41 
#define GNOTIFY_HTTP_DNLD_ABORTED 45 

option(4+1)
dimi previousIndex=-1										'store the dropdown's prevous selIDX
Dimi flagAudio=1                                        	'set the flag to enable/disable the audio
dimi flagAllstreams=0    									'set flag to display all streams                                   
dimi flagSnap=0            									'set the flag to hide/show the frmSnap(Frame)                                                            
Dims alarmstatus$ = "0000"                               	'set the alarm status initially
dims oldAlarmStaus$		                                    'to store the previous alarm status
Dimi imgsnapFlag											'to check the imgAudio Control Click event is called

dimi noofctrl													'Number of Form controls
noofctrl = getfldcount()-LEFTMENUCTRLS                          
dims LabelName$(noofctrl)                                       'Form controls name
dimi XPos(noofctrl)                                             'Form controls X position
dimi YPos(noofctrl)                                             'Form controls Y position
dimi Wdh(noofctrl)                                              'Form controls Width position
dimi height(noofctrl)                                           'Form controls height position
                                                         
#include "liveVideo.inc"

settimer(1000)												    'to enable timer for 1 second
showcursor(3)
dimi rule
#chkdispallstreams.disabled = 1
Dimi xRatio,yRatio
dims ~previewVideoRes$
Dims prvscreen1$,prvscreen2$,prvscreen3$,prvscreen4$,prvScreen5$,prvScreen6$		'capture previous screen before showing tooltip
dimi toolTipPaintFlag = 0
Dims stream$(3),rtspUrl$(3)
Dimi ddstreamNo
ddstreamNo = atol(request$("ddstreamNo"))
Dimi disp1xFlag
disp1xFlag = atol(request$("disp1xFlag"))
dimi democfg                 									 'Example drop down selected value     'TR-30
dims ~videoPlayerVersion$	 									 'Video Player Version					'TR-32
dimi blnCanGetAlarmStatus
dimi selExampleVal
dimi audiomode													  'Holds audio mode
dimi saveSuccess = 0	 			'Value of 1 is success
dimi animateCount = 0 	 			' Stores the count for the animation done.
dims error$ = "" 					'Stores the error returned while saving.
dims dispstr$ 						'To process the animated string	
dimi audioStatusFlag = 0
end

/***********************************************************
'** form_load
 *	Description: Align all the controls based on resolution
 *		         Fetch all keyword from ini.htm
 *				 Call the LoadStreamValue Function, to load the stream name into drop down box.
 *				 Create video player(GDO) to display video.
 *	Created by: Franklin Jacques On 2009-05-19 15:54:31
 ***********************************************************/
sub form_load	
	
	dimi retVal	
	dims sdInsertVal$
	dimi findPos,sdInsert
	
	call displayControls(LabelName$,XPos,YPos,Wdh,height)
	
	#frmSnap.w = (#btncancel.x+#btncancel.w) - #frmsnap.x + 10
	#frmSnap.h = (#btncancel.y +#btncancel.h)- #frmsnap.y + 10
		
	call getINIValus()	
	call loadStreamValues()
	
	getReloadTime()   'TR-40
	
	assignSelectedImage("imgmenu")
	setfocus("imgmenu")
	if ~loginAuthority = ADMIN or ~loginAuthority = OPERATOR then		
		showSubMenu(0,0)		
	endif
	setfocus("ddstream")		
	
	'Get stream name and rtsp url from camera
	loadStreamDetails(stream$,rtspUrl$)			'TR-04
	pprint rtspUrl$(0);rtspUrl$(1);rtspUrl$(2)
	if stream$(0) = "" then
		msgbox "Streams not available"
		loadurl("!auth.frm")
	end if	
	
	'Loads the stream to drop down 
	call addItemsToDropDown("ddstream", stream$, -1)	
		  	
	if disp1xFlag = 1 then 
		#ddstream$=ddstreamNo
	endif
	
	'create video player(GDO) to display video.	
	createGDOControl("gdoVideo",GDO_X,GDO_Y,GDO_W,GDO_H)
	
	'Get aspect ratio for the selected stream
	calVideoDisplayRatio(#ddstream.itemlabel$(#ddstream.selidx),xRatio,yRatio)		'TR-04 
	~previewVideoRes$ = #ddstream.itemlabel$(0)
	
	'Get SD card inserted value
	retVal =  getSDCardValue(sdInsertVal$)
		
	if retVal > 0  then
		findPos = find(sdInsertVal$,"sdinsert=")
		findPos += len("sdinsert=")
		sdInsert = atol(mid$(sdInsertVal$,findPos))		
	end if

	if sdInsert = 0 then
		#imgsdcard.hidden = 1
	end if
	
	'Get video player version 
	~videoPlayerVersion$ = #gdovideo.version$
	blnCanGetAlarmStatus = 1
	
	#chkDispallstreams.hidden = 1
End Sub


/***********************************************************
'** getINIValus
 *	Description: 
 *		Load the keywordvalues from INI file.
 *		Get the camera name.

 *	Created by: Partha Sarathi.K On 2009-03-18 11:35:15
 ***********************************************************/
sub getINIValus()
	
	dimi retVal
		
	if request$("isINIValue") <> "1" then
	
		~maxPropIndex = 0

		retVal = loadIniValues()
	
		if ~maxPropIndex = 0 then 
			msgbox("Unable to load initial values.\n ini.htm unavailable")
			loadurl("!auth.frm")
		endif
		
		~title$ = getTitle$()
		
	endif
	
End Sub


/***********************************************************
'** Form_paint
 *	Description: paint Gray image for storage options if click snap is selected.
 
 *	Created by: Franklin Jacques.K On 2009-03-11 16:00:49
 ***********************************************************/
sub Form_paint()
	if #frmSnap.hidden=0	then
		putimage2(~optImage$,#optStorage[1].x,#optStorage[1].y,5,0,0)			'TR-28
		putimage2(~optImage$,#optStorage[2].x,#optStorage[2].y,5,0,0)			'TR-28
	end if
End Sub



/***********************************************************
'** setAudioControl
 *	Description: Enable/Disable audio for video player
 
 *	Created by:Franklin  On 2009-03-23 17:40:14
 ***********************************************************/
sub setAudioControl
		
	if flagAudio=1 then
		#gdovideo.Audio=1
	elseif flagAudio=0 then
		#gdovideo.Audio=0
	endif
	
	'#gdoVideo.hidden=0		
	'#lblLoad.hidden=1	
End Sub

/***********************************************************
'** loadStreamValues
 *	Description: Load the stream name/Example into drop down box.
 *				 Load click snap user input values

 *	Created by: Partha Sarathi.K On 2009-03-17 18:43:53
 ***********************************************************/
sub loadStreamValues()
	
	Dims clicksnapfilename$,democfgname$,ddValue$
	Dimi audioenable,clicksnapstorage,frecognition
	dimi ret
        
    'Get values keyword values
	ret = getLiveVideoOptions(clicksnapfilename$,democfgname$,audioenable,_
							  clicksnapstorage,democfg,audiomode)
	
	if ret = -1 then
		msgbox("unable to fetch values")
		return
	endif
	
	flagAudio=audioenable
	iff flagAudio < 0 then flagAudio = 0
	
	'display audio on image if audio is on, if not off image.
	if flagAudio=1 then 
		#imgaudio.src$="!audio_on.jpg"
	else
		#imgaudio.src$="!audio_off.jpg"
	endif
	
	split(ddValue$,democfgname$,";")
	call addItemsToDropDown("ddExample", ddValue$, democfg)
	#txtSnapText$=clicksnapfilename$
	#optStorage$=clicksnapstorage
End Sub


/***********************************************************
'** form_Mouseclick
 *	Description:  Call this function to return control window handle 
 	
 *	Params:
'*		x: Numeric - X Position
 *		y: Numeric - Y Position 
 *	Created by:Jacques Franklin  On 2009-03-11 18:17:58
 *	History: 
 ***********************************************************/
sub form_Mouseclick(x,y)
	if audioStatusFlag = 1 then
		mousehandled(2)
	endif
	call getFocus()	
End Sub


/**************************************************************************
'** form_mousemove
 *	Description: Display Tool tip if click snap is not enabled
 
 *	Params:
'*		x: Numeric - X Position
 *		y: Numeric - Y Position
 *	Created by:Jacques Franklin  On 2009-03-13 14:58:09
 ***************************************************************************/
sub form_mousemove(x,y)
	iff flagSnap=0 then call toolTip_mouseOver(x,y)
	ChangeMouseCursor(x, y)
	MouseHandled(2)	
End Sub


/***********************************************************
'** toolTip_mouseOver
 *	Description: Displays tool tip for the header icons
 		
 *	Params:
'*		x: Numeric - Mouse move x value
 *		y: Numeric - Mouse move y value
 *	Created by:Jacques Franklin  On 2009-09-23 11:45:37
 *	History: karthi on 14-Oct-10
 ***********************************************************/
 '*** Code modifed by karthi on 14-Oct-10 for the Tool Tip issue on GUI.
sub toolTip_mouseOver(x,y)
	if x>=#imgDisplay1x.x and x<=(#imgDisplay1x.x+#imgDisplay1x.w) and y>=#imgDisplay1x.y and y<=(#imgDisplay1x.y+#imgDisplay1x.h) then					'TR-13
		call clearToolTip
		DRAWRECT(#imgDisplay1x.x,#imgDisplay1x.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH1+60,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgDisplay1x.x,#imgDisplay1x.y+TOOLTIP_HEIGHT+30,"1X Display",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
		paint(#imgDisplay1x.x, #imgDisplay1x.y+TOOLTIP_HEIGHT+30, TOOLTIP_WIDTH1+60, TOOLTIP_HEIGHT)
	elseif x>=#imgsnap.x and x<=(#imgsnap.x+#imgsnap.w) and y>=#imgsnap.y and y<=(#imgsnap.y+#imgsnap.h) then		
		call clearToolTip
		DRAWRECT(#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH1,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,"Snapshot",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)					'TR-37
		paint(#imgsnap.x+10, #imgsnap.y+TOOLTIP_HEIGHT+30, TOOLTIP_WIDTH1, TOOLTIP_HEIGHT)
	elseif x>=#imgalarm.x and x<=(#imgalarm.x+#imgalarm.w) and y>=#imgalarm.y and y<=(#imgalarm.y+#imgalarm.h) then 		
		call clearToolTip
		DRAWRECT(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,"Alarm Status",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
		paint(#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2,TOOLTIP_HEIGHT)
	elseif x>=#imgrecord.x and x<=(#imgrecord.x+#imgrecord.w) and y>=#imgrecord.y and y<=(#imgrecord.y+#imgrecord.h) then		
		call clearToolTip
		DRAWRECT(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,"Recording Status",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
		paint(#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT)
	elseif x>=#imgaudio.x and x<=(#imgaudio.x+#imgaudio.w) and y>=#imgaudio.y and y<=(#imgaudio.y+#imgaudio.h) then		
		call clearToolTip
		DRAWRECT(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,"Toggle Audio",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
		paint(#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3,TOOLTIP_HEIGHT)
	elseif #imgsdcard.hidden = 0 and x>=#imgsdcard.x and x<=(#imgsdcard.x+#imgsdcard.w) and y>=#imgsdcard.y and y<=(#imgsdcard.y+#imgsdcard.h) then		
		call clearToolTip
		DRAWRECT(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4,TOOLTIP_HEIGHT,1,1,TOOLTIP_TXT_BG,TOOLTIP_TXT_BG)
		textout(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,"SD Card",TOOLTIP_TXT_STYLE,TOOLTIP_TXT_FG,TOOLTIP_TXT_FONT)
		paint(#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4,TOOLTIP_HEIGHT)
	else
		call clearToolTip
		paint()		
	endif 
	
End Sub
'*** Function added by karthi on 14-Oct-10 for the Tool Tip issue on GUI
/***********************************************************
'** clearToolTip
 *	Description: 
 *		
 *		
 *	Params:
 *	Created by:  On 2010-11-16 16:15:49
 *	History: 
 ***********************************************************/
sub clearToolTip
	if toolTipPaintFlag = 1 then
		putimage(prvScreen1$,#imgsnap.x+10,#imgsnap.y+TOOLTIP_HEIGHT+30,5,1)
		putimage(prvScreen2$,#imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,5,1)
		putimage(prvScreen3$,#imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,5,1)
		putimage(prvScreen4$,#imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,5,1)
		putimage(prvScreen5$,#imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,5,1)
		putimage(prvScreen6$,#imgDisplay1x.x,#imgDisplay1x.y+TOOLTIP_HEIGHT+30,5,1)	
	end if
	'TR-13			
End Sub


/***********************************************************
'** chkDispallstreams_Click
 *	Description: 
 *		check box click event to load allStreamsVideo.frm

 *	Created by: Franklin On 2009-03-12 15:04:26
 ***********************************************************/
Sub chkDispallstreams_Click
	if canReload = 1 then
		#chkDispallstreams.checked = 1
		if flagAllstreams=0 then
			flagAllstreams=1
		elseif flagAllstreams=1 then
			flagAllstreams=0
		endif
		iff ~wait <1 then return 
		loadurl("!allStreamsVideo.frm&flagaudio="+flagaudio)
	else 
		#chkDispallstreams.checked = 0
	end if	
End Sub

/***********************************************************
'** form_timer
 *	Description: To get the alarmstatus and display the 
				 alarm status
				 to set wait flag when switching between forms
 *	Method: getAlarmStatus()
			displayAlarmStatus()

 *	Created by: Franklin  On 2009-03-13 17:03:05
 *	History: 
 ***********************************************************/
Sub form_timer
	~wait = ~wait +1									'added by Franklin to set wait flag when switching between forms
	iff ~wait > 1 then #chkdispallstreams.disabled = 0  'added by Franklin to set wait flag when switching between forms
	if blnCanGetAlarmStatus = 1 then
		oldAlarmStaus$ = alarmstatus$
		getAlarmStatus(alarmstatus$)
		blnCanGetAlarmStatus = 0		
	end if
	
	if canReload = 0 then
		if animateCount <= ~reLoadTime then
			animateCount ++
			animateLabel("lblload",dispstr$)				'animate updating... value				
		else
		'*** Code Modified by karthi on 11-Nov-10 to fix the reload issue while toggling the audio	
			if audioStatusFlag = 1 then
				call displaySaveStatus(audioStatusFlag)
			else
				call displaySaveStatus(saveSuccess)
			endif
		end if
	end if
End Sub

/***********************************************************
'** displayAlarmStatus
 *	Description: Based on the alarm status display the record and alarm status.

 *	Created by: Franklin On 2009-03-18 17:17:17
 *	History: Modified by Partha Sarathi.K
 ***********************************************************/
sub displayAlarmStatus()	
	dims Tempstatus$
	dimi AlarmData
	tempStatus$ = "0x" + alarmstatus$
	alarmData = StrToInt(tempStatus$)
	
	pprint "alarmData";alarmData
	
	'*** Code added by karthi on 24-sep-10 to process alarmData using 8-Bit Masking.
	pprint format$("%x",ANDB(alarmData,0x000F)) 

	if ANDB(alarmData,0x000F) = 0 then
		#imgalarm.src$ = "!alarm_off.jpg"
	else
		#imgalarm.src$ = "!alarm_on.jpg"
	endif
	
	if  alarmData >15  then
		#imgrecord.src$ = "!record_1.jpg"
	else
		#imgrecord.src$ = "!record_2.jpg"
	end if
	
	#imgrecord.paint(1)
	#imgalarm.paint(1)
	
End Sub



/***********************************************************
'** imgsnap_Click
 *	Description: Hide snap frame if flagSnap is set.
 *				 show snap frame if flagSnap is not set.
 *	Created by: Franklin  On 2009-06-09 18:44:25
 *	History: 
 ***********************************************************/
Sub imgsnap_Click
	if canReload = 1 then
		if flagSnap=1 then
			flagSnap=0
			#frmSnap.hidden=1		
			#imgsnap.src$ = "!snap_on.jpg"					'BFIX-07
			setfocus("imgalarm")
		elseif flagSnap=0 then
			flagSnap=1	
			#frmSnap.hidden=0	
			#imgsnap.src$ = "!snap_off.jpg"					'BFIX-07
			#optStorage[1].disabled = 1						'TR-28
			#optStorage[2].disabled = 1						'TR-28
			#optStorage[1].fg=UNSELECTED_TXT_COLOR			'TR-28
			#optStorage[1].selfg=UNSELECTED_TXT_COLOR		'TR-28
			#optStorage[2].fg=UNSELECTED_TXT_COLOR			'TR-28
			#optStorage[2].selfg=UNSELECTED_TXT_COLOR		'TR-28	
			setfocus("txtsnaptext")
		endif	
		showimages("imgsnap","!snap_on.jpg","!snap_off.jpg")	
	end if	
End Sub


/***********************************************************
'** imgaudio_Click
 *	Description: To set the audio flag and toggle the image 
				 subsequent to the audio flag
 *		
 *		
 *	Params:
 *	Created by: Franklin On 2009-07-16 12:59:37
 *	History: 
 ***********************************************************/
Sub imgaudio_Click
'*** Code Modified by karthi on 11-Nov-10 to fix the reload issue while toggling the audio	
if canReload = 1 then
		dimi a	
		a = #gdoVideo.stop(1)				'Stop video before enable/disable audio
		#gdoVideo.hidden = 1
		#lblload.hidden = 0 
		#lblload.x = #imgsnap.x
		#lblload.y = #gdobg.y + (#gdobg.h/2) - 30
		'sleep(1000)
		audioStatusFlag = 1
		imgsnapFlag=1
		if flagAudio=1 then
		  flagAudio=0
		  setAudioStatus(flagAudio,audiomode)
		elseif flagAudio=0 then
		  flagAudio=1
		  setAudioStatus(flagAudio,audiomode)	
		endif
		if getReloadFlag() = 1 then									'TR-45
			canReload = 0
			animateCount = 1
			dispstr$ = "Updating"
			call animateLabel("lblload",dispstr$)
		else // If Reload animation is not required
			canReload = 1
		end if
		showimages("imgaudio","!audio_on.jpg","!audio_off.jpg")
		if canReload = 1 then
			saveSuccess = audioStatusFlag
			displaysavestatus(saveSuccess)
		end if
	end if
End Sub


' To set the showcursor for the controls
Sub chkDispallstreams_Blur
	showcursor(3)
End Sub

Sub chkDispallstreams_Focus
	showcursor(1)
End Sub

Sub optStorage_Blur
	showcursor(3)
End Sub


Sub optStorage_Focus	
	iff curfld$() = "optStorage" then showcursor(1)   'TR-28
End Sub

/***********************************************************
'** btnCancel_Click
 *	Description: Hide the snap frame
 *	Created by:  On 2009-05-20 11:36:38
 *	History: 
 ***********************************************************/
Sub btnCancel_Click
	flagSnap=0
	#frmSnap.hidden=1
	setfocus("imgalarm")
	#imgsnap.src$ = "!snap_off.jpg"			'BFIX-07
End Sub


/***********************************************************
'** btnOk_Click
 *	Description: saves the values enter in snap frame controls.
 *	Created by:  On 2009-05-20 11:12:33
 *	History: 
 ***********************************************************/
Sub btnOk_Click
	dimi ret 
	ret = setLiveVideoOptions(#txtSnapText$, #optStorage)
	call imgsnap_Click	
End Sub


/***********************************************************
'** Form_KeyPress
 *	Description: 
			To set wait flag before switching between forms	
			Checks entered key value based on the rule set to that user input control
 *		
 *	Params:
'*		Key: Numeric - char code of the key pressed
 *		FromMouse : Numeric - char code of the mouse pressed
 *	Created by : Partha Sarathi.K On 2009-03-04 14:04:47
	Modified by: Jacques Franklin On 2009-03-25 11:53:50

 ***********************************************************/
Sub Form_KeyPress( Key, FromMouse )
	
	if key = 26 or key = 25 then
		keyhandled(2)
	else
		keyhandled(0)
	endif
	
	if Key = 15 then
	iff ~wait<=1 then return
		~wait = 2
	endif
	
	scroll_keypressed(key) 		' Lock mouse scroll
	dims keypressed$
	keypressed$ = chr$(getkey())	
	iff (CheckKey(Key,rule,keypressed$))=1 then keyhandled(2)	
	setLeftMenuFocus(Key,0)
End Sub


/***********************************************************
'** form_complete
 *	Description: Resize video as per the aspect ratio of the stream
 *		    	 and set the video player properties
 
 *	Created by: Franklin Jacques On 2009-03-19 10:40:02
 ***********************************************************/
sub form_complete
	~wait = 0
	dimi availableW,availableH
	dimi gdoCurX, gdoCurY, gdoCurWidth, gdoCurHeight
	availableW = ~menuXRes - #imgleftmenu.w - 50
	availableH = (#imgmainbg.DESTH-30) - (GDO_Y * ~factorY) 
	pprint xRatio,yRatio
	gdoCurX = GDO_X		
	gdoCurY=GDO_Y *~factorY
	gdoCurWidth=availableW
	gdoCurHeight=availableH
	checkAspectRatio(gdoCurWidth, gdoCurHeight,xRatio,yRatio)
	
	#gdobg.x=gdoCurX-2
	#gdobg.y=gdoCurY-2
	#gdobg.w=gdoCurWidth+2
	#gdobg.h=gdoCurHeight+2
	#gdoVideo.x = gdoCurX
	#gdoVideo.y = gdoCurY
	#gdoVideo.w = gdoCurWidth
	#gdoVideo.h = gdoCurHeight
	
	call setAudioControl	
	call getPreviousScreen
	toolTipPaintFlag = 1
	call disp_streams
	update							'Added by Vimala
	SETOSVAR("*FLUSHEVENTS", "")	// Added By Rajan
End Sub

/***********************************************************
'** getPreviousScreen
 *	Description: 
 *		To store the previous screen and repaint the screen after showing 
        the tooltip

 *	Created by: Franklin Jacques.K  On 2009-09-23 12:59:03

 ***********************************************************/
sub getPreviousScreen
	getimage(prvScreen1$, #imgsnap.x+10, #imgsnap.y+TOOLTIP_HEIGHT+30, TOOLTIP_WIDTH1+10, TOOLTIP_HEIGHT+10)
	getimage(prvScreen2$, #imgalarm.x+10,#imgalarm.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH2+10,TOOLTIP_HEIGHT+10)
	getimage(prvScreen3$, #imgrecord.x+10,#imgrecord.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3+10,TOOLTIP_HEIGHT+10)
	getimage(prvScreen4$, #imgaudio.x+10,#imgaudio.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH3+10,TOOLTIP_HEIGHT+10)
	getimage(prvScreen5$, #imgsdcard.x+10,#imgsdcard.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4+10,TOOLTIP_HEIGHT+10)
	getimage(prvScreen6$, #imgDisplay1x.x+10,#imgDisplay1x.y+TOOLTIP_HEIGHT+30,TOOLTIP_WIDTH4+10,TOOLTIP_HEIGHT+10)			'TR-13
End Sub


/***********************************************************
'** txtsnaptext_focus
 *	Description: 
 *		To set focus for the control

 *	Created by: Franklin  On 2009-07-16 14:01:12
 ***********************************************************/
Sub txtsnaptext_focus	
	rule = 17 //rule set for alphanumeric and undercore
	showcursor(3)
End Sub


/***********************************************************
'** ddStream_Change
 *	Description: 
 *		To set the URL(required stream) during the change event
 *		
 *	Params:
 *	Created by:Franklin Jacques  On 2009-06-10 15:13:36
 *	History: 
 ***********************************************************/
Sub ddStream_Change
	if canReload = 1 then
		calVideoDisplayRatio(#ddstream.itemlabel$(#ddstream.selidx),xRatio,yRatio)				' TR-04
		call  form_complete	
		~wait = 2
	end if
End Sub


/***********************************************************
'** disp_streams
 *	Description: 
 *		To set the URL for the video player(GDO) Control
 *		 
 *		rtspUrl$()- Array holds avaliable rtsp stream values *	
 *	Created by: Franklin Jacques  On 2009-07-31 19:01:44
 ***********************************************************/
sub disp_streams()
	
	dims url$,value$
	dimi ret,a
	iff previousIndex=#ddstream.selidx and imgsnapFlag=0 then return
		
	value$ = rtspUrl$(#ddstream.selidx)	
	
	'Video must be stoped before playing a stream
	a = #gdovideo.stop(1)	
	
	dimi playVideoFlag
	dims dispStr$
	
	playVideoFlag = checkForStreamRes(stream$(#ddstream.selidx))
	
	if playVideoFlag = 1 then
		dispStr$ = ~Unable_To_Display_Msg$
		#lblload.hidden = 0		
		#gdovideo.hidden = 1	
	else
		dispStr$ = "Loading . . . . "
		'Play stream
		#gdovideo.hidden = 0
		a = #gdovideo.play(value$)		
	end if
	
	#lblload$ = dispStr$
	pprint gettextwidth(dispStr$,8,9)
	#lblload.w = #gdobg.w - (#gdobg.w/3)
	#lblload.h = 75
	#lblload.x =  ((#gdobg.w/2) - (#lblload.w/2)) +  #gdobg.x			
	
	previousIndex=#ddstream.selidx
	
	if #ddstream.itemcount <= 1 then 
		#chkDispallstreams.hidden = 1
	else
		#chkDispallstreams.hidden = 0
	endif
	
	imgsnapFlag=0
	#chkDispallstreams.paint(1)	
	#lblload.paint(1)	
End Sub

/***********************************************************
'** imgDisplay1x_Click
 *	Description: To load the Display1x From

 *	Created by:  On 2009-10-01 19:00:24

 ***********************************************************/
Sub imgDisplay1x_Click	
	if canReload = 1 then
		Dimi streamNo
		streamNo = atol(#ddstream$)
		LoadUrl("!display1xMode.frm&streamNo="+streamNo)
	end if
End Sub



/***********************************************************
'** imgsdCard_Click
 *	Description: Load SD Card explorer screen

 *	Created by:Vimala  On 2010-04-30 15:23:55
 ***********************************************************/
Sub imgsdCard_Click	
	if canReload = 1 then
		loadurl("!SDExplorer.frm")	
	end if
End Sub



/***********************************************************
'** ddExample_Click
 *	Description: Get selected example value

 *	Created by:Vimala  On 2010-04-30 15:24:26
 ***********************************************************/
Sub ddExample_Click	
	selExampleVal = #ddexample.selidx
End Sub



/***********************************************************
'** ddExample_Change
 *	Description: On changing the value selected, 
 *				 display a message and on confirmation should 
 *				 set the selected value  in the IPNC.
 
 *	Created by: Vimala  On 2009-12-15 00:30:25
 ***********************************************************/
Sub ddExample_Change						'TR-30
	if canReload = 1 then
		iff selExampleVal = #ddexample.selidx then return
		dimi a
		#gdobg.hidden = 1
		#gdovideo.hidden = 1	
		update
		msgbox("This will change the configuration to demo modes selected.\n Do you want to continue?",3)
		
		if confirm() = 1 then
			a = #gdoVideo.stop(1)				
			#lblload.x = #imgsnap.x
			#lblload.y = #gdobg.y + (#gdobg.y/2)
			#lblload.hidden = 0 
					
			dimi retVal ,i
			retVal = setExampleValue(#ddexample)
					
			saveSuccess = retVal
			'Based on reload flag wait for the camera to restart
			if getReloadFlag() = 1 then									'TR-45
				canReload = 0
				animateCount = 1
				dispstr$ = "Loading"
				call animateLabel("lblload",dispstr$)
			else // If Reload animation is not required
				canReload = 1
			end if
		
			if canReload = 1 then	//Do the remaining actions after reload animation is done
				call displaySaveStatus(saveSuccess)		
			end if
			
		else		
			#ddexample$ = democfg
			#gdobg.hidden = 0
			#gdovideo.hidden = 0
		end if
	end if
End Sub


/***********************************************************
'** displaySaveStatus
 *	Description: Call this function to display save status message
 
 *	Params:
 *		saveStatus: Numeric - Greater then 1 for success ,0 for failure message 
 *	Created by: Vimala On 2010-06-25 12:00:34
 *	History: 
 ***********************************************************/
Sub displaySaveStatus(saveStatus)
''*** Code Modified by karthi on 11-Nov-10 to fix the reload issue while toggling the audio	
	if saveStatus > 0 then
		if audioStatusFlag = 1 then
			audioStatusFlag = 0 
			call setAudioControl
			call disp_streams
			canReload = 1
		else			
			msgbox("Modified Demo Mode for camera "+~title$)
			loadurl("!livevideo.frm")
		end if
	else		
		if audioStatusFlag = 0 then
			call setAudioControl
			call disp_streams
		else
			msgbox("Demo Mode failed for the camera "+~title$)	
			#gdobg.hidden = 0
			#gdovideo.hidden = 0
			previousIndex = -1
			call disp_streams
		endif
	endif
End Sub


/***********************************************************
'** Form_Notify
 *	Description: Server Event Listeners are Notified here.
 *				 Continuously checks for Alarm and record status.
 
 *	Created by:  On 2010-04-30 15:25:10
 ***********************************************************/
Sub Form_Notify	
	dimi NotifySrc, NotifyData, ret
	dims Message$, MsgType$, optionValue$(2)
	NotifySrc=getmessage(NotifyData, MsgType$, Message$,"")	
	if NotifySrc = GNOTIFY_HTTP_DNLD_SUCCESS then		
		ret = split(optionValue$, Message$ , "=")
		if ret > 1 then
			alarmStatus$ = trim$(optionValue$(1))
			if lcase$(oldAlarmStaus$) <> lcase$(alarmstatus$) then
				call displayAlarmStatus()
			endif
		endif
		blnCanGetAlarmStatus = 1
	elseif NotifySrc = GNOTIFY_HTTP_DNLD_FAILURE or NotifySrc = GNOTIFY_HTTP_DNLD_ABORTED then
		blnCanGetAlarmStatus = 1
	endif
End Sub



/***********************************************************
'** getReloadTime
 *	Description: Call this function to get the camera restart time 

 *	Created by: Vimala  On 2010-01-05 06:19:02
 ***********************************************************/
Sub getReloadTime()   'TR-40
	dimi retVal,reloadTime
	retVal = getLoadingTime(reloadTime)
	
	if retVal >= 0 then
		~reLoadTime = reloadTime
	end if	
	
	pprint "reLoadTime = " + ~reLoadTime
End Sub



Sub savePage()
	'Please don't delete
End Sub


sub chkValueMismatch()	
	'Please don't delete
End Sub




