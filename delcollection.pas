////////////////////////////////////////////////////////////////////////////////
// Unit Description  : delcollection Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Friday 15, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals';

var
    isRadio: bool;

//constructor of delcollection
function delcollectionCreate(Owner: TComponent; radio: bool): TForm;
begin
    isRadio := radio;
    result := TForm.CreateWithConstructorFromResource(Owner, @delcollection_OnCreate, 'delcollection');
end;

//OnCreate Event of delcollection
procedure delcollection_OnCreate(Sender: TForm);
var
    str: TStringList;
    i: int;
    name: string;
begin
    //Form Constructor

    //todo: some additional constructing code
    Sender.Position := poOwnerFormCenter;
    TButton(Sender.Find('Button1')).ModalResult := mrCancel;
    TButton(Sender.Find('Button2')).ModalResult := mrOK;

    str := TStringList.Create;

    if isRadio then
    begin
        Sender.Caption := 'Remove Radio Station';
        if FileExists(home+'my.radios') then
            str.LoadFromFile(home+'my.radios');
    end
        else
    begin
        if FileExists(home+'my.collection') then
            str.LoadFromFile(home+'my.collection');
    end;

    for i := 0 to str.Count -1 do
    begin
        name := copy(str.Strings[i], 0, Pos('=', str.Strings[i]) -1);
        name := copy(name, Pos('-', name) +1, 1000);
        TComboBox(Sender.Find('Combobox1')).Items.Add(name);
    end;
    str.free;

    if TComboBox(Sender.Find('Combobox1')).Items.Count <> 0 then
        TComboBox(Sender.Find('Combobox1')).ItemIndex := 0;

    TButton(Sender.Find('Button2')).Enabled :=
        (TComboBox(Sender.Find('Combobox1')).Items.Count <> 0);

    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    Sender.OnClose := @delcollection_OnClose;
    Sender.OnCloseQuery := @delcollection_OnCloseQuery;
    //</events-bind>
end;

procedure delcollection_OnClose(Sender: TForm; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure delcollection_OnCloseQuery(Sender: TForm; var CanClose: bool);
var
    str: TStringList;
begin
    if Sender.ModalResult = mrOK then
    begin
        _stopAll;

        str := TStringList.Create;
        if isRadio then
        begin
            if FileExists(home+'my.radios') then
                str.LoadFromFile(home+'my.radios');
            str.Delete(TComboBox(Sender.Find('ComboBox1')).ItemIndex);
            str.SaveToFile(home+'my.radios');
        end
            else
        begin
            if FileExists(home+'my.collection') then
                str.LoadFromFile(home+'my.collection');
            str.Delete(TComboBox(Sender.Find('ComboBox1')).ItemIndex);
            str.SaveToFile(home+'my.collection');
        end;
        str.Free;
    end;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//delcollection initialization constructor
constructor
begin 
end.
