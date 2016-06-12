////////////////////////////////////////////////////////////////////////////////
// Unit Description  : about Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Thursday 14, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals';

//constructor of about
function aboutCreate(Owner: TComponent): TForm;
begin
    result := TForm.CreateWithConstructorFromResource(Owner, @about_OnCreate, 'about');
end;

//OnCreate Event of about
procedure about_OnCreate(Sender: TForm);
begin
    //Form Constructor

    //todo: some additional constructing code
    Sender.Caption := Application.Title+' '+appVersion;
    TBGRALabelFX(Sender.Find('BGRALabelFX1')).Caption := Application.Title+' '+appVersion;
    TBUtton(Sender.Find('Button1')).ModalResult := mrCancel;
    Sender.Position := poOwnerFormCenter;

    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    Sender.OnClose := @about_OnClose;
    //</events-bind>
end;

procedure about_OnClose(Sender: TForm; var Action: TCloseAction);
begin
    Action := caFree;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//about initialization constructor
constructor
begin 
end.
