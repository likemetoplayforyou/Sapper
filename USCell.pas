unit USCell;

interface

uses
  Buttons, ExtCtrls, StdCtrls, Classes,
  UCellMatrix, USCellType;

type
  TSCell = class;

  TCellNotifyEvent = procedure(ACell: TSCell) of object;

  TSCell = class(TCell)
  private
    FIsBomb: boolean;
    FNearBombsCount: integer;
    FOpened: boolean;
    FOnClick: TCellNotifyEvent;

    FPanel: TPanel;
    FButton: TBitBtn;
    FImage: TImage;
    FLabel: TLabel;

    procedure ButtonClick(Sender: TObject);
  public
    constructor Create(AMatrix: TCellMatrix; ARow, ACol: integer); override;

    procedure Open(AGameOver: boolean = false);
    procedure Reset;

    property IsBomb: boolean read FIsBomb write FIsBomb;
    property NearBombsCount: integer read FNearBombsCount write FNearBombsCount;
    property Opened: boolean read FOpened;
    property OnClick: TCellNotifyEvent read FOnClick write FOnClick;
  end;


implementation

uses
  Controls, SysUtils, Graphics,
  USEnvironment;

{ TSCell }

procedure TSCell.ButtonClick(Sender: TObject);
begin
  Open;

  if Assigned(FOnClick) then
    FOnClick(Self);
end;


constructor TSCell.Create(AMatrix: TCellMatrix; ARow, ACol: integer);
const
  FONT_NAME = 'Arial Black';
  FONT_SIZE = 11;
begin
  inherited;
  FPanel := TPanel.Create(AMatrix.Container);
  FPanel.BevelOuter := bvNone;
  FPanel.Parent := AMatrix.Container;
  FPanel.Width := AMatrix.CellWidth;
  FPanel.Height := AMatrix.CellWidth;
  FPanel.Left := ACol * AMatrix.CellWidth;
  FPanel.Top := ARow * AMatrix.CellWidth;

  FButton := TBitBtn.Create(AMatrix.Container);
  FButton.Parent := FPanel;
  FButton.Align := alClient;
  FButton.OnClick := ButtonClick;
  FButton.Visible := true;

  FImage := TImage.Create(AMatrix.Container);
  FImage.Parent := FPanel;
  FImage.Align := alClient;
  FImage.Center := true;
  FImage.Visible := false;

  FLabel := TLabel.Create(AMatrix.Container);
  FLabel.Parent := FPanel;
  FLabel.Align := alClient;
  FLabel.Alignment := taCenter;
  FLabel.Font.Name := FONT_NAME;
  FLabel.Font.Size := FONT_SIZE;
  FLabel.Visible := false;
end;


procedure TSCell.Open(AGameOver: boolean);
const
  NEAR_BOMB_COLORS: array [1..8] of integer = (
    $FF0000, $008000, $0000FF, $650006, $000080, $837522, $FF00FF, 0
  );
  BOMB_CELL_TYPE: array [boolean] of TSCellType = (ctBombRed, ctBomb);
begin
  if FOpened then
    Exit;

  FButton.Visible := false;

  if IsBomb then begin
    FImage.Picture.Bitmap.Assign(
      Environment.GetImageByCellType(BOMB_CELL_TYPE[AGameOver]).Picture.Bitmap
    );
    FImage.Visible := true;
  end
  else if (1 <= NearBombsCount) and (NearBombsCount <= 8) then begin
    FLabel.Font.Color := NEAR_BOMB_COLORS[NearBombsCount];
    FLabel.Caption := IntToStr(NearBombsCount);
    FLabel.Visible := true;
  end;

  FOpened := true;
end;


procedure TSCell.Reset;
begin
  FIsBomb := false;
  FOpened := false;
  FNearBombsCount := 0;

  FImage.Visible := false;
  FLabel.Visible := false;
  FButton.Visible := true;
end;


end.
