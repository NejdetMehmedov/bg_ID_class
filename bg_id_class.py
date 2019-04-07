
import datetime
# Базов клас за проверка на лалидностите на ЕГН, ЛНЧ, БУЛСТАТ, ЕИК, IBAN

class bg_id_check:
    def __init__(self, val):
        # private fields
        self._value = str.strip(val)   # стойност на ID
        self._len = 0       # дължина на стойността
        self._dweight = [] # тегла за изчисляване на контролна сума
        self._status = ()  #
        self._ctrlpos = 0  # начало на позицията на контролното число
        self._ctrllen = 1  # дължина на контролното число

        # public fields
        self.errors = []  # списък на грешките при проверкиге

    def check(self):
        pass
    def iserror(self):
        if self.errors == []: return False
        else: return True
# Край на класа bg_id_chech

class EGN(bg_id_check):

    def __init__(self, str_egn):
        super().__init__(str_egn)
        self._ctrlpos = 9
        self._dweight =[2, 4, 8, 5, 10, 9, 7, 3, 6]
        self._len = 10
        self._year = 0  # година на раждане
        self._month = 0 # месец
        self._day = 0   # ден

        self.sex = ''

        self.check()

    def set_value(self, str_egn):
        self._value = str_egn

    def get_value(self):
        return self._value

    value = property(get_value, set_value)



    def check(self, checkmode = False):

        try:
            int(self._value)
        except ValueError:
            self.errors.append('Грешни знаци в ЕГН')
        if len(self._value) != self._len:
            self.errors.append('Грешен брой цифри в ЕГН')

        try:
            self._month  = int(self._value[0:6])
        except ValueError:
            self.errors.append('Символи различни от цифри в полетата за рожденна дата')
        else:
            self._month  = int(self._value[2:4])
            if self._month < 13:
                self._year = 1900 + int(self._value[0:2])
            elif (self._month > 20) and (self._month < 33):
                self._year = 1800 + int(self._value[0:2]) -20
                self._month -= 20
            elif (self._month > 40) and (self._month < 53):
                self._year = 2000 + int(self._value[0:2]) -40
                self._month -= 40
            self._day = int(self._value[4:6])

        controlsum = 0
        for i in range(self._len-1):
            try:
               controlsum += self._dweight[i] * int(self._value[i])
            except : pass

        controlsum = divmod(controlsum, 11)[1]
        if controlsum == 10:
            controlsum = 0

        if len(self._value) != self._len:
            self.errors.append('Грешна дължина -> ' + str(len(self._value)))
        else:
            if controlsum != int(self._value[self._ctrlpos]):
                self.errors.append('Грешно контролно число -> ' + str(controlsum))

        if not self.iserror():
            if divmod(int(self._value[8]), 2)[1] == 0: # дали е четно ако да то е лицето е мъж
                self.sex = 'Мъж'
            else:
                self.sex = 'Жена'

    # end Chech

    def get_Burthday(self):
        if not self.iserror():
            return datetime.datetime(self._year, self._month, self._day )
        else :
            return []
# Край на класа EGN

class LNCh(bg_id_check):

    def __init__(self, str_lnch):
        super().__init__(str_lnch)
        self._ctrlpos = 9
        self._dweight =[21, 19, 17, 13, 11, 9, 7, 3, 1]
        self._len = 10

        self.check()

    def set_value(self, str_egn):
        self._value = str_egn

    def get_value(self):
        return self._value

    value = property(get_value, set_value)

    def check(self, checkmode = False):

        try:
            int(self._value)
        except ValueError:
            self.errors.append('Грешни знаци в ЛНЧ')
        if len(self._value) != self._len:
            self.errors.append('Грешен брой цифри в ЛНЧ')

        controlsum = 0
        for i in range(self._len-1):
            try:
               controlsum += self._dweight[i] * int(self._value[i])
            except : pass

        controlsum = divmod(controlsum, 10)[1]

        if len(self._value) != self._len:
            self.errors.append('Грешна дължина -> ' + str(len(self._value)))
        else:
            if controlsum != int(self._value[self._ctrlpos]):
                self.errors.append('Грешно контролно число -> ' + str(controlsum))

    # end Chech
# Край на класа LNCh


class EIK9(bg_id_check):

    def __init__(self, str_eik9):
        super().__init__(str_eik9)
        self._ctrlpos = 8
        self._dweight =[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        self._len = 9

        self.check()

    def set_value(self, str_egn):
        self._value = str_egn

    def get_value(self):
        return self._value

    value = property(get_value, set_value)

    def check(self, checkmode = False):

        try:
            int(self._value)
        except ValueError:
            self.errors.append('Грешни знаци в ЕИК')
        if len(self._value) != self._len:
            self.errors.append('Грешен брой цифри в ЕИК')

        controlsum = 0
        for i in range(self._len-1):
            try:
               controlsum += self._dweight[i] * int(self._value[i])
            except : pass

        controlsum = divmod(controlsum, 11)[1]
        if controlsum == 10 :
            controlsum = 0
            for i in range(self._len - 1):
                try:
                    controlsum += self._dweight[i+2] * int(self._value[i])
                except:
                    pass

            controlsum = divmod(controlsum, 11)[1]
            if controlsum == 10 : controlsum = 0

        if len(self._value) != self._len:
            self.errors.append('Грешна дължина -> ' + str(len(self._value)))
        else:
            if controlsum != int(self._value[self._ctrlpos]):
                self.errors.append('Грешно контролно число -> ' + str(controlsum))

    # end Chech
# Край на класа EIK9

class IBAN(bg_id_check):

    def __init__(self, str_iban):
        super().__init__(str_iban)
        self._ctrlpos = 8
        self._dweight =[]
        self._len = 22
        self.__IBANchars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'

        self.check()

    def set_value(self, str_egn):
        self._value = str_egn
    def get_value(self):
        return self._value
    value = property(get_value, set_value)

    def get_print(self):
        s = ''
        for i in range(5):
            s = s + self._value[i*4:i*4+4] +' '
        return s + self._value[20:22]
    printvalue = property(get_print)


    def check(self, checkmode = False):

        if len(self._value) != self._len:
            self.errors.append('Грешен брой цифри в IBAN')
        for i in range(self._len):
           if not ( self._value[i] in self.__IBANchars):
               self.errors.append('Грешни знаци в IBAN')
        if not self.iserror() :
            tst=''
            ibn=self._value[4:22] + self._value[0:4]
            for i in range(22):
                tst = tst + str(self.__IBANchars.index(ibn[i]))
            if divmod(int(tst),97)[1] != 1 :
                self.errors.append('Грешна контрола в IBAN')
            else:
                self.errors.clear()
    # end Chech

def isEGN(s):
    # връща Истина ако egn  е  валидно ЕГН
    tst = EGN(s)
    if tst.errors == []:
        return True
    else:
        return False,tst.errors

def isLNCh(s):
    # връща Истина ако s  е  валидно ЛНЧ
    tst = LNCh(s)
    if tst.errors == []:
        return True
    else:
        return False, tst.errors

def isEIK(s):
    # връща Истина ако s е  валидно ЕИК
    # Да се направи проверка дали дължината е 13  и проверка за ЕИК13
    tst = EIK9(s)
    if tst.errors == []:
        return True
    else:
        return False, tst.errors

def isIBAN(s):
    # връща Истина ако s  е  валидeн IBAN
    tst = IBAN(s)
    if tst.errors == []:
        return True
    else:
        return False,tst.errors


