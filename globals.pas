////////////////////////////////////////////////////////////////////////////////
// Unit Description  : globals Description
// Unit Author       : LA.Center Corporation
// Date Created      : February, Monday 22, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'genre';

const
    appVersion = '1.03';

var
    home: string;
    Pages: TATTabs = nil;
    MainForm: TForm;
    isPlaying: bool = false;
    isPaused: bool = false;
    PLAYER: int = 0;
    scrollStore: TScrollBox;
    scrollLocal: TScrollBox;
    scrollRadio: TScrollBox;
    scrollGenre: TScrollBox;
    dlurl, lib1, lib2, lib3: string;
    Collection: TStringList;

procedure _setButton(bu: TBGRAButton; arrowLeft, arrowRight: bool);
begin
    bu.TextShadowOffSetX := 0;
    bu.TextShadowOffSetY := 1;
    bu.TextShadowRadius := 0;
    // Normal
    bu.BodyNormal.BorderColor := HexToColor('#dd3333');
    bu.BodyNormal.Font.Color := clWhite;
    if Windows then
    bu.BodyNormal.Font.Size := 10
    else if OSX then
    bu.BodyNormal.Font.Size := 12
    else
    bu.BodyNormal.Font.Size := 8;
    bu.BodyNormal.Gradient1.StartColor := HexToColor('#ee3300');
    bu.BodyNormal.Gradient1.EndColor := HexToColor('#ee4400');
    bu.BodyNormal.Gradient2.StartColor := HexToColor('#ee4400');
    bu.BodyNormal.Gradient2.EndColor := HexToColor('#ee3300');
    // Hover
    bu.BodyHover.BorderColor := HexToColor('#ff7700');
    bu.BodyHover.Font.Color := clWhite;
    if Windows then
    bu.BodyHover.Font.Size := 10
    else if OSX then
    bu.BodyHover.Font.Size := 12
    else
    bu.BodyHover.Font.Size := 8;
    bu.BodyHover.Gradient1.StartColor := HexToColor('#ff8800');
    bu.BodyHover.Gradient1.EndColor := HexToColor('#ff5500');
    bu.BodyHover.Gradient2.StartColor := HexToColor('#ff5500');
    bu.BodyHover.Gradient2.EndColor := HexToColor('#ff8800');
    // Clicked
    bu.BodyClicked.BorderColor := HexToColor('#ff4400');
    bu.BodyClicked.Font.Color := clWhite;
    if Windows then
    bu.BodyClicked.Font.Size := 10
    else if OSX then
    bu.BodyClicked.Font.Size := 12
    else
    bu.BodyClicked.Font.Size := 8;
    bu.BodyClicked.Gradient1.StartColor := HexToColor('#ff6600');
    bu.BodyClicked.Gradient1.EndColor := HexToColor('#ff4400');
    bu.BodyClicked.Gradient2.StartColor := HexToColor('#ff4400');
    bu.BodyClicked.Gradient2.EndColor := HexToColor('#ff6600');

    if arrowLeft then
    begin
        bu.BorderStyle.TopLeft := bsBevel;
        bu.BorderStyle.BottomLeft := bsBevel;
        bu.BorderStyle.TopRight := bsSquare;
        bu.BorderStyle.BottomRight := bsSquare;
        bu.RoundX := 20;
        bu.RoundY := 20;
    end
    else if arrowRight then
    begin
        bu.BorderStyle.TopLeft := bsSquare;
        bu.BorderStyle.BottomLeft := bsSquare;
        bu.BorderStyle.TopRight := bsBevel;
        bu.BorderStyle.BottomRight := bsBevel;
        bu.RoundX := 20;
        bu.RoundY := 20;
    end
    else
    begin
        bu.BorderStyle.TopLeft := bsSquare;
        bu.BorderStyle.BottomLeft := bsSquare;
        bu.BorderStyle.TopRight := bsSquare;
        bu.BorderStyle.BottomRight := bsSquare;
        bu.RoundX := 0;
        bu.RoundY := 0;
    end;
end;

procedure _stopAll();
var
    i: int;
    f: TFrame;
begin
    stopSound(PLAYER);
    sleep(250);

    for i := 0 to scrollStore.ComponentCount -1 do
        TSimpleAction(scrollStore.Components[i].Find('actStop')).Execute;

    for i := 0 to scrollLocal.ComponentCount -1 do
        TSimpleAction(scrollLocal.Components[i].Find('actStop')).Execute;

    for i := 0 to scrollRadio.ComponentCount -1 do
        TSimpleAction(scrollRadio.Components[i].Find('actStop')).Execute;

    createSoundPlayer(PLAYER);
end;

procedure OnGenreClick(Sender: TToggleBox);
var
    i: int;
begin
    for i := 0 to scrollGenre.ComponentCount -1 do
        TToggleBox(scrollGenre.Components[i].Find('ToggleBox1')).Checked := false;

    Sender.Checked := true;

    //Sender.Owner is Frame
    //Sender.Owner.Parent is Scrollbox
    //Sender.Owner.Parent.Parent is Form

    TSimpleAction(TControl(Sender.Owner).Parent.Parent.Find('actValidate')).Execute;
end;

function _getGenre(): string;
var
    i: int;
begin
    result := '';
    for i := 0 to scrollGenre.ComponentCount -1 do
    begin
        if TToggleBox(scrollGenre.Components[i].Find('ToggleBox1')).Checked then
        begin
            result := TToggleBox(scrollGenre.Components[i].Find('ToggleBox1')).Caption;
            break;
        end;
    end;

    if result = 'R&&B' then
        result := 'RnB';

    result := 'genre'+result;
end;

function _hasCheckedGenre(): bool;
var
    i: int;
begin
    result := false;
    for i := 0 to scrollGenre.ComponentCount -1 do
    begin
        if TToggleBox(scrollGenre.Components[i].Find('ToggleBox1')).Checked then
        begin
            result := true;
            break;
        end;
    end;
end;

procedure _populateGenres(con: TScrollBox);
var
    i: int;
    f: TFrame;
    str: TStringList;
begin
    str := TStringList.Create;
    str.Add('genreAlternative');
    str.Add('genreJazz');
    str.Add('genreBlues');
    str.Add('genreCountry');
    str.Add('genreDance');
    str.Add('genreDisco');
    str.Add('genreElectro');
    str.Add('genreFolk');
    str.Add('genreHouse');
    str.Add('genreRelax');
    str.Add('genreRnB');
    str.Add('genreRock');
    str.Add('genreSoundtrack');
    str.Add('genreTechno');
    str.Add('genreDupstep');
    str.Add('genreReggae');

    str.Sort;

    for i := 0 to str.Count -1 do
    begin
        f := genreCreate(con);
        f.Parent := con;
        f.Constraints.MinHeight := 175;
        f.Constraints.MaxHeight := 175;
        f.Constraints.MinWidth := 150;
        f.Constraints.MaxWidth := 150;
        DeleteFile(TempDir+'tmp.jpg');
        ResToFile(str.Strings[i], TempDir+'tmp.jpg');
        TImage(f.Find('Image1')).Picture.LoadFromFile(TempDir+'tmp.jpg');
        DeleteFile(TempDir+'tmp.jpg');
        TToggleBox(f.Find('ToggleBox1')).Caption := ReplaceOnce(str.Strings[i], 'genre', '');
        if TToggleBox(f.Find('ToggleBox1')).Caption = 'RnB' then
        TToggleBox(f.Find('ToggleBox1')).Caption := 'R&&B';
    end;

    str.free;
end;

//globals initialization constructor
constructor
begin
    //adjust ModalDimmed Rect
    if IsWindowsXP then
    begin
        AdjustDimOffsetLeft(-9);
        AdjustDimOffsetWidth(9);
    end;
    if IsWindowsVista or IsWindows7 then
    begin
        AdjustDimOffsetLeft(-8);
        AdjustDimOffsetWidth(16);
        AdjustDimOffsetHeight(8);
    end;
    if Linux then
    begin
        AdjustDimOffsetLeft(-1);
        AdjustDimOffsetTop(-1);
        AdjustDimOffsetWidth(4);
        AdjustDimOffsetHeight(2);
    end;

    home := UserDir+'LA.Jukebox'+DirSep;

    Collection := TStringList.Create;
    if FileExists(home+'my.collection') then
        Collection.LoadFromFile(home+'my.collection');

    if Windows then
    begin
        if cpu32 then
        begin
            dlurl := 'https://liveapps.center/download/sound-windows32.zip';
            lib1 := home+'LibPortaudio-32.dll';
            lib2 := home+'LibSndFile-32.dll';
            if IsWindowsXP then
            lib3 := home+'LibMpg123-32XP.dll'
            else
            lib3 := home+'LibMpg123-32.dll';
        end
            else
        begin
            dlurl := 'https://liveapps.center/download/sound-windows64.zip';
            lib1 := home+'LibPortaudio-64.dll';
            lib2 := home+'LibSndFile-64.dll';
            lib3 := home+'LibMpg123-64.dll';
        end;
    end;

    if Linux then
    begin
        if cpu32 then
        begin
            dlurl := 'https://liveapps.center/download/sound-linux32.zip';
            lib1 := home+'LibPortaudio-32.so';
            lib2 := home+'LibSndFile-32.so';
            lib3 := home+'LibMpg123-32.so';
        end
            else
        begin
            dlurl := 'https://liveapps.center/download/sound-linux64.zip';
            lib1 := home+'LibPortaudio-64.so';
            lib2 := home+'LibSndFile-64.so';
            lib3 := home+'LibMpg123-64.so';
        end;
    end;

    if FreeBSD then
    begin
        if cpu32 then
        begin
            dlurl := 'https://liveapps.center/download/sound-bsd32.zip';
            lib1 := home+'libportaudio-32.so';
            lib2 := home+'libsndfile-32.so';
            lib3 := home+'libmpg123-32.so';
        end
            else
        begin
            dlurl := 'https://liveapps.center/download/sound-bsd64.zip';
            lib1 := home+'libportaudio-64.so';
            lib2 := home+'libsndfile-64.so';
            lib3 := home+'libmpg123-64.so';
        end;
    end;

    if OSX then
    begin
        dlurl := 'https://liveapps.center/download/sound-macosx.zip';
        lib1 := home+'LibPortaudio-32.dylib';
        lib2 := home+'LibSndFile-32.dylib';
        lib3 := home+'LibMpg123-32.dylib';
    end;
end.
