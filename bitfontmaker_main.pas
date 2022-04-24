unit bitFontMaker_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,
  ExtCtrls, Spin, ExtDlgs, BCImageButton, BGRASpeedButton;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ButtonOpenImg: TButton;
    ButtonExTxt: TButton;
    ButtonExImg: TButton;
    EditFontName: TEdit;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    SpinEditFontSize: TSpinEdit;
    SpinEditHeight: TSpinEdit;
    SpinEditWidth: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure ButtonExTxtClick(Sender: TObject);
    procedure ButtonExImgClick(Sender: TObject);
    procedure ButtonOpenImgClick(Sender: TObject);
    procedure FontDialog1Close(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure SpinEditFontSizeChange(Sender: TObject);
  private
    procedure OnBitmapPress(Sender:TObject);
  public
    procedure DrawFontList(iWidth, iHeight, iFontSize: Integer);

    // for debug
    function DecodeBuffer(const sbuf: string; cx: Integer):string;
    function EncodeBitmap:string;

  end;

var
  Form1: TForm1;

implementation

uses
  Types;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  FontDialog1.Execute;
end;

procedure TForm1.ButtonExTxtClick(Sender: TObject);
var
  sbuf: string;
  fs: TFileStream;
begin
  if SaveDialog1.Execute then begin
    sbuf:=EncodeBitmap;
    fs:=TFileStream.Create(SaveDialog1.FileName,fmCreate or fmOpenReadWrite);
    try
      fs.Write(sbuf[1],Length(sbuf));
    finally
      fs.Free;
    end;
  end;
end;

procedure TForm1.ButtonExImgClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TForm1.ButtonOpenImgClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    SpinEditWidth.OnChange:=nil;
    SpinEditHeight.OnChange:=nil;
    try
      SpinEditWidth.Value:=Image1.Picture.Bitmap.Width div 16;
      SpinEditHeight.Value:=Image1.Picture.Bitmap.Height div 6;
    finally
      SpinEditWidth.OnChange:=@SpinEditChange;
      SpinEditHeight.OnChange:=@SpinEditChange;
    end;
  end;
end;

procedure TForm1.FontDialog1Close(Sender: TObject);
begin
  EditFontName.Text:=FontDialog1.Font.Name;
  SpinEditFontSize.Value:=FontDialog1.Font.Size;
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value, SpinEditFontSize.Value);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  EditFontName.Text:=FontDialog1.Font.Name;
  SpinEditFontSize.Value:=FontDialog1.Font.Size;
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value, SpinEditFontSize.Value);
end;

procedure TForm1.SpinEditChange(Sender: TObject);
begin
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value, SpinEditFontSize.Value);
end;

procedure TForm1.SpinEditFontSizeChange(Sender: TObject);
begin
  FontDialog1.Font.Size:=SpinEditFontSize.Value;
  SpinEditChange(nil);
end;

procedure TForm1.OnBitmapPress(Sender: TObject);
begin

end;

procedure TForm1.DrawFontList(iWidth, iHeight, iFontSize: Integer);
var
  s: string;
  i, fx, fy: Integer;
  bm: TBitmap;
  fs: TSize;
begin
  bm:=TBitmap.Create;
  try
    bm.PixelFormat:=pf1bit;
    Image1.Picture.Bitmap.SetSize(iWidth*16,iHeight*6);

    for i:=0 to 95 do begin
      // make font bitmap
      bm.Canvas.Font.Assign(FontDialog1.Font);
      fs:=bm.Canvas.TextExtent(char(32+i));
      bm.SetSize(fs.cx, fs.cy);
      bm.Canvas.Font.Color:=clWhite;
      bm.Canvas.Brush.Color:=clBlack;
      bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
      bm.Canvas.TextOut(0,0,char(32+i));
      // copy font bitmap
      fx:=iWidth*(i mod 16);
      fy:=iHeight*(i div 16);
      Image1.Picture.Bitmap.Canvas.CopyRect(Rect(fx,fy,fx+iWidth,fy+iHeight),bm.Canvas,Rect(0,0,bm.Width,bm.Height));
    end;
  finally
    bm.Free;
  end;
end;

function TForm1.DecodeBuffer(const sbuf: string; cx: Integer): string;
var
  st: TStringList;
  i, j, k, l, x: Integer;
  s, sb, sl: string;
begin
  Result:='';
  st:=TStringList.Create;
  try
    st.Delimiter:=',';
    st.DelimitedText:=sbuf;
    l:=0;
    sb:='';
    sl:='';
    i:=0;
    while i<cx do begin
      x:=0;
      while x+cx<st.Count do begin
        s:=StringReplace(st.Strings[i+x],'0x','$',[]);
        j:=StrToInt(s);
        sb:='';
        for k:=0 to 7 do
          if j and (1 shl k)=0 then
            sb:='0'+sb
            else
              sb:='1'+sb;
        sl:=sb+sl;
        inc(x,cx);
      end;
      Result:=Result+sl+LineEnding;
      sl:='';
      Inc(i);
    end;
  finally
    st.Free;
  end;
end;

function TForm1.EncodeBitmap: string;
var
  bm: TBitmap;
  sbuf: string;
  val: Integer;
  i, dy, iy, ix, by, bx, fy, fx: Integer;
begin
  Result:='';

  bx:=SpinEditWidth.Value;
  by:=SpinEditHeight.Value;
  bm:=TBitmap.Create;
  try
    bm.SetSize(bx, by);
    bm.PixelFormat:=pf1bit;
    Result:=Format('// %s, size: %d', [EditFontName.Text,FontDialog1.Font.Size])+LineEnding;
    Result:=Result+Format('// Width=%d, Height=%d', [bx, by])+LineEnding;
    for i:=0 to 95 do begin
      fx:=bx*(i mod 16);
      fy:=by*(i div 16);
      bm.Canvas.CopyRect(Rect(0, 0, bx, by), Image1.Picture.Bitmap.Canvas, Rect(
        fx, fy, fx+bx, fy+by));

      sbuf:='';
      ix:=0;
      dy:=0;
      while dy<by do begin
        while ix<bx do begin
          val:=0;
          for iy:=0 to 7 do begin
            if dy+iy<by then
              if bm.Canvas.Pixels[ix, dy+iy]<>0 then
                val:=val or (1 shl iy);
          end;
          sbuf:=sbuf+'0x'+IntToHex(val, 2)+',';
          inc(ix);
        end;
        Result:=Result+sbuf+LineEnding;
        sbuf:='';
        inc(dy, 8);
        ix:=0;
      end;
      Result:=Result+'//'+IntToStr(i+32)+' '+char(i+32)+LineEnding;
    end;
  finally
    bm.Free;
  end;
end;

end.

