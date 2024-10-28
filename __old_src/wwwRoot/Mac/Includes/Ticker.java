/*	*************************************************************************
	* Application	:	BOOE		
	* Module		:	Applet Ticker
	* File name	:	Ticker.Java
	* Purpose		:	This is used to display the ticker
	* Prepared by	:	Vijay Venkataraman.G
	* Date			:	25.04.2001	
	* Copyright	:	(C) SSI Technologies,India
	*
	**************************************************************************

	**************************************************************************
	* General Notes
	* This is used to display the ticker	
	* Client Side	:	Java Applet	
	*
	**************************************************************************

	**************************************************************************
	* Revision History
	* Version No. 			Date
	*	1		   05.05.2001		Vijay Venkataraman.G  First Baseline	  *
	*																		  *
	************************************************************************** */


import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Color;
import java.awt.Image;
import java.awt.Event;
import java.awt.Cursor;

import java.io.InputStream ;
import java.io.DataInputStream ;

import java.util.Vector ;
import java.util.Enumeration ;
import java.util.*;
import java.net.URL;



public class Ticker extends java.applet.Applet implements Runnable
{

	// Declare the controlling thread for the applet
	public	Vector dFile = new Vector( 5, 5 );
	String temp;
	Thread scrollmessage;
	Thread t;
	private char        cSep = ';'   ;
	String sMess ;
	boolean bLoc = false ;

	// Declare the details for the message to be displayed
	int s_h			;	// Longueur du message
	int iMax		;	// Nombre de Message 
	int iActif = 999;	// Message Actif
	int iCur   = -1 ;

	int cBk = 0x000000 ;		// Nombre de Message 

	// Variables controlling the display of the message
	int 	x_coord,		// present x-position
			y_coord,		// present y-position
			speed,			// scrolling amount
			iPas,			// (integer) pas entre 2 messages
			delay,			// scrolling speed
			newsDelay;      // news fetch delay	
	String file;



	// for storing the dimensions of the applet
	int aWidth, aHeight;



	// for double buffering to prevent flicker
	Image offScreenImage;
	Graphics offScreen;

	// Font control variables
	Font wFont1;				// Message 
	Font wFont2;				// Message Actif
	int cT1 = 0xFFFFFF ;		// Message 
	int cT2 = 0xFFFF00 ;		// Message Actif
	FontMetrics wM;

	


	public void init() {
		// get the speed of the scrolling
		temp = getParameter("speed");
		speed= (temp==null) ? 10 : Integer.parseInt( temp );

		temp = getParameter("delay");
		delay= (temp==null) ? 1: Integer.parseInt( temp );

		temp = getParameter("pas");
		iPas = (temp==null) ? 20 : Integer.parseInt( temp );

		temp = getParameter("bgcolor");
		cBk = (temp==null) ? 0xDADAC5 : Integer.parseInt( temp );

		temp = getParameter("local");
		if (temp != null) bLoc = true ;

		temp = getParameter("cSep");
		if (temp != null) cSep = temp.charAt(0) ;

		temp = getParameter("Font1") ;
		if (temp == null) 
			temp = "Arail, 10, 1, " + 0x004400 + " " ;

		setFont(1, temp) ;

		temp = getParameter("Font2") ;
		if (temp == null) 
			temp = "Arail, 10, 2, " + 0x004400 + " " ;

		setFont(4, temp) ;

		// fichier
		temp = getParameter("file");
		if (temp==null)
			file="Ticker.asp" ;
		else
			file=temp;
		
		temp = getParameter("newsDelay");
		newsDelay = (temp==null) ? 10000 : Integer.parseInt( temp );

			

		wM = getFontMetrics (wFont1);

		//readFile(temp) ;
		//t = new Thread(this,"News");
		//t.start();
	} // end of init
	public void setFont(int z, String s) {
		int j = 0 ;
		int k = 0 ;
		int i ;

		String sF = "" ;
		int iS = 10 ;
		int iT = 1 ;

		int iC = 0xFFFFFF ; 

		String p ;

		while (true) {
			i = s.indexOf(',', j) ;
			if (i > 0)
				p = new String(s.substring(j, i).trim()) ;
			else
				p = new String(s.substring(j).trim()) ;

			if ((i>-1) || (p.length() > 0)) {
				if ( k == 0) sF   = new String(p) ;
				if ( k == 1) iS   = Integer.parseInt(p) ;
				if ( k == 2) iT   = Integer.parseInt(p) ;
				if ( k == 3) iC   = Integer.parseInt(p) ;
				k++ ;
			}

			if (i == -1)  break ;
			else j = i + 1 ;
		}
		
		Font f = new Font(sF, iT, iS) ;
		if (f == null)	f = getFont() ;

		if (z == 1) {
			wFont1 = f ;
			cT1 = iC ;
		}
		else {
			wFont2 = f ;
			cT2 = iC ;
		}

	}




// control the starting of the applet
	public void start() {
		
		
		t = new ReadNews(file,newsDelay);
		t.setPriority(Thread.MAX_PRIORITY);
		t.start();
		
		
		// start the thread
		
		scrollmessage = new Thread(this);
		scrollmessage.setPriority(Thread.MIN_PRIORITY);
		scrollmessage.start();
		
	
		
		
	} // end of start


 

	public void getNews()
	{
		//readFile("Ticker.asp");
	}


// control the running of the applet
		public void run() {
		Thread.currentThread().setPriority(Thread.MIN_PRIORITY);
		
		// set the priority of the thread to low
		
		try
		{	
			

		while(true)
		{
			
			// values for working out the constant delay
			// loop continuously
					long thisTick, waitTick;

			// calculate the tick to wait for
			waitTick = System.currentTimeMillis() + delay;

			// update the screen
			x_coord -= speed;

			if (x_coord<s_h) {
					iActif++; // Load next line
					x_coord += -s_h + iPas;
					if (iActif >= iMax) iActif = 0 ;

					sMess = ((rp)dFile.elementAt(iActif)).sM ;
					s_h = -wM.stringWidth(sMess) ;
					}

			repaint ();

			thisTick = System.currentTimeMillis();

			if ( thisTick<waitTick )
			 {
				try {
					Thread.currentThread().sleep( (int)(waitTick-thisTick));
					//Thread.sleep(1000);
				    } 
				catch (InterruptedException e) {}
			 }
			Thread.sleep(10);			
		}
		}

		catch(Exception e)
		{
			//System.out.println("Error in run()>>>>>"+e);
		}
		

	  } // end of run

	  public boolean mouseDown(Event e, int x, int y){
	  if (iCur == -1) return true ;
	  
	  if ( ((rp)dFile.elementAt(iCur)).sU != null) {
		URL clickDest ;
		try{
				if (((rp)dFile.elementAt(iCur)).sT.equals("_script")){	
				   /*JSObject.getWindow (this).eval (((rp)dFile.elementAt(iCur)).sU );*/
				}
				else {
					if ( ((rp)dFile.elementAt(iCur)).sU.charAt(0) == '.')
						clickDest = new URL(getCodeBase(), ((rp)dFile.elementAt(iCur)).sU );
					else
						clickDest = new URL(((rp)dFile.elementAt(iCur)).sU);
					getAppletContext().showDocument(clickDest, ((rp)dFile.elementAt(iCur)).sT );
				}

		}catch(Exception z) {
				showStatus("Bad URL! =" + ((rp)dFile.elementAt(iCur)).sU );
		}										
	  }

	  return(true);

	   }


	  public boolean mouseEnter(Event e, int x, int y){
	    try {
			scrollmessage.suspend() ;
		} catch (Exception e2) {}
//		showStatus(((rd2)dFile.elementAt(iActif)).sU);
		return(true);
	  }

	  public boolean mouseExit(Event e, int x, int y){
	  try {
		scrollmessage.resume() ;
	  } catch (Exception e2) {}
      iCur = -1 ;
	  showStatus("");
	  return(true);
	  }



	// Called when the applet needs to be painted
	// calls the flicker free updating system
	public void paint (Graphics g) {
		update(g);
	} // end of paint


	// Draw the applet without flicker
	public synchronized void update(Graphics g) {
		// get the size of the applet
		int aW = size().width ;
		int aH = size().height ;

		if ((aWidth != aW) || (aHeight != aH) || (offScreen == null)) {
			// initialise the double buffering screen
			try {
				offScreenImage = createImage (aW, aH);
				offScreen = offScreenImage.getGraphics ();
			} catch (Exception e) {
				offScreen = null;
			}
			aWidth  = aW ;
			aHeight = aH ;

			y_coord = aHeight/2 + (wM.getHeight()-wM.getDescent())/2;
			x_coord = aWidth;
		}

		if (offScreen!=null) {
			paintApplet(offScreen);
			g.drawImage(offScreenImage,0,0,this);
		}  else
			paintApplet(g);
	} // end of update


	// Paint the applet into whatever image
	public void paintApplet(Graphics g) {
	try{
		g.clearRect(0,0,aWidth,aHeight);
		g.setColor ( new Color ( cBk ) );

		g.fillRect(0, 0, aWidth, aHeight ) ;

     	int i = iActif ;
		int l = x_coord ;

     	while (true) {
			if (iCur == i) {
				g.setColor ( new Color ( cT2 ) );
				g.setFont( wFont2 ) ;
			}
			else {
				g.setColor ( new Color ( cT1 ) );
				g.setFont( wFont1 ) ;
			}

			g.drawString ( ((rp)dFile.elementAt(i)).sM , l, y_coord ) ;

			l += iPas + wM.stringWidth( ((rp)dFile.elementAt(i)).sM ) ;

			i++ ;
			if (i >= iMax) i = 0 ;

			if (l > aWidth) 
				break ;
      }
	  }
	  catch(Exception e)
	  {
	  	//System.out.println("Error in paintApplet()>>>>>>>>"+e);
	  }

	} // end of paintApplet

 // end aTicker


	class rp extends Object {

	public String	sU	= null ;	// dest URL
	public String   sM  = null ;	// message
	public String   sT  = null ;	// target
	public String   sH  = null ;	// Help
	public int	    l1  ;			// Color std
	public int      l2  ;			// Color active
	public int      lg  = -1 ;

	public boolean get( String st, char cSep, String starg, int d1, int d2 ) {
		int i = 0 ;
		int j = 0 ;
		int k = 0 ;

		String p ;

		if (st == null) return false ;


		sM = null ;
		sU = "" ;
		sT = starg ;
		sH = null ;
		l1 = d1 ; 
		l2 = d2 ;
		lg = -1 ;

		while (true) {
			i = st.indexOf(cSep, j) ;
			if (i > 0)
				p = new String(st.substring(j, i).trim()) ;
			else
				p = new String(st.substring(j).trim()) ;


			if ((i>-1) || (p.length() > 0)) {
				if ( k == 0) sM   = new String(p) ;
				if ( k == 1) sU   = new String(p) ;
				if (p.length() > 0) {
					if (p.charAt(0) =='?')
						sH = p.substring(1) ;
					else {
						if ( k == 2) sT   = new String(p) ;
						if ( k == 3) l1   = Integer.parseInt(p) ;
						if ( k == 4) l2   = Integer.parseInt(p) ;
					}
				}
				k++ ;
			}

			if (i == -1)  break ;
			else j = i + 1 ;
		}

		if (sU.equals("--")) sU = null ;
		return ( k > 0 ) ;
	}

}


//inner

	class ReadNews extends Thread
	{
	String f;
	int delay;
	ReadNews(String f,int delay)
	{
		this.f=f;
		this.delay=delay;
	}
	public void run()
	{
		while(true)
		{
			try
			{
				readFile(f);
				sleep(delay);
				System.out.println("Reading");
			}
			catch(Exception e)
			{
			}
		}
	}
	public void readFile(String f) 
	{
	try
		{
			scrollmessage.suspend();
			dFile.removeAllElements()	;
			iMax = 0;	

			// open stream to a file which name is expressed relative to the document URL
			DataInputStream fis = null ;

			if (bLoc == false)
			try 
			{
				fis = new DataInputStream( (new URL( getCodeBase(), f )).openStream() ) ;
			} 
			catch( Exception e ) 
			{
	 			fis = null ;
				bLoc = true ;
			}
			rp s = null ;

		 	String sS ;
		 	int iL = 0 ;

		 	// parser loop
		 	while ( true ) 
			{
				s = new rp();
 
				if (bLoc) 
				{
					sS = getParameter(f + iL) ;
					iL++ ;
				}
				else
					try 
					{
						sS = fis.readLine() ;
				
					} 
					catch( Exception e ) 
					{
						break ;
					}	

				if (s.get( sS, cSep, "_new", 0xFFFFFF, 0xFFFF00 )) 
				{
					if (s.sM != null ) 
					{
						dFile.addElement( s );
						iMax++ ;
					}
				}
				else 
					break ;
		 	}

		 	iActif = 0 ;
		 	sMess = ((rp)dFile.elementAt(iActif)).sM ;
		 	s_h = - wM.stringWidth(sMess) ;
		 	scrollmessage.resume();

		}
		catch(Exception e)
		{
			//System.out.println("Error>>>>>"+e);
		}

	}

}
}
