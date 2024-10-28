<% 

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	MktScoreBoard.asp									  *
	'* Purpose		:	To view the											  *
	'* Prepared by	:	V.Christopher Britto								  *	
	'* Date			:	20.04.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'*****************************************************************************
	'* General Notes														     *
	'* Description:This is used to check whether the user is Loggod on or not.If *
	'*                          the user has not logged on he will be redirected *
	'*							LogonLinks Page.								 *
	'*							Client Side	:	Javascript						 *
	'*****************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   .2001		V.Christopher Britto					  *
	'*																		  *
	'**************************************************************************
	dim lMarginFlag
	dim lUserType
	lUserType=UCASE(Request.Cookies("UserType"))
	lMarginFlag=Session("MarginFlag")
	select case (lUserType)
		case "T" %>
			<!--#include file="../Includes/TCMLinks.inc" ---->

<%		case "I" %>
				<!--#include file="../Includes/ICMLinks.inc" ---->
<%		case "J" %>
			    <!--#include file="../Includes/TCMLinks.inc" ---->
<%		case "C" %>
				<!--#include file="../Includes/ClientLinks.inc" --->
<%	end select
	
%>