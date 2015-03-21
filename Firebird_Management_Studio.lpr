program Firebird_Management_Studio;

{$mode objfpc}{$H+}
//{$DEFINE LCLWIN32}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }

  LCLIntf, LCLType, LMessages, interfacebase,

  frmuSplash, dmuMain, frmuMain,

  Windows, win32int, RichBox, WSRichBoxFactory, WSRichBox,
  Win32WSRichBox, Win32WSRichBoxFactory;
{$R *.res}

begin
    { Create a mutex to make sure only 1 instance is running }
  CreateMutex (nil, false, 'fb_man_studio_mtx');
  if GetLastError() = ERROR_ALREADY_EXISTS then
  begin
    { It's already running so Restore the other copy }
    SendMessage (HWND_BROADCAST,
                 RegisterWindowMessage('fb_man_studio_mtx'),
                 0,
                 0);
    Halt(0);
  end;
  RequireDerivedFormResource := True;
  Application.Initialize;
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
  frmSplash.Update;
  Application.ProcessMessages;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmMain, dmMain);
  frmSplash.Free;
  Application.ShowMainForm := true;
  ShowWindow(TWin32WidgetSet(WidgetSet).AppHandle, SW_RESTORE);
  Application.Run;
end.

