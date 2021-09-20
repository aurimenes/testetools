object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object DB: TFDConnection
    Params.Strings = (
      'Database=tools'
      'User_Name=root'
      'Password='
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object TR: TFDTransaction
    Connection = DB
    Left = 112
    Top = 16
  end
  object Link: TFDPhysMySQLDriverLink
    VendorLib = 'libmariadb.dll'
    Left = 32
    Top = 72
  end
  object FDQuery1: TFDQuery
    Connection = DB
    Left = 112
    Top = 72
  end
end
