Attribute VB_Name = "Num2Word"
Option Base 1
Private cResult As String
Private lAnd As Boolean


Function N2W(nNumber As Double)
Attribute N2W.VB_ProcData.VB_Invoke_Func = " \n14"
   Dim cNumber As String
   Dim nGroups As Integer
   Dim n As Integer
   Dim nDiv As Integer
      
   cResult = ""
   nNumber = nNumber * 100
   nDiv = nNumber Mod 100
   nNumber = nNumber \ 100
   lAnd = False
   cNumber = Convert.PadL(LTrim(Str(nNumber)), 12, "0")
   nGroups = Int(Len(cNumber) / 3)
   For n = 1 To nGroups
      Call ProcGroup(Val(Mid(cNumber, n * 3 - 2, 3)), 5 - n)
   Next
   If nDiv > 0 Then
     N2W = LTrim(cResult) + " ��. � " + Str(nDiv) + " ��."
   Else
     N2W = LTrim(cResult) + " ��."
   End If
End Function

Sub ProcGroup(nNumber, nGroup)
Attribute ProcGroup.VB_ProcData.VB_Invoke_Func = " \n14"
   cGroupS = Array("", " ������", " ������", " �������")
   cGroupM = Array("", " ������", " �������", " ��������")
   c3_9 = Array(" ���", " ������", " ���", " ����", " �����", " ����", " �����")
   c10_19 = Array(" �����", " ���������", " ����������", " ����������", " �������������", _
      " ����������", " �����������", " ������������", " ������������", " ������������")
   c2X_9X = Array(" ��������", " ��������", " �����������", " ��������", " ���������", _
      " ����������", " ���������", " ����������")
   c0XX_9XX = Array("", " ���", " ������", " ������", " ������������", " ���������", _
      " ��������", " �����������", " ����������", " �����������")
   Dim n, nleft, nRight1, nRight2, nMid As Integer
   Dim lMidNo1 As Boolean
   nleft = Int(nNumber / 100)
   nRight1 = nNumber Mod 10
   nRight2 = nNumber Mod 100
   nMid = Int((nNumber Mod 100) / 10)
   lMidNo1 = True
   If nGroup = 1 And lAnd And nleft > 0 And nRight2 = 0 Then cResult = cResult + " �"
   cResult = cResult + c0XX_9XX(nleft + 1)
   If (Convert.Between(nRight2, 1, 20) Or _
         Convert.InSet(nRight2, 30, 40, 50, 60, 70, 80, 90)) And (lAnd Or nleft > 0) Then
      cResult = cResult + " �"
   End If
   If nMid > 1 Then
      cResult = cResult + c2X_9X(nMid - 1)
      If nRight1 > 0 Then cResult = cResult + " �"
   ElseIf nMid = 1 Then
      lMidNo1 = False
      cResult = cResult + c10_19(nRight2 - 9)
   End If
   If Convert.Between(nRight1, 3, 9) And lMidNo1 Then cResult = cResult + c3_9(nRight1 - 2)
   If nRight1 = 1 And lMidNo1 Then
      If nGroup <> 2 Or nNumber > 1 Then cResult = cResult + " ����"
   End If
   If nRight1 = 2 And lMidNo1 Then cResult = cResult + Convert.Iif(nGroup = 2, " ���", " ���")
   If nGroup > 1 And nNumber > 0 Then
      lAnd = True
      cResult = cResult + Convert.Iif(nNumber > 1, cGroupM(nGroup), cGroupS(nGroup))
   End If
End Sub
