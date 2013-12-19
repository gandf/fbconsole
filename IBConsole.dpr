program IBConsole;

{%ToDo 'IBConsole.todo'}

uses
  Windows,
  Forms,
  frmuMain in 'frmuMain.pas' {frmMain},
  frmuAbout in 'frmuAbout.pas' {frmAbout},
  zluGlobal in 'zluGlobal.pas',
  frmuServerLogin in 'frmuServerLogin.pas' {frmServerLogin},
  frmuUser in 'frmuUser.pas' {frmUserInfo},
  dmuMain in 'dmuMain.pas' {dmMain: TDataModule},
  frmuServerRegister in 'frmuServerRegister.pas' {frmServerRegister},
  zluibcClasses in 'zluibcClasses.pas',
  frmuDBRegister in 'frmuDBRegister.pas' {frmDBRegister},
  frmuSplash in 'frmuSplash.pas' {frmSplash},
  frmuMessage in 'frmuMessage.pas' {frmMessage},
  zluUtility in 'zluUtility.pas',
  frmuDBConnect in 'frmuDBConnect.pas' {frmDBConnect},
  frmuDBBackup in 'frmuDBBackup.pas' {frmDBBackup},
  frmuServerProperties in 'frmuServerProperties.pas' {frmServerProperties},
  frmuDBProperties in 'frmuDBProperties.pas' {frmDBProperties},
  frmuBackupAliasProperties in 'frmuBackupAliasProperties.pas' {frmBackupAliasProperties},
  frmuDBCreate in 'frmuDBCreate.pas' {frmDBCreate},
  zluContextHelp in 'zluContextHelp.pas',
  zluCommDiag in 'zluCommDiag.pas',
  frmuCommDiag in 'frmuCommDiag.pas' {frmCommDiag},
  frmuDBConnections in 'frmuDBConnections.pas' {frmDBConnections},
  frmuDBShutdown in 'frmuDBShutdown.pas' {frmDBShutdown},
  frmuDBStatistics in 'frmuDBStatistics.pas' {frmDBStatistics},
  frmuDBValidationReport in 'frmuDBValidationReport.pas' {frmDBValidationReport},
  frmuDBTransactions in 'frmuDBTransactions.pas' {frmDBTransactions},
  frmuDBValidation in 'frmuDBValidation.pas' {frmDBValidation},
  frmuDBRestore in 'frmuDBRestore.pas' {frmDBRestore},
  frmuDispMemo in 'frmuDispMemo.pas' {frmDispMemo},
  frmuModifyServerAlias in 'frmuModifyServerAlias.pas' {frmModifyServerAlias},
  zluSQL in 'zluSQL.pas',
  frmuDisplayBlob in 'frmuDisplayBlob.pas' {frmDisplayBlob},
  frmuDlgClass in 'frmuDlgClass.pas' {Dialog},
  frmuObjectWindow in 'frmuObjectWindow.pas' {frmObjectView},
  wisql in 'wisql.pas' {dlgWisql},
  frmuTextViewer in 'frmuTextViewer.pas' {frmTextViewer},
  frmuSQLOptions in 'frmuSQLOptions.pas' {frmSQLOptions},
  frmuTools in 'frmuTools.pas' {frmTools},
  frmuAddTool in 'frmuAddTool.pas' {frmAddTools},
  frmuDescription in 'frmuDescription.pas' {frmDescription},
  frmuWindowList in 'frmuWindowList.pas' {dlgWindowList},
  MemoLists in 'MemoLists.pas',
  zluPersistent in 'zluPersistent.pas';

{$R *.RES}

begin
  { Create a mutex to make sure only 1 instance is running }
  CreateMutex (nil, false, 'ib_console_mtx');
  if GetLastError() = ERROR_ALREADY_EXISTS then
  begin
    { It's already running so Restore the other copy }
    SendMessage (HWND_BROADCAST,
                 RegisterWindowMessage('ib_console_mtx'),
                 0,
                 0);
    Halt(0);
  end;
  Application.Initialize;
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
  frmSplash.Update;
  Application.ProcessMessages;
  Application.Title := 'IBConsole';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMain, frmMain);
  frmSplash.Free;
  Application.ShowMainForm := true;
  ShowWindow(Application.Handle, SW_RESTORE);
  Application.Run;
end.

