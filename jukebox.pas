////////////////////////////////////////////////////////////////////////////////
// Unit Description  : jukebox Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Tuesday 12, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////


uses 'mainform';

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

procedure AppException(Sender: TObject; E: Exception);
begin
    //Uncaught Exceptions
    MsgError('Error', E.Message);
end;

//jukebox initialization constructor
constructor
begin
    Application.Initialize;
    Application.Icon.LoadFromResource('appicon');
    Application.Title := 'LA.Jukebox';
    mainformCreate(nil);
    Application.Run;
end.

//Project Resources
//$res:appicon=[project-home]resources/app.ico
//$res:mainform=[project-home]mainform.pas.frm
//$res:item=[project-home]item.pas.frm
//$res:bstop=[project-home]resources/stop.png
//$res:bplay=[project-home]resources/play.png
//$res:bnext=[project-home]resources/next.png
//$res:bprev=[project-home]resources/prev.png
//$res:bpause=[project-home]resources/pause.png
//$res:genrealternative=[project-home]resources/alternative.jpg
//$res:genrejazz=[project-home]resources/jazz.jpg
//$res:genreblues=[project-home]resources/blues.jpg
//$res:genrecountry=[project-home]resources/country.jpg
//$res:genredance=[project-home]resources/dance.jpg
//$res:genredisco=[project-home]resources/disco.jpg
//$res:genreelectro=[project-home]resources/electro.jpg
//$res:genrefolk=[project-home]resources/folk.jpg
//$res:genrehouse=[project-home]resources/house.jpg
//$res:genrerelax=[project-home]resources/relax.jpg
//$res:genrernb=[project-home]resources/rnb.jpg
//$res:genrerock=[project-home]resources/rock.jpg
//$res:genresoundtrack=[project-home]resources/soundtrack.jpg
//$res:genretechno=[project-home]resources/techno.jpg
//$res:genredupstep=[project-home]resources/dupstep.jpg
//$res:genrereggae=[project-home]resources/reggae.jpg
//$res:list001=[project-home]resources/001.txt
//$res:list002=[project-home]resources/002.txt
//$res:list003=[project-home]resources/003.txt
//$res:list004=[project-home]resources/004.txt
//$res:list005=[project-home]resources/005.txt
//$res:list006=[project-home]resources/006.txt
//$res:radio=[project-home]resources/radio.txt
//$res:libdl=[project-home]libdl.pas.frm
//$res:about=[project-home]about.pas.frm
//$res:libadd=[project-home]libadd.pas.frm
//$res:genre=[project-home]genre.pas.frm
//$res:delcollection=[project-home]delcollection.pas.frm
//$res:radioadd=[project-home]radioadd.pas.frm
