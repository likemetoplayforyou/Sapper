unit USVDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage;

type
  TSVDM = class(TForm)
    imgBombSafe: TImage;
    imgBombRed: TImage;
    imgFlag: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SVDM: TSVDM;

implementation

{$R *.dfm}

end.
