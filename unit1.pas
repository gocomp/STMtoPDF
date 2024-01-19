unit unit1;

interface

uses
        Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
        System.Classes, Vcl.Graphics,
        Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.Grids,
        Vcl.StdCtrls,
        Vcl.ExtCtrls, PReport, PdfDoc, PdfTypes, PdfFonts;

type
        TForm1 = class(TForm)
                Button1: TButton;
                Button2: TButton;
                StringGrid1: TStringGrid;
                SaveTextFileDialog1: TSaveTextFileDialog;
                OpenTextFileDialog1: TOpenTextFileDialog;
                Panel1: TPanel;
                Panel2: TPanel;
                Button3: TButton;
                PReport1: TPReport;
                Label1: TLabel;
                szamszam: TLabel;
                deviza: TLabel;
                tulaj: TLabel;
                cim: TLabel;
                egyenkezd: TLabel;
                egyenveg: TLabel;
                Nyitóegyenleg: TLabel;
                Label2: TLabel;
                Label3: TLabel;
                Label4: TLabel;
                kezddatum: TLabel;
                vegdatum: TLabel;
                procedure Button1Click(Sender: TObject);
                procedure Button3Click(Sender: TObject);
                procedure Button2Click(Sender: TObject);
        private
                { Private declarations }
        public
                { Public declarations }
        end;

var
        Form1: TForm1;

var
        fdoc: TPdfDoc;
        FFileName: string;
        FOutFile: TFileStream;
        FPage, Crow: integer;

const
        sorarray: array of array of string = [['rekordtipus', '2'],
          ['terheles', '6'], ['azonosito', '15'], ['megbizasosszeg', '16'],
          ['devizaneme', '3'], ['odosialetelbankja', '140'],
          ['megbizoneve', '140'], ['megbizoszamlaszama', '34'],
          ['Kozlemeny', '140'], ['prijemcabankja', '140'],
          ['kedvezmenyezettneve', '140'], ['kedvezmenyezettSzamlaszama', '34'],
          ['Bizonylatszam', '6'], ['Hatarido', '8'],
          ['jovairasszamlaszama', '24'], ['jovairasdevizaneme', '3'],
          ['jovairasvegsoosszege', '16'], ['jovairaserteknapja', '8'],
          ['terhelesszamlaszama', '24'], ['terhelesdevizaneme', '3'],
          ['terhelesvegsosszege', '16'], ['terheleserteknapja', '8']];

        fsorarray: array of array of string = [['rekordtipus', '2'],
          ['A kivonat azonosítója ', '8'], ['Számlaszám', '24'],
          ['A számla devizaneme ', '3'], ['A számla neve ', '20'],
          ['A fiók kódja', '8'], ['A fiók neve ', '20'],
          ['A kivonat kezdınapja ', '8'], ['A kivonat zárónapja ', '8'],
          ['Nyitóegyenleg a kezdınapon', '19'], ['Záróegyenleg a zárónapon ',
          '19'], ['Az ügyfél neve', '50'], ['cime', '50']];

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
        TextFile: TStringList;
        Line, szoveg: string;
        ColumnIndex, isor, i, ikurzor: integer;
begin

        if OpenTextFileDialog1.Execute then
        begin

                TextFile := TStringList.Create;
                try
                        TextFile.LoadFromFile(OpenTextFileDialog1.FileName,
                          TEncoding.GetEncoding(852));

                        i := 0;
                        StringGrid1.RowCount := TextFile.Count;

                        for isor := 0 to 21 do
                        begin

                                StringGrid1.Cells[isor, 0] := sorarray[isor][0];

                        end;

                        for Line in TextFile do
                        begin
                                szoveg := Copy(Line, 1, 2);
                                if szoveg = '13' then
                                        break;

                                if i = 0 then // fejlec
                                begin

                                        ikurzor := 1;

                                        for isor := 0 to 12 do
                                        begin
                                        szoveg := Copy(Line, ikurzor,
                                        strtoint(fsorarray[isor][1]));
                                        ikurzor := ikurzor +
                                        strtoint(fsorarray[isor][1]);
                                        case isor of
                                        0:
                                        Continue;
                                        1:
                                        Continue;
                                        2:
                                        szamszam.Caption := szoveg;
                                        3:
                                        deviza.Caption := szoveg;
                                        4:
                                        tulaj.Caption := szoveg;
                                        5:
                                        Continue;
                                        6:
                                        Continue;
                                        7:
                                        kezddatum.Caption := szoveg;
                                        8:
                                        vegdatum.Caption := szoveg;
                                        9:
                                        begin
                                        insert('.', szoveg, Length(szoveg) - 1);
                                        egyenkezd.Caption :=
                                        FormatFloat('#,##0.00',
                                        strtofloat(szoveg)) + ' ' +
                                        deviza.Caption;
                                        end;
                                        10:
                                        begin
                                        insert('.', szoveg, Length(szoveg) - 1);
                                        egyenveg.Caption :=
                                        FormatFloat('#,##0.00',
                                        strtofloat(szoveg)) + ' ' +
                                        deviza.Caption;
                                        end;

                                        11:
                                        Continue;
                                        12:
                                        cim.Caption := szoveg;

                                        end;

                                        end;
                                end;

                                if i > 0 then
                                begin

                                        ColumnIndex := 0;
                                        ikurzor := 1;

                                        for isor := 0 to 21 do
                                        begin
                                        if isor = 3 then
                                        begin
                                        szoveg := Copy(Line, ikurzor,
                                        strtoint(sorarray[isor][1]));
                                        insert('.', szoveg, Length(szoveg) - 1);
                                        StringGrid1.Cells[ColumnIndex, i] :=
                                        FormatFloat('#,##0.00',
                                        strtofloat(szoveg));
                                        end
                                        else
                                        StringGrid1.Cells[ColumnIndex, i] :=
                                        Copy(Line, ikurzor,
                                        strtoint(sorarray[isor][1]));

                                        ikurzor := ikurzor +
                                        strtoint(sorarray[isor][1]);
                                        szoveg := StringGrid1.Cells
                                        [ColumnIndex, i];
                                        Inc(ColumnIndex);
                                        end;

                                end;
                                Inc(i);
                        end;
                finally
                        TextFile.Free;
                end;
        end;

end;

procedure TextOut(X, Y: Single; S: string);
begin
        with fdoc.Canvas do
        begin
                BeginText;
                MoveTextPoint(X, Y);
                ShowText(S);
                EndText;
        end;
end;

procedure DrawLine(X1, Y1, X2, Y2, Width: Single);
begin
        with fdoc.Canvas do
        begin
                MoveTo(X1, Y1);
                LineTo(X2, Y2);
                Stroke;
        end;
end;

procedure WriteHeader;
var
        S: string;
        w: integer;
begin
        // writing the headline of the pages
        with fdoc.Canvas do
        begin
                // setting font
                SetFont('Arial-BoldItalic', 9);

                // printing text.
                TextOut(90, 770, 'Výpis');

                TextOut(90, 810, 'Számlaszám: ' + Form1.szamszam.Caption);
                TextOut(90, 800, Form1.tulaj.Caption);
                TextOut(90, 790, Form1.cim.Caption);

                SetFont('Arial-BoldItalic', 8);
                S := Form1.kezddatum.Caption;
                insert('/', S, 5);
                insert('/', S, 8);
                S := 'Nyitó dátum: ' + S;

                // writing header text.
                TextOut(330 - Length(S), 810, S);
                S := Form1.vegdatum.Caption;
                insert('/', S, 5);
                insert('/', S, 8);
                S := 'Záró dátum: ' + S;
                TextOut(330 - Length(S), 790, S);

                S := Form1.egyenkezd.Caption;

                S := 'Nyitó egyenleg: ' + S;

                TextOut(440 - Length(S), 810, S);
                S := Form1.egyenveg.Caption;

                S := 'Záró egyenleg: ' + S;
                TextOut(440 - Length(S), 790, S);

                SetRGBStrokeColor($00008800);
                DrawLine(90, 765, 530, 765, 1.5);
        end;
end;

procedure WriteFooter;
var
        w: Single;
        S: string;
begin
        with fdoc.Canvas do
        begin

                SetFont('Times-Roman', 8);

                DrawLine(90, 70, 530, 70, 1.5);

                S := 'Oldal ' + IntToStr(FPage);
                w := TextWidth(S);

                TextOut((PageWidth - w) / 2, 55, S);
        end;
end;

procedure WriteRow(YPos: Single; strrow: integer);
var
        i: integer;
        S, ss: string;
begin
        with fdoc.Canvas do
        begin

                begin
                        SetFont('Times-Roman', 10);
                        S := Form1.StringGrid1.Cells[21, strrow + 1];
                        if S = '        ' then
                                S := Form1.StringGrid1.Cells[17, strrow + 1];

                        insert('/', S, 5);
                        insert('/', S, 8);
                        TextOut(95, YPos - 15, S);

                        S := Form1.StringGrid1.Cells[21, strrow + 1];

                        S := Form1.StringGrid1.Cells[3, strrow + 1] + ' ' +
                          Form1.StringGrid1.Cells[4, strrow + 1];

                        TextOut(440, YPos - 15, S);

                        SetFont('Times-Roman', 8);
                        S := TrimRight(Form1.StringGrid1.Cells[8,
                          strrow + 1]) + ', ';

                        ss := Form1.tulaj.Caption;

                        if TrimRight(Form1.StringGrid1.Cells[6, strrow + 1]) <>
                          TrimRight(ss) then
                                S := S + ', ' +
                                  TrimRight(Form1.StringGrid1.Cells[6,
                                  strrow + 1]);

                        if TrimRight(Form1.StringGrid1.Cells[10, strrow + 1]) <>
                          TrimRight(ss) then
                                S := S + '  ' +
                                  TrimRight(Form1.StringGrid1.Cells[10,
                                  strrow + 1]);

                        i := MeasureText(S, 330);
                        TextOut(155, YPos - 15, Copy(S, 1, i));
                        ss := Form1.szamszam.Caption;
                        S := '';

                        if TrimRight(Form1.StringGrid1.Cells[7, strrow + 1]) <>
                          TrimRight(ss) then
                                S := TrimRight(Form1.StringGrid1.Cells[7,
                                  strrow + 1]);

                        if TrimRight(Form1.StringGrid1.Cells[11, strrow + 1]) <>
                          TrimRight(ss) then
                                S := S + '  ' +
                                  TrimRight(Form1.StringGrid1.Cells[11,
                                  strrow + 1]);

                        i := MeasureText(S, 330);
                        TextOut(155, YPos - 25, Copy(S, 1, i));

                        SetFont('Times-Roman', 10);

                end;
        end;
end;

procedure WritePage;
var
        i: integer;
        XPos, YPos: Single;
begin
        with fdoc.Canvas do
        begin

                SetLineWidth(1.5);
                Rectangle(90, 80, 440, 680);
                Stroke;

                YPos := 760;
                SetLineWidth(0.75);
                for i := 0 to 25 do
                begin
                        YPos := YPos - 25;
                        MoveTo(90, YPos);
                        LineTo(530, YPos);
                        Stroke;
                end;
                SetLineWidth(1);
                SetFont('Times-Roman', 10.5);

                XPos := 90;
                TextOut(XPos + 5, 745, 'Dátum.');

                XPos := 150;
                DrawLine(XPos, 760, XPos, 80, 1);
                TextOut(XPos + 5, 745, 'Popis transakcie');

                XPos := 435;
                DrawLine(XPos, 760, XPos, 80, 1);
                TextOut(XPos + 5, 745, 'Suma');

                XPos := 530;
                DrawLine(XPos, 760, XPos, 80, 1);

                SetFont('Arial', 10.5);
        end;

        YPos := 740;

        for i := 0 to 25 do
        begin
                WriteRow(YPos, Crow);
                YPos := YPos - 25;
                Inc(Crow);
                if Crow > Form1.StringGrid1.RowCount then
                        break;
        end;

end;

procedure TForm1.Button2Click(Sender: TObject);

begin

        SaveTextFileDialog1.Execute;
        FOutFile := TFileStream.Create(SaveTextFileDialog1.FileName, fmCreate);

        FPage := 1;
        fdoc := TPdfDoc.Create;
        Crow := 0;
        with fdoc do
                try
                        NewDoc;

                        while True do

                        begin
                                if Crow > Form1.StringGrid1.RowCount then
                                        break;
                                AddPage;
                                WriteHeader;
                                WritePage;
                                WriteFooter;
                                Inc(FPage);
                        end;

                        fdoc.SaveToStream(FOutFile);
                finally
                        fdoc.Free;
                end;

        FOutFile.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
        Close;
end;

end.
