Attribute VB_Name = "EGN_LNCh"
Function EGN_Prov(Egn As String)
Dim ControlSum As Variant
Dim ControlDigit As Integer
Dim RestoreDate As String
Dim Vek19 As Boolean
Vek19 = False
If Not IsNumeric(Egn) Then
    EGN_Prov = "Не е номер!?"
    Exit Function
End If
If Len(Egn) > 10 Then
EGN_Prov = "Много символи!"
Exit Function

End If
 
If Len(Egn) <= 8 Then
  EGN_Prov = "Малко цифри!"
  Exit Function
End If
If (Val(Mid(Egn, 3, 2)) > 40) Then
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & (Val(Mid(Egn, 3, 2)) - 40) & "/"
        If (Val(Mid(Egn, 1, 2)) < 10) Then
                                         RestoreDate = RestoreDate & "200" & Val(Mid(Egn, 1, 2))
                                      Else
                                         RestoreDate = RestoreDate & "20" & Val(Mid(Egn, 1, 2))
        End If

ElseIf Val(Mid(Egn, 3, 2)) < 13 Then
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & Val(Mid(Egn, 3, 2)) & "/" & "19" & Val(Mid(Egn, 1, 2))
 
Else
        Vek19 = True
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & (Val(Mid(Egn, 3, 2)) - 20) & "/" & Val(Mid(Egn, 1, 2))
End If



If Not IsDate(RestoreDate) Then
  EGN_Prov = "Не е дата!"
Exit Function
End If

ControlSum = Val(Mid(Egn, 1, 1)) * 2
ControlSum = ControlSum + Val(Mid(Egn, 2, 1)) * 4
ControlSum = ControlSum + Val(Mid(Egn, 3, 1)) * 8
ControlSum = ControlSum + Val(Mid(Egn, 4, 1)) * 5
ControlSum = ControlSum + Val(Mid(Egn, 5, 1)) * 10
ControlSum = ControlSum + Val(Mid(Egn, 6, 1)) * 9
ControlSum = ControlSum + Val(Mid(Egn, 7, 1)) * 7
ControlSum = ControlSum + Val(Mid(Egn, 8, 1)) * 3
ControlSum = ControlSum + Val(Mid(Egn, 9, 1)) * 6
ControlDigit = CInt(ControlSum) Mod 11

If ControlDigit = 10 Then
    ControlDigit = 0
End If

If Len(Egn) = 9 Then
  EGN_Prov = "Добавете контролна цифра " & ControlDigit
  Exit Function
End If

If (Len(Egn) = 10 And (CInt(Val(Mid(Egn, 10, 1))) <> ControlDigit)) Then
  EGN_Prov = "ГРЕШНО ЕГН!"
  Exit Function
End If

If Len(Egn) = 10 Then
  If (CInt(Val(Mid(Egn, 10, 1))) = ControlDigit) Then
        If ((Val(Mid(Egn, 9, 1)) Mod 2) = 0) Then
        EGN_Prov = "ЕГН-мъж."
        Else
        EGN_Prov = "ЕГН-жена."
        End If
  End If
End If
End Function

Function LNCh_Prov(LNCh As Variant)
Dim ControlSum As Variant
Dim ControlDigit As Integer
Dim RestoreDate As String

If LNCh = "" Then
    LNCh_Prov = ""
    Exit Function
End If

If Not IsNumeric(LNCh) Then
    LNCh_Prov = "Не е номер!?"
    Exit Function
End If

If Len(LNCh) > 10 Then
  LNCh_Prov = "Много символи!"
  Exit Function
End If
 
If Len(LNCh) <= 8 Then
  LNCh_Prov = "Малко цифри "
  Exit Function
End If


ControlSum = Val(Mid(LNCh, 1, 1)) * 21
ControlSum = ControlSum + Val(Mid(LNCh, 2, 1)) * 19
ControlSum = ControlSum + Val(Mid(LNCh, 3, 1)) * 17
ControlSum = ControlSum + Val(Mid(LNCh, 4, 1)) * 13
ControlSum = ControlSum + Val(Mid(LNCh, 5, 1)) * 11
ControlSum = ControlSum + Val(Mid(LNCh, 6, 1)) * 9
ControlSum = ControlSum + Val(Mid(LNCh, 7, 1)) * 7
ControlSum = ControlSum + Val(Mid(LNCh, 8, 1)) * 3
ControlSum = ControlSum + Val(Mid(LNCh, 9, 1)) * 1
ControlDigit = CInt(ControlSum) Mod 10

'If Len(LNCh) = 9 Then
'  LNCh_Prov = "Добавете контролна цифра " & ControlDigit
'End If

If (Len(LNCh) = 10 And (CInt(Val(Mid(LNCh, 10, 1))) <> ControlDigit)) Then
  ' LNCh_Prov = "Вярната цифра е " & ControlDigit
   LNCh_Prov = "ЛНЧ - Грешка"
End If

' По предпоследната цифра май не може да се определи дали е МЪЖ или ЖЕНА
If Len(LNCh) = 10 Then
  If (CInt(Val(Mid(LNCh, 10, 1))) = ControlDigit) Then
        If ((Val(Mid(LNCh, 9, 1)) Mod 2) = 0) Then
        LNCh_Prov = "ЛНЧ" '"ЛНЧ - мъж."
        Else
        LNCh_Prov = "ЛНЧ" '"ЛНЧ - жена."
        End If
  End If
End If
End Function


Function EGN_Date(Egn As String)
Dim ControlSum As Variant
Dim ControlDigit As Integer
Dim RestoreDate As String
Dim Vek19 As Boolean
Vek19 = False

If Not IsNumeric(Egn) Then
    EGN_Date = "Не е номер!?"
    Exit Function
End If
 If Len(Egn) > 10 Then
  EGN_Date = "Твърде много символи!  "
Exit Function

End If
 
If Len(Egn) <= 8 Then
  EGN_Date = "Малко цифри "
  Exit Function
End If

If (Val(Mid(Egn, 3, 2)) > 40) Then
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & (Val(Mid(Egn, 3, 2)) - 40) & "/"  '' & "20" & Val(Mid(Egn, 1, 2))
        If (Val(Mid(Egn, 1, 2)) < 10) Then
                                         RestoreDate = RestoreDate & "200" & Val(Mid(Egn, 1, 2))
                                      Else
                                         RestoreDate = RestoreDate & "20" & Val(Mid(Egn, 1, 2))
        End If
 
ElseIf Val(Mid(Egn, 3, 2)) < 13 Then
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & Val(Mid(Egn, 3, 2)) & "/" & "19" & Val(Mid(Egn, 1, 2))
 
Else
        Vek19 = True
        RestoreDate = Val(Mid(Egn, 5, 2)) & "/" & (Val(Mid(Egn, 3, 2)) - 20) & "/" & Val(Mid(Egn, 1, 2))
End If


If Not IsDate(RestoreDate) Then
  EGN_Date = "Не е дата!"
Exit Function
End If
If Vek19 = True Then
EGN_Date = Mid(Egn, 5, 2) & "." & (Val(Mid(Egn, 3, 2)) - 20) & ".18" & Mid(Egn, 1, 2)

Else
EGN_Date = CDate(RestoreDate)
End If


End Function

