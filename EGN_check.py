
# Проверка на ЕГН

############

def EGN_CHeck(EGN):
    EGN_CtrlDigits  = [2, 4, 8, 5, 10, 9, 7, 3, 6]
    LNCh_CtrlDigits = [21, 19, 17, 13, 11, 9, 7, 3, 1]
    retstr = ''

    try:
        EGNn =  int(EGN)
    except ValueError:
        retstr = 'Грешни знаци в ЕГН: ' + EGN
        return retstr
    if len(EGN) != 10:
        retstr = 'Грешен брой цифри в ЕГН: ' + EGN
        return retstr


    EGN_month = int(EGN[2:4])
    if EGN_month < 13:
        EGN_Year = 1900 + EGN_month
    elif (EGN_month > 20) and (EGN_month < 33):
        EGN_month = EGN_month - 20
        EGN_Year = 1800 + EGN_month
    elif (EGN_month > 40) and (EGN_month < 53):
        EGN_month = EGN_month - 400
        EGN_Year = 2000 + EGN_month
    else :
        retstr = 'Грешен месец в ЕГН: ' + EGN
        return retstr

    controlsum = 0
    for i in range(9):
        controlsum += EGN_CtrlDigits[i] * int(EGN[i])

    controlsum = divmod(controlsum, 11)[1]
    if controlsum == 10 :
        controlsum = 0

    if controlsum != int(EGN[9]) :
        retstr = 'Грешна контролна сума за ЕГН: ' + EGN + '  -> ' + str(controlsum)
        return retstr


    retstr = 'Вярно ЕГН: '+ EGN
    return retstr
#### End of EGN_Check

print(EGN_CHeck(""))
print(EGN_CHeck("81"))

print(EGN_CHeck("8041561238"))

print(EGN_CHeck("68458ннн01"))


print(EGN_CHeck("7524169268"))
print(EGN_CHeck("7501010010"))
print(EGN_CHeck("7552010005"))
print(EGN_CHeck("8032056031"))
print(EGN_CHeck("8001010008"))
print(EGN_CHeck("7552011038"))
print(EGN_CHeck("8141010016"))
