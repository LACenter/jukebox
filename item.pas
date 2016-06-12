////////////////////////////////////////////////////////////////////////////////
// Unit Description  : item Description
// Unit Author       : LA.Center Corporation
// Date Created      : February, Monday 22, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals';

var
    vPlayList, vGenre: string;

//constructor of item
function itemCreate(Owner: TComponent; playList, genre: string): TFrame;
begin
    vPlayList := playList;
    vGenre := genre;
    result := TFrame.CreateWithConstructorFromResource(Owner, @item_OnCreate, 'item');
end;

//OnCreate Event of item
procedure item_OnCreate(Sender: TFrame);
begin
    //Frame Constructor

    //todo: some additional constructing code
    _setButton(TBGRAButton(Sender.Find('bPrev')), false, false);
    _setButton(TBGRAButton(Sender.Find('bCancel')), false, false);
    _setButton(TBGRAButton(Sender.Find('bMainPlay')), false, false);
    _setButton(TBGRAButton(Sender.Find('bNext')), false, false);
    _setButton(TBGRAButton(Sender.Find('bPause')), false, false);
    _setButton(TBGRAButton(Sender.Find('bTracks')), false, false);

    TLabel(Sender.Find('lTitle')).Font.Style := fsBold;
    TLabel(Sender.Find('lTitle')).Font.Color := HexToColor('#ff5500');
    //TLabel(Sender.Find('lTitle')).Font.Size := 12;
    //if OSX then
    //    TLabel(Sender.Find('lTitle')).Font.Size := 14;

    TVars(Sender.Find('Vars1')).SetVar('index', 2);
    TVars(Sender.Find('Vars1')).setVar('playlist', vPlayList);
    if vPlayList <> '' then
        TMemo(Sender.Find('Memo1')).Lines.LoadFromResource(vPlayList);

    TLabel(Sender.Find('lArtist')).Font.Style := fsBold;
    TLabel(Sender.Find('lArtist')).Font.Color := clWhite;
    TLabel(Sender.Find('lAlbum')).Font.Color := clWhite;
    TLabel(Sender.Find('lArtist')).Caption := TMemo(Sender.Find('Memo1')).Lines.Names[0];
    TLabel(Sender.Find('lAlbum')).Caption := TMemo(Sender.Find('Memo1')).Lines.ValueByIndex(0);
    TShape(Sender.Find('Shape1')).Pen.Color := HexToColor('#ff5500');

    TBGRAPanel(Sender.Find('panLabel')).Gradient.StartColor := HexToColor('#ff5500');
    TBGRAPanel(Sender.Find('panLabel')).Gradient.EndColor := HexToColor('#dd3300');

    TCircleProgress(Sender.Find('CircleProgress2')).Left :=
        TCircleProgress(Sender.Find('CircleProgress2')).Left + 3;
    TCircleProgress(Sender.Find('CircleProgress2')).Top :=
        TCircleProgress(Sender.Find('CircleProgress2')).Top + 2;
    TCircleProgress(Sender.Find('CircleProgress3')).Left :=
        TCircleProgress(Sender.Find('CircleProgress3')).Left + 6;
    TCircleProgress(Sender.Find('CircleProgress3')).Top :=
        TCircleProgress(Sender.Find('CircleProgress3')).Top + 4;

    TPanel(Sender.Find('topPanel')).Left := 1;
    TPanel(Sender.Find('topPanel')).Top := 1;
    TPanel(Sender.Find('topPanel')).Width := 258;
    TPanel(Sender.Find('topPanel')).Height := 258;

    TBGRAButton(Sender.Find('bMainPlay')).Left := 4;
    TBGRAButton(Sender.Find('bMainPlay')).Width := 250;
    TBGRAButton(Sender.Find('bMainPlay')).Top :=
        TBGRAButton(Sender.Find('bMainPlay')).Top -1;

    loadGenreImage(Sender);

    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    TBGRAButton(Sender.find('bTracks')).OnClick := @item_bTracks_OnClick;
    TTimer(Sender.find('Timer1')).OnTimer := @item_Timer1_OnTimer;
    TBGRAButton(Sender.find('bPrev')).OnClick := @item_bPrev_OnClick;
    TBGRAButton(Sender.find('bNext')).OnClick := @item_bNext_OnClick;
    TBGRAButton(Sender.find('bPause')).OnClick := @item_bPause_OnClick;
    TSimpleAction(Sender.find('actStop')).OnExecute := @item_actStop_OnExecute;
    TBGRAButton(Sender.find('bCancel')).OnClick := @item_bCancel_OnClick;
    TBGRAButton(Sender.find('bMainPlay')).OnClick := @item_bMainPlay_OnClick;
    TTimer(Sender.find('aniTimer')).OnTimer := @item_aniTimer_OnTimer;
    //</events-bind>
end;

procedure loadGenreImage(Sender: TFrame);
begin
    ResToFile(vGenre, TempDir+'tmp.jpg');
    TImage(Sender.Find('genreImg')).Picture.LoadFromFile(TempDir+'tmp.jpg');
    deleteFile(TempDir+'tmp.jpg');
end;

procedure item_aniTimer_OnTimer(Sender: TTimer);
var
    a1, a2, a3, i: int;
begin
    Sender.Enabled := false;

    a1 := Random(8);
    a2 := Random(8);
    a3 := Random(8);

    TCircleProgress(Sender.Owner.Find('CircleProgress1')).Position := 66;
    TCircleProgress(Sender.Owner.Find('CircleProgress2')).Position := 77;
    TCircleProgress(Sender.Owner.Find('CircleProgress3')).Position := 88;

    for i := 0 to a1 do
    begin
        TCircleProgress(Sender.Owner.Find('CircleProgress1')).StartAngle :=
            TCircleProgress(Sender.Owner.Find('CircleProgress1')).StartAngle +3;
        TCircleProgress(Sender.Owner.Find('CircleProgress1')).Update;
        if TCircleProgress(Sender.Owner.Find('CircleProgress1')).StartAngle >= 355 then
            TCircleProgress(Sender.Owner.Find('CircleProgress1')).StartAngle := 0;
    end;

    for i := 0 to a2 do
    begin
        TCircleProgress(Sender.Owner.Find('CircleProgress2')).StartAngle :=
            TCircleProgress(Sender.Owner.Find('CircleProgress2')).StartAngle -3;
        TCircleProgress(Sender.Owner.Find('CircleProgress2')).Update;
        if TCircleProgress(Sender.Owner.Find('CircleProgress2')).StartAngle <= 0 then
            TCircleProgress(Sender.Owner.Find('CircleProgress2')).StartAngle := 355;
    end;

    for i := 0 to a3 do
    begin
        TCircleProgress(Sender.Owner.Find('CircleProgress3')).StartAngle :=
            TCircleProgress(Sender.Owner.Find('CircleProgress3')).StartAngle +3;
        TCircleProgress(Sender.Owner.Find('CircleProgress3')).Update;
        if TCircleProgress(Sender.Owner.Find('CircleProgress3')).StartAngle >= 355 then
            TCircleProgress(Sender.Owner.Find('CircleProgress3')).StartAngle := 0;
    end;

    Sender.Enabled := isPlaying;
end;

procedure item_bMainPlay_OnClick(Sender: TBGRAButton);
var
    i: int;
    str: TStringList;
    url: string;
    playList: TStrings;
begin
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    _stopAll;

    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;

    if TLabel(Sender.Owner.Find('lArtist')).Caption = 'Radio' then
    begin
        //radio
        str := TStringList.Create;
        str.LoadFromFile(home+'my.radios');
        url := str.Strings[Sender.Owner.Tag];
        url := copy(url, Pos('=', url)+1, 1000);
        loadSoundFile(PLAYER, url);
        playSound(PLAYER);
        TControl(Sender.Owner.Find('bNext')).Enabled := false;
        //TControl(Sender.Owner.Find('bPause')).Enabled := false;
        TControl(Sender.Owner.Find('bPrev')).Enabled := false;
        TControl(Sender.Owner.Find('lTitle')).Caption :=
            TLabel(Sender.Owner.Find('lAlbum')).Caption;
        isPlaying := true;
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;

        TLabel(Application.MainForm.Find('lStatus')).Caption := 'Playing -> '+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption;

        Application.MainForm.Caption := Application.Title + ' '+appVersion+ ' ['+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption
        +']';
        str.free;
    end
        else
    begin
        if Pages.TabIndex = 0 then
        url := 'https://liveapps.center/data/jukebox/'+playList.Strings[1]+'/'+playlist.ValueByIndex(2)
        else
        url := playList.Strings[2];

        TVars(Sender.Owner.Find('Vars1')).setVar('index', 2);

        loadSoundFile(PLAYER, url);
        playSound(PLAYER);

        if Pages.TabIndex = 0 then
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := playlist.Names[2]
        else
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := 'Track 1';

        isPlaying := true;
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;

        TLabel(Application.MainForm.Find('lStatus')).Caption := 'Playing -> '+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption;

        Application.MainForm.Caption := Application.Title + ' '+appVersion+ ' ['+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption
        +']';
    end;

    while TPanel(Sender.Owner.Find('topPanel')).Top + TPanel(Sender.Owner.Find('topPanel')).Height > -2 do
    begin
        TPanel(Sender.Owner.Find('topPanel')).Top :=
            TPanel(Sender.Owner.Find('topPanel')).Top -8;
        TPanel(Sender.Owner.Find('topPanel')).Update;
    end;

    Screen.Cursor := crDefault;
    Application.ProcessMessages;
end;

procedure item_bCancel_OnClick(Sender: TComponent);
begin
    stopSound(PLAYER);
    isPlaying := false;
    TTimer(Sender.Owner.Find('aniTimer')).Enabled := false;

    TLabel(Application.MainForm.Find('lStatus')).Caption :=  '';
    Application.MainForm.Caption := Application.Title + ' '+appVersion;

    while TPanel(Sender.Owner.Find('topPanel')).Top < 1 do
    begin
        TPanel(Sender.Owner.Find('topPanel')).Top :=
            TPanel(Sender.Owner.Find('topPanel')).Top +5;
        TPanel(Sender.Owner.Find('topPanel')).Update;
    end;
    TPanel(Sender.Owner.Find('topPanel')).Top := 1;
end;

procedure item_actStop_OnExecute(Sender: TSimpleAction);
begin
    item_bCancel_OnClick(Sender);
end;

procedure item_bPause_OnClick(Sender: TBGRAButton);
var
    png: TPortableNetworkGraphic;
begin
    png := TPortableNetworkGraphic.Create;
    if Sender.Hint = '' then
    begin
        pauseSound(PLAYER);
        Sender.Hint := '*';
        png.LoadFromResource('bplay');
        Sender.Glyph.Assign(png);
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := false;
    end
        else
    begin
        playSound(PLAYER);
        Sender.Hint := '';
        png.LoadFromResource('bpause');
        Sender.Glyph.Assign(png);
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;
    end;
    png.free;
end;

procedure item_bNext_OnClick(Sender: TComponent);
var
    playList: TStrings;
    idx: int;
    url: string;
    png: TPortableNetworkGraphic;
begin
    png := TPortableNetworkGraphic.Create;
    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;
    idx := TVars(Sender.Owner.Find('Vars1')).asInt('index');

    if idx < (playList.Count -1) then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        TTimer(Sender.Owner.Find('aniTimer')).Enabled := false;
        stopSound(PLAYER);
        sleep(250);

        if Pages.TabIndex = 0 then
        url := 'https://liveapps.center/data/jukebox/'+playList.Strings[1]+'/'+playlist.ValueByIndex(idx +1)
        else
        url := playList.Strings[idx + 1];

        createSoundPlayer(PLAYER);

        loadSoundFile(PLAYER, url);
        playSound(PLAYER);

        TVars(Sender.Owner.Find('Vars1')).setVar('index', idx + 1);

        if Pages.TabIndex = 0 then
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := playlist.Names[idx +1]
        else
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := 'Track '+IntToStr(idx);

        isPlaying := true;
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;

        png.LoadFromResource('bpause');
        TBGRAButton(Sender.Owner.Find('bPause')).Glyph.Assign(png);

        Screen.Cursor := crDefault;
        Application.ProcessMessages;

        TLabel(Application.MainForm.Find('lStatus')).Caption := 'Playing -> '+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption;

        Application.MainForm.Caption := Application.Title + ' '+appVersion+ ' ['+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption
        +']';
    end;

    png.free;
end;

procedure item_bPrev_OnClick(Sender: TComponent);
var
    playList: TStrings;
    idx: int;
    url: string;
    png: TPortableNetworkGraphic;
begin
    png := TPortableNetworkGraphic.Create;
    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;
    idx := TVars(Sender.Owner.Find('Vars1')).asInt('index');

    if idx > 2 then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        TTimer(Sender.Owner.Find('aniTimer')).Enabled := false;
        stopSound(PLAYER);
        sleep(250);

        if Pages.TabIndex = 0 then
        url := 'https://liveapps.center/data/jukebox/'+playList.Strings[1]+'/'+playlist.ValueByIndex(idx -1)
        else
        url := playList.Strings[idx - 1];

        createSoundPlayer(PLAYER);

        loadSoundFile(PLAYER, url);
        playSound(PLAYER);

        TVars(Sender.Owner.Find('Vars1')).setVar('index', idx - 1);

        if Pages.TabIndex = 0 then
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := playlist.Names[idx -1]
        else
        TUrlLink(Sender.Owner.Find('lTitle')).Caption := 'Track '+IntToStr(idx -2);

        isPlaying := true;
        TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;

        png.LoadFromResource('bpause');
        TBGRAButton(Sender.Owner.Find('bPause')).Glyph.Assign(png);

        Screen.Cursor := crDefault;
        Application.ProcessMessages;

        TLabel(Application.MainForm.Find('lStatus')).Caption := 'Playing -> '+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption;

        Application.MainForm.Caption := Application.Title + ' '+appVersion+ ' ['+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption
        +']';
    end;
    png.Free;
end;

procedure item_Timer1_OnTimer(Sender: TTimer);
var
    playList: TStrings;
    idx: int;
begin
    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;
    idx := TVars(Sender.Owner.Find('Vars1')).asInt('index');

    if isPlaying and
       (TLabel(Sender.Owner.Find('lArtist')).Caption <> 'Radio') and
       (TPanel(Sender.Owner.Find('topPanel')).Top < 1) then
    begin
        TControl(Sender.Owner.Find('bPrev')).Enabled := (idx > 2);
        TControl(Sender.Owner.Find('bNext')).Enabled := (idx < playList.Count -1);
        if TControl(Sender.Owner.Find('bNext')).Enabled then
        begin
            //if stopped start next
            if getSoundPlayerStatus(PLAYER) = 0 then
                item_bNext_OnClick(Sender);
        end;
    end
        else
    begin
        TControl(Sender.Owner.Find('bPrev')).Enabled := false;
        TControl(Sender.Owner.Find('bNext')).Enabled := false;
    end;
end;

procedure item_bTracks_OnClick(Sender: TBGRAButton);
var
    pop: TPopupMenu;
    x, y: int;
    menu: TMenuItem;
    i: int;
    playList: TStrings;
begin
    pop := TPopupMenu(Sender.Owner.Find('pop'));
    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;

    pop.Items.Clear;

    for i := 2 to playList.Count -1 do
    begin
        if trim(playList.Strings[i]) <> '' then
        begin
            menu := TMenuItem.Create(Sender.Owner);
            if Pages.TabIndex = 0 then
            menu.Caption := playList.Names[i]
            else
            menu.Caption := 'Track '+IntToStr(i -1)+' - '+FileNameOf(playList.Strings[i]);
            menu.setTag(i);
            menu.OnClick := @onTrackMenuClick;
            pop.Items.Add(menu);
        end;
    end;


    x := Sender.ClientToScreenX(0, 0);
    y := Sender.ClientToScreenY(0, 0) + Sender.Height;

    pop.PopUpAt(x, y);
end;

procedure onTrackMenuClick(Sender: TMenuItem);
var
    playList: TStrings;
    url: string;
    png: TPortableNetworkGraphic;
begin
    png := TPortableNetworkGraphic.Create;
    playList := TMemo(Sender.Owner.Find('Memo1')).Lines;

    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    TTimer(Sender.Owner.Find('aniTimer')).Enabled := false;
    stopSound(PLAYER);
    sleep(250);

    if Pages.TabIndex = 0 then
    url := 'https://liveapps.center/data/jukebox/'+playList.Strings[1]+'/'+playlist.ValueByIndex(Sender.Tag)
    else
    url := playList.Strings[Sender.Tag];

    createSoundPlayer(PLAYER);

    loadSoundFile(PLAYER, url);
    playSound(PLAYER);

    TVars(Sender.Owner.Find('Vars1')).setVar('index', Sender.Tag);

    if Pages.TabIndex = 0 then
    TUrlLink(Sender.Owner.Find('lTitle')).Caption := playlist.Names[Sender.Tag]
    else
    TUrlLink(Sender.Owner.Find('lTitle')).Caption := 'Track '+IntToStr(Sender.Tag -1);

    isPlaying := true;
    TTimer(Sender.Owner.Find('aniTimer')).Enabled := true;

    png.LoadFromResource('bpause');
    TBGRAButton(Sender.Owner.Find('bPause')).Glyph.Assign(png);

    Screen.Cursor := crDefault;
    Application.ProcessMessages;

    TLabel(Application.MainForm.Find('lStatus')).Caption := 'Playing -> '+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption;

    Application.MainForm.Caption := Application.Title + ' '+appVersion+ ' ['+
        TLabel(Sender.Owner.Find('lArtist')).Caption+' / '+
        TLabel(Sender.Owner.Find('lAlbum')).Caption+' / '+
        TUrlLink(Sender.Owner.Find('lTitle')).Caption
        +']';

    png.Free;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//item initialization constructor
constructor
begin 
end.
