object FormTest: TFormTest
  Left = 291
  Top = 241
  BorderStyle = bsDialog
  Caption = 'Test for Interfaces'
  ClientHeight = 345
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 24
    Width = 417
    Height = 297
    Lines.Strings = (
      '���Զ�һδ֪�ӿڵĶ�̬�ж��븲�ǡ�'
      ''
      
        '������Delphi 10.2.3 �е� ToolsAPI �� 10.2.2 �������������֧�ֵ�' +
        '�ӿڣ�ר��'
      '�����Ҫ֧�����⣬�����ʹ�� 10.2.3 ���룬��ʹ�������ӿڡ� '
      ' '
      
        '�����������ǣ����ר�Ұ��� 10.2.2 �����У������Ϊ�޷��ҵ���Щ��' +
        '�ڶ���'
      '����'
      ''
      
        '���ڸ�������һ�ַ�������ֱ������ 10.2.3 �������½ӿڣ�ֻ���� GUI' +
        'D ���� '
      'Supports ���ò�ѯ���� 10.2.2�����ѯ�����ӿڵ�ʵ�֣��Ӷ��ɽ��á�'
      ''
      
        '����鵽��ʵ�֣�Ҳ����ֱ��ʹ�� 10.2.3 �������½ӿڣ�ֻ�ܷ�������' +
        '�ӿ�д'
      'һ�׶�Ӧ��һģһ���Ľӿڣ�Ȼ����á�'
      ''
      
        '��������ʾ����֤�����ֵ��ã�ԭʼ�ӿ��ṩ���� IOriginalInterface ' +
        '�Լ���ʵ��'
      '������ʵ��ͨ�� IUnknown �ӿڷ��ء�'
      ''
      
        '������������һ��һģһ���Ľӿ� IOverrideProvider��ͨ��Supports ' +
        '��ѯ '
      
        'IOriginalInterface �� GUID�������ʵ�ֲ�ǿ��ת���� IOverrideProv' +
        'ider �Գɹ���'
      '�á���ȫ���õ� IOriginalInterface ��������')
    TabOrder = 0
  end
end