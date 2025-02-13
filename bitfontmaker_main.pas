unit bitFontMaker_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, ExtDlgs, UExceptionLogger;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ButtonExBin: TButton;
    ButtonOpenImg: TButton;
    ButtonExTxt: TButton;
    ButtonExImg: TButton;
    CheckBoxFitCenterY: TCheckBox;
    CheckBoxSkipCtlChar: TCheckBox;
    CheckBoxScale: TCheckBox;
    ComboBoxAA: TComboBox;
    EditFontName: TEdit;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    SpinEditGapX: TSpinEdit;
    SpinEditFontSize: TSpinEdit;
    SpinEditGrayLevel: TSpinEdit;
    SpinEditGapY: TSpinEdit;
    SpinEditHeight: TSpinEdit;
    SpinEditWidth: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure ButtonExBinClick(Sender: TObject);
    procedure ButtonExTxtClick(Sender: TObject);
    procedure ButtonExImgClick(Sender: TObject);
    procedure ButtonOpenImgClick(Sender: TObject);
    procedure FontDialog1Close(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure SpinEditFontSizeChange(Sender: TObject);
  private
    procedure OnBitmapPress(Sender:TObject);
  public
    procedure DrawFontList(iWidth, iHeight: Integer);

    // for debug
    function DecodeBuffer(const sbuf: string; cx: Integer):string;
    function EncodeBitmap:string;
    function EncodeBitmapBin:TMemoryStream;

  end;

var
  Form1: TForm1;

implementation

uses
  Types, BGRABitmap, BGRABitmapTypes;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  FontDialog1.Execute;
end;

procedure TForm1.ButtonExBinClick(Sender: TObject);
var
  binbuf: TMemoryStream;
begin
  SaveDialog1.FileName:=Format('%s_%d_%d_%d_%d.bin',[EditFontName.Text,SpinEditWidth.Value,
                                   SpinEditHeight.Value,SpinEditFontSize.Value,SpinEditGrayLevel.Value]);
  if SaveDialog1.Execute then begin
    binbuf:=EncodeBitmapBin;
    if Assigned(binbuf) then begin
        binbuf.SaveToFile(SaveDialog1.FileName);
    end;
  end;
end;

procedure TForm1.ButtonExTxtClick(Sender: TObject);
var
  sbuf: string;
  fs: TFileStream;
begin
  SaveDialog1.FileName:=Format('%s_%d_%d_%d_%d.txt',[EditFontName.Text,SpinEditWidth.Value,
                                   SpinEditHeight.Value,SpinEditFontSize.Value,SpinEditGrayLevel.Value]);

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
  SavePictureDialog1.FileName:=Format('%s_%d_%d_%d_%d.png',[EditFontName.Text,SpinEditWidth.Value,
                                   SpinEditHeight.Value,SpinEditFontSize.Value,SpinEditGrayLevel.Value]);
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
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  exceptionLogger.LogFileName:='bugreport.txt';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  EditFontName.Text:=FontDialog1.Font.Name;
  SpinEditFontSize.Value:=FontDialog1.Font.Size;
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value);
end;

procedure TForm1.SpinEditChange(Sender: TObject);
begin
  DrawFontList(SpinEditWidth.Value, SpinEditHeight.Value);
end;

procedure TForm1.SpinEditFontSizeChange(Sender: TObject);
begin
  FontDialog1.Font.Size:=SpinEditFontSize.Value;
  SpinEditChange(nil);
end;

procedure TForm1.OnBitmapPress(Sender: TObject);
begin

end;

procedure TForm1.DrawFontList(iWidth, iHeight: Integer);
type
  ltstring = type ansistring(1252);
var
  i, fx, fy, tx, ty, glvl, modX, modY, mx, my, ax, ay: Integer;
  bm: TBitmap;
  bma: TBGRABitmap;
  p: PBGRAPixel;
  fs: TSize;
  NoScale: Boolean;
  FitCY: Boolean;
  s: ltstring;
begin
  glvl:=SpinEditGrayLevel.Value;
  NoScale:=CheckBoxScale.Checked;
  FitCY:=CheckBoxFitCenterY.Checked;
  modX:=-SpinEditGapX.Value;
  modY:=-SpinEditGapY.Value;

  bma:=TBGRABitmap.Create;
  try
    bm:=TBitmap.Create;
    try
      bm.PixelFormat:=pf1bit;
      Image1.SetBounds(0,0,iWidth*16,iHeight*16);
      Image1.Picture.Bitmap.SetSize(iWidth*16,iHeight*16);

      mx:=0;
      my:=0;
      ax:=0;
      ay:=0;
      for i:=0 to 255 do begin
        // make font bitmap
        bm.Canvas.Font.Assign(FontDialog1.Font);
        fs:=bm.Canvas.TextExtent(ltstring(char(i)));

        if ax=0 then
          ax:=fs.cx
          else
            ax:=(fs.cx+ax) div 2;
        if ay=0 then
          ay:=fs.cy
          else
            ay:=(fs.cy+ay) div 2;

        if mx<fs.cx then
          mx:=fs.cx;
        if my<fs.cy then
          my:=fs.cy;

        tx:=0;
        if fs.cx<iWidth then begin
          tx:=(iWidth-fs.cx) div 2;
          fs.cx:=iWidth;
        end;
        ty:=0;
        if FitCY and (fs.cy<iHeight) then begin
          ty:=(iHeight-fs.cy) div 2;
          fs.cy:=iHeight;
        end;
        if fs.cx<=modX then
          modX:=fs.cx-1;
        if fs.cy<=modY then
          modY:=fs.cy-1;

        bm.SetSize(fs.Width-modX,fs.Height-modY);
        bm.Canvas.Font.Color:=clWhite;
        bm.Canvas.Brush.Color:=clBlack;
        bm.Canvas.FillRect(0,0,bm.Width,bm.Height);
        bm.Canvas.TextOut(tx-modX,ty-modY,ltstring(char(i)));

        bma.Assign(bm);
        if not NoScale then begin
          bma.ResampleFilter:=TResampleFilter(ComboBoxAA.ItemIndex);
          BGRAReplace(bma,bma.Resample(iWidth,iHeight));
          //
          for ty:=0 to iHeight-1 do begin
            p:=bma.ScanLine[ty];
            for tx:=0 to iWidth-1 do begin
              if p^.blue>=glvl then
                p^.FromColor(clWhite)
                else
                  p^.FromColor(clBlack);
              inc(p);
            end;
          end;
          bma.InvalidateBitmap;
        end;
        // copy font bitmap
        fx:=iWidth*(i mod 16);
        fy:=iHeight*(i div 16);
        bma.Draw(Image1.Picture.Bitmap.Canvas,fx,fy,True);
        Image1.Invalidate;
      end;
      Label7.Caption:=Format('Max character size= %d, %d',[mx,my]);
      Label8.Caption:=Format('Average character size= %d, %d',[ax,ay]);
    finally
      bm.Free;
    end;
  finally
    bma.Free;
  end;
end;

function TForm1.DecodeBuffer(const sbuf: string; cx: Integer): string;
var
  st: TStringList;
  i, j, k, x: Integer;
  s, sb, sl: string;
begin
  Result:='';
  st:=TStringList.Create;
  try
    st.Delimiter:=',';
    st.DelimitedText:=sbuf;
    sb:='';
    sl:='';
    i:=0;
    while i<cx do begin
      x:=0;
      while x+cx<=st.Count do begin
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
  i, dy, iy, ix, by, bx, fy, fx, stchar, edchar: Integer;
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
    stchar:=0;
    edchar:=255;
    if CheckBoxSkipCtlChar.Checked then begin
      stchar:=32;
      edchar:=127;
    end;
    for i:=stchar to edchar do begin
      Result:=Result+'//'+IntToStr(i)+' '+char(i)+LineEnding;
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
    end;
  finally
    bm.Free;
  end;
end;

function TForm1.EncodeBitmapBin:TMemoryStream;
var
  bm: TBitmap;
  val: Byte;
  i, dy, iy, ix, by, bx, fy, fx, stchar, edchar: Integer;
  bbx, bby: Byte;
begin
  Result:=TMemoryStream.Create;
  try
    bx:=SpinEditWidth.Value;
    by:=SpinEditHeight.Value;
    bm:=TBitmap.Create;
    try
      bm.SetSize(bx, by);
      bm.PixelFormat:=pf1bit;
      bbx:=bx;
      bby:=by;
      Result.Write(bbx,1);
      Result.Write(bby,1);
      stchar:=0;
      edchar:=255;
      //if CheckBoxSkipCtlChar.Checked then begin
      //  stchar:=32;
      //  edchar:=127;
      //end;
      for i:=stchar to edchar do begin
        fx:=bx*(i mod 16);
        fy:=by*(i div 16);
        bm.Canvas.CopyRect(Rect(0, 0, bx, by), Image1.Picture.Bitmap.Canvas, Rect(
          fx, fy, fx+bx, fy+by));
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
            result.Write(val,1);
            inc(ix);
          end;
          inc(dy, 8);
          ix:=0;
        end;
      end;
    finally
      bm.Free;
    end;
  except
    Result.Free;
    Result:=nil;
  end;
end;

end.

