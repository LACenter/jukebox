////////////////////////////////////////////////////////////////////////////////
// Unit Description  : mainform Description
// Unit Author       : LA.Center Corporation
// Date Created      : February, Monday 22, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals', 'item', 'libdl', 'about', 'libadd', 'delcollection', 'radioadd';

//constructor of mainform
function mainformCreate(Owner: TComponent): TForm;
begin
    result := TForm.CreateWithConstructorFromResource(Owner, @mainform_OnCreate, 'mainform');
end;

//OnCreate Event of mainform
procedure mainform_OnCreate(Sender: TForm);
begin
    //Form Constructor

    //todo: some additional constructing code
    Sender.Caption := Application.Title+' '+appVersion;
    MainForm := Sender;
    Pages := TATTabs(Sender.Find('Pages'));
    Pages.ColorBG := clWhite;
    Pages.ColorTabActive := HexToColor('#ff5500');
    Pages.ColorTabPassive := HexToColor('#ee3300');
    Pages.ColorTabOver := HexToColor('#ff5500');
    Pages.ColorBorderActive := HexToColor('#ee3300');
    Pages.ColorBorderPassive := HexToColor('#ee3300');
    Pages.Font.Color := clWhite;
    Pages.Font.Style := fsBold;
    Pages.Font.Size := 10;
    if OSX then
    Pages.Font.Size := 12;

    scrollStore := TScrollBox(Sender.Find('scrollStore'));
    scrollLocal := TScrollBox(Sender.Find('scrollLocal'));
    scrollRadio := TScrollBox(Sender.Find('scrollRadio'));

    scrollStore.BorderSpacing.Top := 5;
    scrollLocal.BorderSpacing.Top := 5;
    scrollRadio.BorderSpacing.Top := 5;

    scrollStore.ChildSizing.LeftRightSpacing := 8;
    scrollStore.ChildSizing.TopBottomSpacing := 0;
    scrollStore.ChildSizing.HorizontalSpacing := 8;
    scrollStore.ChildSizing.VerticalSpacing := 5;
    scrollStore.ChildSizing.Layout := cclLeftToRightThenTopToBottom;
    scrollStore.ChildSizing.ControlsPerLine := 3;
    scrollStore.HorzScrollBar.Tracking := true;
    scrollStore.HorzScrollBar.Smooth := true;
    scrollStore.HorzScrollBar.Visible := false;
    scrollStore.VertScrollBar.Tracking := true;
    scrollStore.VertScrollBar.Smooth := true;
    scrollStore.VertScrollBar.Visible := true;

    scrollLocal.ChildSizing.LeftRightSpacing := 8;
    scrollLocal.ChildSizing.TopBottomSpacing := 0;
    scrollLocal.ChildSizing.HorizontalSpacing := 8;
    scrollLocal.ChildSizing.VerticalSpacing := 5;
    scrollLocal.ChildSizing.Layout := cclLeftToRightThenTopToBottom;
    scrollLocal.ChildSizing.ControlsPerLine := 3;
    scrollLocal.HorzScrollBar.Tracking := true;
    scrollLocal.HorzScrollBar.Smooth := true;
    scrollLocal.HorzScrollBar.Visible := false;
    scrollLocal.VertScrollBar.Tracking := true;
    scrollLocal.VertScrollBar.Smooth := true;

    scrollRadio.ChildSizing.LeftRightSpacing := 8;
    scrollRadio.ChildSizing.TopBottomSpacing := 0;
    scrollRadio.ChildSizing.HorizontalSpacing := 8;
    scrollRadio.ChildSizing.VerticalSpacing := 5;
    scrollRadio.ChildSizing.Layout := cclLeftToRightThenTopToBottom;
    scrollRadio.ChildSizing.ControlsPerLine := 3;
    scrollRadio.HorzScrollBar.Tracking := true;
    scrollRadio.HorzScrollBar.Smooth := true;
    scrollRadio.HorzScrollBar.Visible := false;
    scrollRadio.VertScrollBar.Tracking := true;
    scrollRadio.VertScrollBar.Smooth := true;

    Pages.AddTab(0, 'LA.Store Albums', scrollStore, -1);
    Pages.AddTab(1, 'My Music Collection', scrollLocal, -1);
    Pages.AddTab(2, 'Radio Stations', scrollRadio, -1);

    TBGRAButton(Sender.Find('bMenu')).Top := 31;
    TBGRAButton(Sender.Find('bMenu')).Height := 25;
    TBGRAButton(Sender.Find('bMenu')).Left := Sender.Width - 30;
    _setButton(TBGRAButton(Sender.Find('bMenu')), false, false);

    TLabel(Sender.Find('lStatus')).Font.Color := clWhite;
    TLabel(Sender.Find('lStatus')).Font.Style := fsBold;


    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    TMenuItem(Sender.find('mRemove2')).OnClick := @mainform_mRemove2_OnClick;
    TMenuItem(Sender.find('mAdd2')).OnClick := @mainform_mAdd2_OnClick;
    TMenuItem(Sender.find('mRemove')).OnClick := @mainform_mRemove_OnClick;
    TMenuItem(Sender.find('mRefresh')).OnClick := @mainform_mRefresh_OnClick;
    TMenuItem(Sender.find('mAdd')).OnClick := @mainform_mAdd_OnClick;
    TMenuItem(Sender.find('mAbout')).OnClick := @mainform_mAbout_OnClick;
    TMenuItem(Sender.find('mExit')).OnClick := @mainform_mExit_OnClick;
    TBGRAButton(Sender.find('bMenu')).OnClick := @mainform_bMenu_OnClick;
    TTimer(Sender.find('startTimer')).OnTimer := @mainform_startTimer_OnTimer;
    TATTabs(Sender.find('Pages')).OnTabClick := @mainform_Pages_OnTabClick;
    Sender.OnResize := @mainform_OnResize;
    Sender.OnShow := @mainform_OnShow;
    //</events-bind>


    //Set as Application.MainForm
    Sender.setAsMainForm;
end;

//todo: later we need to get this list online from _la:_music:_store class
//right now we have only 6 licenses so manually will be ok for now
procedure doPopulateLicensedStore();
var
    f: TFrame;
    i: int;
begin
    for i := scrollStore.ComponentCount -1 downto 0 do
        try scrollStore.Components[i].free; except end;

    //BB King
    f := itemCreate(scrollStore, 'list001', 'genreBlues');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;

    //Chris Stapleton
    f := itemCreate(scrollStore, 'list002', 'genreCountry');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;

    //Elmo
    f := itemCreate(scrollStore, 'list003', 'genreRnB');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;
    scrollStore.Invalidate;

    //Elvis
    f := itemCreate(scrollStore, 'list004', 'genreRock');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;
    scrollStore.Invalidate;

    //Eric Clapton
    f := itemCreate(scrollStore, 'list005', 'genreBlues');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;
    scrollStore.Invalidate;

    //Tedeski
    f := itemCreate(scrollStore, 'list006', 'genreBlues');
    f.Parent := scrollStore;
    f.Constraints.MinWidth := 260;
    f.Constraints.MaxWidth := 260;
    f.Constraints.MinHeight := 275;
    f.Constraints.MaxHeight := 275;
end;

//todo: later we need to get this list online from _la:_music:_radio class
//licensed radios but more can be added from shoutcast
// 1 - download .pls (WinAmp format)
// 2 - read url from File1=
procedure doPopulateLicensedRadio();
var
    f: TFrame;
    str: TStringList;
    i: int;
    gen: string;
    title: string;
begin
    if not FileExists(home+'my.radios') then
        ResToFile('radio', home+'my.radios');

    for i := scrollRadio.ComponentCount -1 downto 0 do
        try scrollRadio.Components[i].free; except end;

    str := TStringList.Create;
    str.LoadFromFile(home+'my.radios');

    for i := 0 to str.Count -1 do
    begin
        gen := copy(str.Strings[i], 0, Pos('-', str.Strings[i]) -1);
        title := copy(str.Strings[i], Pos('-', str.Strings[i]) +1, 1000);
        title := copy(title, 0, Pos('=', title) -1);

        f := itemCreate(scrollRadio, '', gen);
        f.Parent := scrollRadio;
        f.setTag(i); //index id for radio
        TLabel(f.Find('lArtist')).Caption := 'Radio';
        TLabel(f.Find('lAlbum')).Caption := title;
        TControl(f.Find('bTracks')).Visible := false;
        f.Constraints.MinWidth := 260;
        f.Constraints.MaxWidth := 260;
        f.Constraints.MinHeight := 275;
        f.Constraints.MaxHeight := 275;
    end;

    str.Free;
end;

procedure doPopulateLocal();
var
    i, j: int;
    str: TStringList;
    files: TStringList;
    gen: string;
    title: string;
    f: TFrame;
begin
    str := TStringList.Create;
    if FileExists(home+'my.collection') then
        str.LoadFromFile(home+'my.collection');

    for i := scrollLocal.ComponentCount -1 downto 0 do
        try scrollLocal.Components[i].free; except end;

    for i := 0 to str.Count -1 do
    begin
        gen := copy(str.Strings[i], 0, Pos('-', str.Strings[i]) -1);
        title := copy(str.Strings[i], Pos('-', str.Strings[i]) +1, 1000);
        title := copy(title, 0, Pos('=', title) -1);

        f := itemCreate(scrollLocal, '', gen);
        f.Parent := scrollLocal;
        f.setTag(i); //index id for radio
        TLabel(f.Find('lArtist')).Caption := 'Collection';
        TLabel(f.Find('lAlbum')).Caption := title;
        f.Constraints.MinWidth := 260;
        f.Constraints.MaxWidth := 260;
        f.Constraints.MinHeight := 275;
        f.Constraints.MaxHeight := 275;

        TMemo(f.Find('Memo1')).Lines.Clear;
        files := TStringList.Create;
        SearchDir(str.ValueByIndex(i), '*', files);
        TMemo(f.Find('Memo1')).Lines.Add('***');
        TMemo(f.Find('Memo1')).Lines.Add('***');
        files.Sort;
        for j := 0 to files.Count -1 do
        begin
            if Pos('.mp3', Lower(files.Strings[j])) > 0 then
                TMemo(f.Find('Memo1')).Lines.Add(files.Strings[j]);
        end;
        if TMemo(f.Find('Memo1')).Lines.Count = 2 then
            TControl(f.Find('bPlay')).Enabled := false;
        files.free;
    end;

    str.free;
end;

procedure mainform_OnResize(Sender: TForm);
begin
    scrollStore.ChildSizing.ControlsPerLine := ((Sender.Width - 20) div 265);
    scrollLocal.ChildSizing.ControlsPerLine := ((Sender.Width - 20) div 265);
    scrollRadio.ChildSizing.ControlsPerLine := ((Sender.Width - 20) div 265);

    TBGRAButton(Sender.Find('bMenu')).Top := 31;
    TBGRAButton(Sender.Find('bMenu')).Height := 25;
    TBGRAButton(Sender.Find('bMenu')).Left := Sender.Width - 28;
end;

procedure mainform_Pages_OnTabClick(Sender: TATTabs);
var
    data: TATTabData;
begin
    scrollStore.Visible := false;
    scrollLocal.Visible := false;
    scrollRadio.Visible := false;

    data := Pages.GetTabData(Pages.TabIndex);
    TControl(data.TabObject).Visible := true;
    TControl(data.TabObject).BringToFront;
end;

procedure mainform_startTimer_OnTimer(Sender: TTimer);
var
    f: TForm;
begin
    Sender.Enabled := false;

    if not FileExists(lib1) then
    begin
        f := libdlCreate(Sender.Owner);
        f.ShowModalDimmed;
    end;

    if FileExists(lib1) then
    begin
        if loadSoundLib(lib1, lib2, lib3, '', '') then
        begin
            Screen.Cursor := crHourGlass;
            Application.ProcessMessages;

            //populate
            doPopulateLicensedStore;
            doPopulateLicensedRadio;
            doPopulateLocal;

            TLabel(Sender.Owner.Find('lStatus')).Caption := '';

            Screen.Cursor := crDefault;
            Application.ProcessMessages;
        end;
    end
        else
        TLabel(Sender.Owner.Find('lStatus')).Caption := 'ERROR: Library initialization failed!';
end;

procedure mainform_OnShow(Sender: TForm);
begin
    TTimer(Sender.Find('startTimer')).Enabled := true;
end;

procedure mainform_bMenu_OnClick(Sender: TBGRAButton);
var
    pop: TPopupMenu;
    x, y: int;
begin
    pop := TPopupMenu(Sender.Owner.Find('pop'));

    x := Sender.ClientToScreenX(0, 0);
    y := Sender.ClientToScreenY(0, 0) + Sender.Height;

    pop.PopUpAt(x, y);
end;

procedure mainform_mExit_OnClick(Sender: TMenuItem);
begin
    TForm(Sender.Owner).Close;
end;

procedure mainform_mAbout_OnClick(Sender: TMenuItem);
begin
    aboutCreate(Sender.Owner).ShowModalDimmed;
end;

procedure mainform_mAdd_OnClick(Sender: TMenuItem);
begin
    if libaddCreate(Sender.Owner).ShowModalDimmed = mrOK then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        Pages.TabIndex := 1;
        doPopulateLocal;

        Screen.Cursor := crDefault;
        Application.ProcessMessages;
    end;
end;

procedure mainform_mRefresh_OnClick(Sender: TMenuItem);
begin
    TLabel(Sender.Owner.Find('lStatus')).Caption := 'Refreshing library, please wait...';
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    doPopulateLicensedStore;
    doPopulateLicensedRadio;
    doPopulateLocal;

    TLabel(Sender.Owner.Find('lStatus')).Caption := '';
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
end;

procedure mainform_mRemove_OnClick(Sender: TMenuItem);
begin
    if delcollectionCreate(Sender.Owner, false).ShowModalDimmed = mrOK then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        doPopulateLocal;

        Screen.Cursor := crDefault;
        Application.ProcessMessages
    end;
end;

procedure mainform_mAdd2_OnClick(Sender: TMenuItem);
begin
    if radioaddCreate(Sender.Owner).ShowModalDimmed = mrOK then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        Pages.TabIndex := 2;
        doPopulateLicensedRadio;

        Screen.Cursor := crDefault;
        Application.ProcessMessages;
    end;
end;

procedure mainform_mRemove2_OnClick(Sender: TMenuItem);
begin
    if delcollectionCreate(Sender.Owner, true).ShowModalDimmed = mrOK then
    begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        doPopulateLicensedRadio;

        Screen.Cursor := crDefault;
        Application.ProcessMessages;
    end;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//mainform initialization constructor
constructor
begin 
end.
