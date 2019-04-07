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
     N2W = LTrim(cResult) + " лв. и " + Str(nDiv) + " ст."
   Else
     N2W = LTrim(cResult) + " лв."
   End If
End Function

Sub ProcGroup(nNumber, nGroup)
Attribute ProcGroup.VB_ProcData.VB_Invoke_Func = " \n14"
   cGroupS = Array("", " хиляда", " милион", " трилион")
   cGroupM = Array("", " хиляди", " милиона", " трилиона")
   c3_9 = Array(" три", " четири", " пет", " шест", " седем", " осем", " девет")
   c10_19 = Array(" десет", " единаесет", " дванадесет", " тринадесет", " четиринадесет", _
      " петнадесет", " шестнадесет", " седемнадесет", " осемнадсесет", " деветнадесет")
   c2X_9X = Array(" двадесет", " тридесет", " четиридесет", " петдесет", " шестдесет", _
      " седемдесет", " осемдесет", " деветдесет")
   c0XX_9XX = Array("", " сто", " двеста", " триста", " четиристотин", " петстотин", _
      " шестотин", " седемстотин", " осемстотин", " деветстотин")
   Dim n, nleft, nRight1, nRight2, nMid As Integer
   Dim lMidNo1 As Boolean
   nleft = Int(nNumber / 100)
   nRight1 = nNumber Mod 10
   nRight2 = nNumber Mod 100
   nMid = Int((nNumber Mod 100) / 10)
   lMidNo1 = True
   If nGroup = 1 And lAnd And nleft > 0 And nRight2 = 0 Then cResult = cResult + " и"
   cResult = cResult + c0XX_9XX(nleft + 1)
   If (Convert.Between(nRight2, 1, 20) Or _
         Convert.InSet(nRight2, 30, 40, 50, 60, 70, 80, 90)) And (lAnd Or nleft > 0) Then
      cResult = cResult + " и"
   End If
   If nMid > 1 Then
      cResult = cResult + c2X_9X(nMid - 1)
      If nRight1 > 0 Then cResult = cResult + " и"
   ElseIf nMid = 1 Then
      lMidNo1 = False
      cResult = cResult + c10_19(nRight2 - 9)
   End If
   If Convert.Between(nRight1, 3, 9) And lMidNo1 Then cResult = cResult + c3_9(nRight1 - 2)
   If nRight1 = 1 And lMidNo1 Then
      If nGroup <> 2 Or nNumber > 1 Then cResult = cResult + " един"
   End If
   If nRight1 = 2 And lMidNo1 Then cResult = cResult + Convert.Iif(nGroup = 2, " две", " два")
   If nGroup > 1 And nNumber > 0 Then
      lAnd = True
      cResult = cResult + Convert.Iif(nNumber > 1, cGroupM(nGroup), cGroupS(nGroup))
   End If
End Sub
