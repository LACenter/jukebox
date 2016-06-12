////////////////////////////////////////////////////////////////////////////////
// Unit Description  : radioadd Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Thursday 14, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'genre', 'globals';

//constructor of radioadd
function radioaddCreate(Owner: TComponent): TForm;
begin
    result := TForm.CreateWithConstructorFromResource(Owner, @radioadd_OnCreate, 'radioadd');
end;

//OnCreate Event of radioadd
procedure radioadd_OnCreate(Sender: TForm);
begin
    //Form Constructor

    //todo: some additional constructing code
    Sender.Position := poOwnerFormCenter;
    TButton(Sender.Find('bCancel')).ModalResult := mrCancel;
    TButton(Sender.Find('bOK')).ModalResult := mrOK;

    scrollGenre := TScrollBox(Sender.Find('ScrollBox1'));
    scrollGenre.ChildSizing.LeftRightSpacing := 5;
    scrollGenre.ChildSizing.TopBottomSpacing := 5;
    scrollGenre.ChildSizing.HorizontalSpacing := 5;
    scrollGenre.ChildSizing.VerticalSpacing := 5;
    scrollGenre.ChildSizing.Layout := cclLeftToRightThenTopToBottom;
    scrollGenre.ChildSizing.ControlsPerLine := 4;
    scrollGenre.HorzScrollBar.Tracking := true;
    scrollGenre.HorzScrollBar.Smooth := true;
    scrollGenre.HorzScrollBar.Visible := false;
    scrollGenre.VertScrollBar.Tracking := true;
    scrollGenre.VertScrollBar.Smooth := true;
    scrollGenre.VertScrollBar.Visible := true;

    _populateGenres(scrollGenre);

    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    TSimpleAction(Sender.find('actValidate')).OnExecute := @radioadd_actValidate_OnExecute;
    TEdit(Sender.find('Edit2')).OnChange := @radioadd_Edit2_OnChange;
    TEdit(Sender.find('Edit1')).OnChange := @radioadd_Edit1_OnChange;
    Sender.OnCloseQuery := @radioadd_OnCloseQuery;
    Sender.OnClose := @radioadd_OnClose;
    //</events-bind>
end;

procedure radioadd_OnClose(Sender: TForm; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure radioadd_OnCloseQuery(Sender: TForm; var CanClose: bool);
var
    lib: string;
    str: TStringList;
begin
    if Sender.ModalResult = mrOK then
    begin
        str := TStringList.Create;
        if FileExists(home+'my.radios') then
            str.LoadFromFile(home+'my.radios');

        lib := _getGenre+'-'+
               TEdit(Sender.Find('Edit1')).Text+'='+
               TEdit(Sender.Find('Edit2')).Text;
        str.Add(lib);
        str.SaveToFile(home+'my.radios');
        str.free;
    end;
end;

procedure radioadd_Edit1_OnChange(Sender: TEdit);
begin
    TSimpleAction(Sender.Owner.Find('actValidate')).Execute;
end;

procedure radioadd_Edit2_OnChange(Sender: TEdit);
begin
    TSimpleAction(Sender.Owner.Find('actValidate')).Execute;
end;

procedure radioadd_actValidate_OnExecute(Sender: TSimpleAction);
begin
    if (Trim(TEdit(Sender.Owner.Find('Edit1')).Text) <> '') and
       (Trim(TEdit(Sender.Owner.Find('Edit2')).Text) <> '') and
       _hasCheckedGenre then
    TButton(Sender.Owner.Find('bOK')).Enabled := true
    else
    TButton(Sender.Owner.Find('bOK')).Enabled := false;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//radioadd initialization constructor
constructor
begin 
end.
