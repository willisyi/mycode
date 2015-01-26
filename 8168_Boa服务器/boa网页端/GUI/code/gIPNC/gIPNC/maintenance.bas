/***************************************************************************************\
 * PROJECT NAME          : IPNC          								               *        
 * MODULE NAME           : Maintenance Screen                                              *
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

option(4+1)
showcursor(3)
#include "defines.inc"
#include "common.inc"
#include "functions.inc"
#include "leftMenu.bas"

dimi noofctrl													'Number of Form controls
noofctrl = getfldcount()-LEFTMENUCTRLS                          
dims LabelName$(noofctrl)                                       'Form controls name
dimi XPos(noofctrl)                                             'Form controls X position
dimi YPos(noofctrl)                                             'Form controls Y position
dimi Wdh(noofctrl)                                              'Form controls Width position
dimi height(noofctrl)                                           'Form controls height position

dimi ret
dimi bkupfirmware												'*** Variable added by karthi on 6-Dec-10
                                                         
#include "maintenance.inc"
~wait = 2
ret  = getFirmwareValue(bkupfirmware)
end

/***********************************************************
'** Form_Load
 *	Description: Call displayControls function to algin contorls
 *				 based on the screen resolution.
 *				 Highlight the selected link in left menu.
 *				 Load maintenance(.htm) page from camera

 *	Created by: Vimala On 2009-10-19 14:24:55
 ***********************************************************/
Sub Form_Load
	call displayControls(LabelName$,XPos,YPos,Wdh,height)

	#gdomaintenance.h = #gdomaintenance.h*~factorY 	-20	
	#gdomaintenance.w = #imgmainbg.w - 30
	#lblnote.h = 47 * ~factorY 
		
	assignSelectedImage("imgmenu[3]")		
	setfocus("imgmenu[3]")
	showSubMenu(0,0)
	#cmdback.hidden = 1
	
	'*** Code modified by karthi on 6-Dec-10 as per the CR dated on 3-Dec-10
	if bkupfirmware = 1 then 		
		#gdomaintenance.navigate$(~camAddPath$+"\MaintJ.htm?bkup=1")				'CR-02	
	else
		#gdomaintenance.navigate$(~camAddPath$+"\MaintJ.htm")
	endif
		setfocus("lblnote")
End Sub

/***********************************************************
'** cmdBack_Click
 *	Description:  Load maintenance(.htm) page from camera
 *		
 *	Created by: Vimala On 2009-10-21 18:46:25
 *	History: 
 ***********************************************************/
Sub cmdBack_Click	
	'*** Code modified by karthi on 6-Dec-10 as per the CR dated on 3-Dec-10
	if bkupfirmware = 1 then 		
		#gdomaintenance.navigate$(~camAddPath$+"\MaintJ.htm?bkup=1")				'CR-02	
	else
		#gdomaintenance.navigate$(~camAddPath$+"\MaintJ.htm")
	endif
	setfocus("imgmenu[3]")
End Sub

/***********************************************************
'** gdomaintenance_BeforeNavigate
*	Description: Shows back button when URL changes

 *	Params:
 *		DimS Page$: String - Navigate URL
 *	Created by:Vimala  On 2009-11-09 10:52:58
 *	History: 
 ***********************************************************/
Sub gdomaintenance_BeforeNavigate2(dims Page$)	
	dimi spltCount
	dims temp$,url$
	pprint "Page$ =" + Page$	
	iff Page$="" then return
	pprint find(Page$,"\MaintJ.htm\"")
	if find(Page$,"about:blank")=-1  then
		if find(Page$,"\MaintJ.htm\"") >= 0 or find(Page$,"/vb.htm?")>=0 or find(Page$,"?bkup=1")>=0 then
			#cmdback.hidden = 1
			#lblnote.hidden = 0
		else 
			#cmdback.hidden = 0
			#lblnote.hidden = 1
		end if
	end if
	update
	
End Sub


sub chkValueMismatch()	
	'Please Do not delete this proc
End Sub

sub savePage()
	'Please Do not delete this proc
End Sub

Sub Form_MouseMove( x, y )
	ChangeMouseCursor(x, y)
End Sub

/***********************************************************
'** getFirmwareValue
 *	Description: Used to get value from camera for backup and restore firmware
 *		
 *		
 *	Params:
 *	Created by:karthi  On 2010-12-06 12:20:52
 *	History: 
 ***********************************************************/
function getFirmwareValue(byref dimi bkupfirmware)
	dims tempVal$
	dims varName$(1)  = ("bkupfirmware")
	dims propName$(1) = ("gbkupfirmware")
	dims values$(1)
	
	dimi retVal	
	retVal = getIniValues(propName$, values$)	
	if retVal = 0 then	
		dimi idx			
		for idx= 0 to ubound(values$)					
			{varName$(idx)} = strtoint(values$(idx))
		next			
	endif
	return retVal					 
End Function
