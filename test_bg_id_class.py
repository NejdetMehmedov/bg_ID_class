import bg_id_class


print(bg_id_class.isEGN('7705048854  '))
print(bg_id_class.isEGN('705048854  '))

print(bg_id_class.isLNCh('1002101762'))
print(bg_id_class.isLNCh('705048854  '))

print(bg_id_class.isIBAN('BG80BNBG96611020345678'))
print(bg_id_class.isIBAN('BG80BNBG96621020345678'))


EGNlist=['7524169268 ', '7501010010', '7552010005', '8032056031', '8001010008', '7552011038', '8141010016',
         '7541692681 ', '7501019010', '755201000 5']
for EGN in EGNlist:
    e1 = bg_id_class.EGN(EGN)
    print(e1.value)
    print(e1.errors)
    print(e1.get_Burthday())
    print(e1.iserror())
    print(e1.sex)


""" 

Примери:
ЕГН Значение
7524169268 Мъж, с дата на раждане 16.04.1875 г.
7501010010 Жена, с дата на раждане 01.01.1975 г.
7552010005 Мъж, с дата на раждане 01.12.2075 г.
8032056031 Жена, с дата на раждане 05.12.1880 г.
8001010008 Мъж, с дата на раждане 01.01.1980 г.
7552011038 Жена, с дата на раждане 01.12.2075 г.
8141010016 Жена, с дата на раждане 01.01.2081 г

EGNlist=['7524169268 ', '7501010010', '7552010005', '8032056031', '8001010008', '7552011038', '8141010016',
         '7541692681 ', '7501019010', '755201000 5']
for EGN in EGNlist:
    e1 = bg_id_class.EGN(EGN)
    print(e1.value)
    print(e1.errors)
    print(e1.get_Burthday())
    print(e1.iserror())
    print(e1.sex)

lnchlist=['1002101762','100228485','1002373428','1002863527','1002965186']
for i in lnchlist:
    l1 =  bg_id_class.LNCh(i)
    print(l1.value)
    print(l1.errors)



EIKlist=['121699202','127521092','131071587','201284880','127513277', '127585839']
for i in EIKlist:
    l1 =  bg_id_class.EIK9(i)
    print(l1.value)
    print(l1.errors)

IBANlist = ['BG80BNBG96611020345678' , 'BG80BNBG96621020345678']
for i in IBANlist:
    l1 =  bg_id_class.IBAN(i)
    print(l1.value)
    print(l1.printvalue)
    print(l1.errors)
"""
