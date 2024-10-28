<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestAdpp.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test adpp client</title>
    <script type="text/javascript" language="javascript" src="http://localhost:49275/adserver/scripts/json2.js"></script>
    <script type="text/javascript" language="javascript" src="http://localhost:49275/adserver/scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" language="javascript" src="http://localhost:49275/adserver/scripts/adplusplus.js"></script>
    <script type="text/javascript" language="javascript">
        var myAd =
        {
            adkeywords: "book,foster,passage to india", addesc: "the best phone in the world"
        };
    </script>

    <script type="text/javascript" language="javascript">
        function LoadTest() {
            document.getElementById('MockPage').innerHTML = document.getElementById('SampleHTML').value;
            adpp_LoadAds();
        }
    </script>
</head>

<body style='padding:0;margin:0;width=100%;height:100%'>
<table width=100%>
<tr><td width=40%><span style='font-weight:bold'>Enter Test Text/Html:</span></td><td align=right width=60%><a href=ManageAds.aspx>Manage Ads</a></td></tr>
<tr><td colspan=2>
<textarea id='SampleHTML' rows=10 cols=10 style='width:100%'>
    <p>UNITED STATES PATENT OFFICE</p>
    <p>Alexander Graham Bell of Boston, Massachusetts</p>
    <p><strong>Improvement in Electric Telegraphy</strong></p>
    <p><em>Specification forming part of Letters Patent No.
    186,787, dated January 30, 1877, application filed January
    15, 1877.</em></p>
    <p>To whom it may concern:</p>
    <p>Be it known that I , Alexander Graham Bell, of Boston,
    Massachusetts, have invented certain new and useful
    Improvements in Electric Telephony, of which the following is
    a specification:</p>
    <p>In Letters Patent granted to me on the 6th day of April,
    1875, No. 161,739, and in an application for Letters Patent
    of the United States now pending, I have described a method
    of and apparatus for producing musical tones by the action of
    a rapidly-interrupted electrical current, whereby a number of
    telegraphic signals can be sent simultaneously along a single
    circuit.</p>
    <p>In another application for Letters Patent now pending in
    the United States Patent Office I have described a method of
    and apparatus for inducing an intermittent current of
    electricity upon a line-wire, whereby musical tones can be
    produced and a number of telegraphic signals be sent
    simultaneously over the same circuit, in either or in both
    directions; and in Letters Patent granted to me March 7,
    1876, No. 174, 465, I have shown and described a method of
    and apparatus for producing musical tones by the action of
    undulatory currents of electricity, whereby a number of
    telegraphic signals can be sent simultaneously over the same
    circuit, in either or in both directions, and a single
    battery be used for the whole circuit.</p>
    <p>In the applications and patents above referred to, signals
    are transmitted simultaneously along a single wire by the
    employment of transmitting-instruments, each of which
    occasions a succession of electrical impulses differing in
    rate from the others, and are received without confusion by
    means of receiving-instruments, each tuned to a pitch at
    which it will be put in vibration to produce its fundamental
    note by one only of the transmitting-instruments. A separate
    instrument is therefore employed for every pitch, each
    instrument being capable of transmitting or receiving but a
    single note, and thus as many separate instruments are
    required as there are messages or musical notes to be
    transmitted.</p>
    <p>My invention has for its object, first, the transmission
    simultaneously of two or more musical notes or telegraphic
    signals along a single wire in either or in both directions,
    and with a single battery for the whole circuit, without the
    use of as many instruments as there are musical notes or
    telegraphic signals to be transmitted; second, the electrical
    transmission by the same means of articulate speech and sound
    of every kind, whether musical or not; third, the electrical
    transmission of musical tones, articulate speech, or sounds
    of every kind, without the necessity of using a voltare
    battery.</p>
    <p>In my Patent No. 174, 465, dated March 7, 1876, I have
    shown as one form of transmitting-instrument a stretched
    membrane, to which the armature of an electro-magnet is
    attached, whereby motion can be imparted to the armature by
    the human voice, or by means of a musical instrument, or by
    sounds produced in any way.</p>
    <p>In accordance with my present invention I substitute for
    the membrane and armature shown in the transmitting and
    receiving instruments alluded to above, a plate of iron or
    steel capable of being thrown into vibration by sounds made
    in its neighborhood.</p>
    <p>The nature of my invention and the manner in which the
    same is or may be carried into effect will be understood by
    reference to the accompanying drawings, in which --</p>
    <p><a href="../Images/BellPat2fig1.gif">Figure 1</a> is a
    perspective view of one form of my electric telephone. <a href="../Images/BellPat2fig1.gif">Figure 2</a> is a vertical
    version of the same, and <a href="../Images/BellPat2Fig3.gif">Figure
    3</a> is a plan view of the apparatus. <a href="../Images/BellPat2Fig4.gif">Figure 4</a> is a diagram
    illustrating the arrangement upon circuit.</p>
    <p>Similar letters in the drawing represent corresponding
    portions of the apparatus.</p>
    <p>A in said drawings represents a plate of iron or steel,
    which is fastened at B and C to the cover or sounding-box D.
    E represents a speaking-tube, by which sounds may be conveyed
    to or from the plate A. F is a bar of soft iron. G is a coil
    of insulated copper wire, placed around the extremity of the
    end H of the bar F. I is an adjusting screw, whereby the
    distance of the end H from the plate A may be regulated.</p>
    <p>The electric telephones, J, K, L, and M are placed at
    different stations upon a line, and are arranged upon circuit
    with a battery, N, as shown in the diagram, Fig. 4.</p>
    <p>I have shown the apparatus in one of its simplest forms,
    it being well understood that the same may be varied in
    arrangement, combination, general construction, and form, as
    well as material of which the several parts are composed.</p>
    <p>The operation and use of this instrument are as follows:</p>
    <p>I would premise by saying that this instrument is and may
    be used in both as a transmitter and as a receiver -- that is
    to say, the sender of the message will use an instrument in
    every particular identical in construction and operation with
    that employed by the receiver, so that the same instrument
    can be used alternately as a receiver and a transmitter.</p>
    <p>In order to transmit a telegraphic message by means of
    these instruments, it is only necessary for the operator at a
    telephone (say J) to make a musical sound in any way in the
    neighborhood of the plate A -- for convenience of operation,
    through the speaking-tube E -- and to let the duration of the
    sound signify the dot or dash of the Morse alphabet, and for
    the operator who receives the message (say at M) to listen to
    his telephone, preferably through the speaking-tube E. When
    two or more musical signals are being transmitted over the
    same circuit all the telephones reproduce the signals for all
    the messages; but as the signals for each message differ in
    pitch from those for other messages, it is easy for an
    operator to fix his attention upon one message and ignore the
    other.</p>
    <p>When a large number of despatches are being simultaneously
    transmitted it will be advisable for the operator to listen
    to his telephone through a resonator, which will re-enforce
    to his ear the signals which he desires to observe. In this
    way he is enabled to direct his attention to the signals for
    any given message without being distracted or disturbed by
    the signals for any other messages that may be passing over
    the line at the time.</p>
    <p>The musical signals, if preferred, can be automatically
    received by means of a resonator, one end of which is closed
    by a membrane, which vibrates only when the note with which
    the resonator is in unison is emitted by the receiving
    telephone. The vibrations of the membrane may be made to
    operate a circuit-breaker, which will actuate a Morse sounder
    or a telegraphic recording or registering apparatus.</p>
    <p>One form of vibratory circuit-breaker which may be used
    for this purpose I have described in Letters Patent No.
    178,399, June 6, 1876. Hence by this plan the simultaneous
    transmission of a number of telegraphic messages over a
    single circuit in the same or in both directions with a
    single main battery for the whole circuit and a single
    telephone at each station is rendered practicable. This is of
    great advantage in this, that for the conveyance of several
    messages, or signals, or sounds over a single wire
    simultaneously, it is no longer necessary to have separate
    instruments correspondingly tuned for each given sound, which
    plan requires nice adjustment of the corresponding
    instruments, while the present improvement admits of a single
    instrument at each station, or, if for convenience several
    are employed, they are all alike in construction, and need
    not be adjusted or tuned to particular pitches.</p>
    <p>Whatever sound is made in the neighborhood of any
    telephone -- say at J, Fig. 4 -- is echoed in fac-simile by
    the telephones of all the other stations upon the circuit;
    hence this plan is also adapted for the use of the
    transmitting intelligibly the exact sounds of articulate
    speech. To convey an articulate message it is only necessary
    for an operator to speak in the neighborhood of his
    telephone, preferably through the tube E, and for another
    operator at a distant station upon the same circuit to listen
    to the telephone at that station. If two persons speak
    simultaneously in the neighborhood of the same or different
    telephones, the utterances of the two speakers are reproduced
    simultaneously by all other telephones on the same circuit;
    hence by this plan and number of vocal messages may be
    transmitted simultaneously on the same circuit, in either or
    both directions. All the effects noted above may be produced
    by the same instruments without a battery by rendering the
    central bar F H permanently magnetic. Another form of
    telephone for use without a battery is shown is <a href="../Images/BellPat2Fig5.gif">Figure 5</a>, in which O is
    a compound permanent magnet, to the poles of which are
    affixed pole-pieces of soft-iron, P Q, surrounded by helices
    of insulated wire R S.</p>
    <p><a href="../Images/BellPat2Fig6.gif">Figure 6</a>
    illustrates that arrangement upon circuit of similar
    instruments to that shown in Fig. 5.</p>
    <p>In lieu of the plate A in above figures, iron or steel
    reeds of definite pitch may be place in front of the
    electro-magnet O, and, in connection with a series of such
    instruments of different pitches, an arrangement upon circuit
    may be employed similar to that shown in my patent No. 174,
    465, and illustrated in Fig. 6 of Sheet 2 in said patent. The
    battery, of course, may be omitted.</p>
    <p>This invention is not limited to the use of iron or steel,
    but includes within its scope any material capable of
    inductive action.</p>
    <p>The essential feature of the invention consists in the
    armature of the receiving-instrument being vibrated by the
    varying attraction of the electro-magnet so as to vibrate the
    air in the vicinity thereof in the same manners a s the air
    is vibrated at the other end by the production of the sound.
    It is, therefore, by no means necessary or essential that the
    transmitting-instrument should be of the same construction as
    the receiving-instrument. Any instrument receiving and
    transmitting the impression of agitated air may be used as a
    transmitter, although, for convenience and for reciprocal
    communication, I prefer to use like instruments at either end
    of an electrical wire. I have heretofore described and
    exhibited such other means of transmitting sound, as will be
    seen by reference to the proceedings of the American Academy
    of Arts and Sciences, Volume XII.</p>
    <p>For convenience, I prefer to apply to each instrument a
    call-bell. This may be arranged so as to ring, first, when
    the main circuit is opened; second, when the bar comes into
    contact with the plate A. The first is done to call
    attention; the second indicates when it is necessary to
    readjust the magnet, for it is important that the distance of
    the magnet from the plate should be as little as possible,
    without, however, being in contact. I have also found that
    the electrical undulations produced upon the main line by the
    vibration of the plate A are intensified by placing the coil
    G at the end of the bar F nearest the plate A, and not extend
    it beyond the middle, or thereabout.</p>
    <p>Having thus described my invention, what I claim and
    desire to secure by Letters Patent, is --</p>phone
    <ol>
</textarea>
</td></tr>
</table>
<input type=button value='Load Html And Highlight Text' onclick='LoadTest();' class=test_drive_menu/>
<br /><br />
<div id='MockPage'>TestPage</div>
</body>
</html>
