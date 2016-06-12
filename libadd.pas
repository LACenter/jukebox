////////////////////////////////////////////////////////////////////////////////
// Unit Description  : libadd Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Thursday 14, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'genre', 'globals';

//constructor of libadd
function libaddCreate(Owner: TComponent): TForm;
begin
    result := TForm.CreateWithConstructorFromResource(Owner, @libadd_OnCreate, 'libadd');
end;

//OnCreate Event of libadd
procedure libadd_OnCreate(Sender: TForm);
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
    TSimpleAction(Sender.find('actValidate')).OnExecute := @libadd_actValidate_OnExecute;
    TDirectoryEdit(Sender.find('DirectoryEdit1')).OnChange := @libadd_DirectoryEdit1_OnChange;
    TEdit(Sender.find('Edit1')).OnChange := @libadd_Edit1_OnChange;
    Sender.OnCloseQuery := @libadd_OnCloseQuery;
    Sender.OnClose := @libadd_OnClose;
    //</events-bind>
end;

procedure libadd_OnClose(Sender: TForm; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure libadd_OnCloseQuery(Sender: TForm; var CanClose: bool);
var
    lib: string;
begin
    if Sender.ModalResult = mrOK then
    begin
        lib := _getGenre+'-'+
               TEdit(Sender.Find('Edit1')).Text+'='+
               TDirectoryEdit(Sender.Find('DirectoryEdit1')).Text;
        Collection.Add(lib);
        Collection.SaveToFile(home+'my.collection');
    end;
end;

procedure libadd_Edit1_OnChange(Sender: TEdit);
begin
    TSimpleAction(Sender.Owner.Find('actValidate')).Execute;
end;

procedure libadd_DirectoryEdit1_OnChange(Sender: TDirectoryEdit);
begin
    TSimpleAction(Sender.Owner.Find('actValidate')).Execute;
end;

procedure libadd_actValidate_OnExecute(Sender: TSimpleAction);
begin
    if (Trim(TEdit(Sender.Owner.Find('Edit1')).Text) <> '') and
       (Trim(TDirectoryEdit(Sender.Owner.Find('DirectoryEdit1')).Text) <> '') and
       _hasCheckedGenre then
    TButton(Sender.Owner.Find('bOK')).Enabled := true
    else
    TButton(Sender.Owner.Find('bOK')).Enabled := false;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//libadd initialization constructor
constructor
begin 
end.
