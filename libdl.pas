////////////////////////////////////////////////////////////////////////////////
// Unit Description  : libdl Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Thursday 14, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals';

//constructor of libdl
function libdlCreate(Owner: TComponent): TForm;
begin
    result := TForm.CreateWithConstructorFromResource(Owner, @libdl_OnCreate, 'libdl');
end;

//OnCreate Event of libdl
procedure libdl_OnCreate(Sender: TForm);
begin
    //Form Constructor

    //todo: some additional constructing code
    Sender.Position := poOwnerFormCenter;
    TProgressBar(Sender.Find('ProgressBar1')).Color := clNone;

    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    TTimer(Sender.find('Timer1')).OnTimer := @libdl_Timer1_OnTimer;
    Sender.OnShow := @libdl_OnShow;
    //</events-bind>
end;

procedure onHttpReceive(Sender: TObject; bytesin, bytesTotal: int64);
begin
    Application.ProcessMessages;
end;

procedure libdl_Timer1_OnTimer(Sender: TTimer);
var
    fs: TFileStream;
    http: THttp;
    zip: TUnzip;
begin
    Sender.Enabled := false;

    DeleteFile(TempDir+'tmp.zip');
    fs := TFileStream.Create(TempDir+'tmp.zip', fmCreate);
    http := THttp.Create;
    http.onBytesReceived := @onHttpReceive;
    http.urlGetBinary(dlurl, fs);
    http.free;
    fs.free;

    if FileExists(TempDir+'tmp.zip') then
    begin
        zip := TUnzip.Create;
        zip.OutputPath := FilePathOf(lib1);
        zip.FileName := TempDir+'tmp.zip';
        zip.unzip;
        zip.free;
    end;
    DeleteFile(TempDir+'tmp.zip');

    TForm(Sender.Owner).Close;
end;

procedure libdl_OnShow(Sender: TForm);
begin
    TTimer(Sender.Find('Timer1')).Enabled := true;
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//libdl initialization constructor
constructor
begin 
end.
