
unit EditAlbum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ExtCtrls, ImgList, BaseForm, MediaFile,
  EditAlbumController;

type
  TfrmEditAlbum = class(TBaseForm)
    BevelBottom: TBevel;
    BevelTop: TBevel;
    PanelBottom: TPanel;
    btSave: TButton;
    btCancel: TButton;
    MainPanel: TPanel;
    lbName: TLabel;
    lbYear: TLabel;
    edName: TEdit;
    PanelTop: TPanel;
    edYear: TEdit;
    procedure btCancelClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FController: TEditAlbumController;
  public
    procedure SetAlbum(AlbumId: Variant);
  end;

implementation

{$R *.dfm}

procedure TfrmEditAlbum.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmEditAlbum.btSaveClick(Sender: TObject);
var
  Album: TAlbum;
begin
  Album := FController.Album;

  Album.AlbumName := edName.Text;
  if edYear.Text <> '' then
    Album.ReleaseYear := StrToInt(edYear.Text);

  FController.SaveAlbum(Album);

  ModalResult := mrOk;
end;

procedure TfrmEditAlbum.FormCreate(Sender: TObject);
begin
  FController := TEditAlbumController.Create;
end;

procedure TfrmEditAlbum.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TfrmEditAlbum.SetAlbum(AlbumId: Variant);
var
  Album: TAlbum;
begin
  FController.Load(AlbumId);
  Album := FController.Album;

  edName.Text := Album.AlbumName;

  if Album.ReleaseYear.HasValue then
    edYear.Text := IntToStr(Album.ReleaseYear);
end;

end.
