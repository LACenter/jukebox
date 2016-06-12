////////////////////////////////////////////////////////////////////////////////
// Unit Description  : genre Description
// Unit Author       : LA.Center Corporation
// Date Created      : April, Thursday 14, 2016
// -----------------------------------------------------------------------------
//
// History
//
//
////////////////////////////////////////////////////////////////////////////////

uses 'globals';

//constructor of genre
function genreCreate(Owner: TComponent): TFrame;
begin
    result := TFrame.CreateWithConstructorFromResource(Owner, @genre_OnCreate, 'genre');
end;

//OnCreate Event of genre
procedure genre_OnCreate(Sender: TFrame);
begin
    //Frame Constructor

    //todo: some additional constructing code
    TToggleBox(Sender.Find('ToggleBox1')).OnClick := @OnGenreClick;


    //note: DESIGNER TAG => DO NOT REMOVE!
    //<events-bind>
    //</events-bind>
end;

//<events-code> - note: DESIGNER TAG => DO NOT REMOVE!

//genre initialization constructor
constructor
begin 
end.
