unit USEnvironment;

interface

uses
  ExtCtrls,
  USCellType;

type
  TSEnvironment = class(TObject)
  public
    function GetImageByCellType(ACellType: TSCellType): TImage;
  end;


var
  Environment: TSEnvironment;


implementation

uses
  USVDM;

{ TSEnvironment }

function TSEnvironment.GetImageByCellType(ACellType: TSCellType): TImage;
begin
  if ACellType = ctBomb then
    Result := SVDM.imgBombSafe
  else if ACellType = ctBombRed then
    Result := SVDM.imgBombRed
  else if ACellType = ctFlag then
    Result := SVDM.imgFlag
  else
    Result := nil;
end;


initialization
  Environment := TSEnvironment.Create;

finalization
  Environment.Free;

end.
